# ------------------------------------------------------------------------------
# import files
# ------------------------------------------------------------------------------
import os
import sys
import glob
import shutil
import subprocess


# ------------------------------------------------------------------------------
# global variables
# ------------------------------------------------------------------------------
COMMAND_LIST = {
    'help': 0,
    'pack': 0,
    'update': 0,
    'clobber': 0,
}


# ------------------------------------------------------------------------------
# global_functions :: get_cmd_with_args
# ------------------------------------------------------------------------------
def get_cmd_with_args():
    argv = sys.argv
    cmd = args = None

    # コマンドと引数を取得する
    if len(argv) >= 2:
        cmd = argv[1]
    if len(argv) >= 3:
        args = argv[2:]

    # コマンドと引数リストを戻す。
    return cmd, args


# ------------------------------------------------------------------------------
# global_functions :: help
# ------------------------------------------------------------------------------
def help():

    # helpの表示
    print("\n下記使い方")
    print("{:<10}, {:<10}".format("Command", "need-args"))
    print("---------------------------")
    for kc, kv in COMMAND_LIST.items():
        print("{:<10}, {:<10}".format(kc, kv))
    print("---------------------------")
    print()


# ------------------------------------------------------------------------------
# global_functions :: pack
# ------------------------------------------------------------------------------
def pack(path, args):

    print()
    print('-----------------------------------------------------')

    # ディレクトリの変更を行い cpackコマンドを実行する。
    os.chdir(path)
    subprocess.call('cpack', shell=True)

    # ファイルをtestディレクトリにコピー
    for file in glob.glob('*.nupkg'):
        shutil.copyfile(file, f'../../test/{file}')
        shutil.copyfile("../../test/template.xml", f"../../test/{os.path.splitext(file)[0]}.xml")
        print(f'{file}のコピーが終了しました。')

    print('-----------------------------------------------------')


# ------------------------------------------------------------------------------
# global_functions :: update
# ------------------------------------------------------------------------------
def update(path, args):

    # update.ps1が存在する場合は実行する。
    os.chdir(path)
    if os.path.isfile('update.ps1'):
        print()
        print('-----------------------------------------------------')
        print(f'[{path}]のアップデート中...')
        ps = subprocess.Popen([
            'powershell.exe', '-ExecutionPolicy', 'Unrestricted', './update.ps1'],
            cwd=os.getcwd())
        ps.wait()
        print('-----------------------------------------------------')


# ------------------------------------------------------------------------------
# global_functions :: clobber
# ------------------------------------------------------------------------------
def clobber():

    # パッケージファイルとXMLファイルの一覧を取得
    fs = glob.glob("./**/*.nupkg", recursive=True)
    fs += [f for f in glob.glob("./test/*.xml") if not f.endswith('template.xml')]
    fs = sorted(list(set(fs)))

    if len(fs) >= 1:
        print()
        print('-----------------------------------------------------')

    # ファイルを削除
    for pkg in fs:
        os.remove(pkg)
        print(f"削除:{pkg}")

    if len(fs) >= 1:
        print('-----------------------------------------------------')


# ------------------------------------------------------------------------------
# global_functions :: main
# ------------------------------------------------------------------------------
def main(cmd, args):

    # コマンドと引数が一致しているか確認し、一致していない場合は返る。
    arg_cnt = len(args) if args is not None else 0
    if cmd not in COMMAND_LIST or COMMAND_LIST[cmd] != arg_cnt:
        print(f"引数に誤りがあります。")
        print(f"{COMMAND_LIST.keys()}オプションのいずれかを指定し、正しい引数を指定して下さい。")
        return False

    # helpだった場合の処理
    if cmd == 'help':
        help()
        return False

    # clobberだった場合の処理
    if cmd == 'clobber':
        clobber()
        return True

    # Pythonファイルのパスに移動し、サブディレクトリを取得する
    os.chdir(os.path.dirname(os.path.abspath(__file__)))

    # アプリのサブディレクトリ一覧を絶対パスで取得
    curdir = os.getcwd()
    paths = [os.path.join(curdir, 'apps', f) for f in os.listdir('apps')]

    # 全サブディレクトリに対してコマンドを実行する。
    cmd_func = eval(cmd)
    for p in paths:
        cmd_func(p, args)

    return True


# ------------------------------------------------------------------------------
# entry_point
# ------------------------------------------------------------------------------
if __name__ == '__main__':
    cmd, args = get_cmd_with_args()
    if main(cmd, args):
        print('\n処理が終了しました。\n')
