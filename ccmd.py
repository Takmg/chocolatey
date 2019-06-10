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
    print("下記使い方")
    print("{:<10}, {:<10}".format("Command", "need-args"))
    print("---------------------------")
    for kc, kv in COMMAND_LIST.items():
        print("{:<10}, {:<10}".format(kc, kv))


# ------------------------------------------------------------------------------
# global_functions :: pack
# ------------------------------------------------------------------------------
def pack(path, args):
    print('-----------------------------------------------------')
    os.chdir(path)
    subprocess.call('cpack', shell=True)

    # ファイルをtestディレクトリにコピー
    for file in glob.glob('*.nupkg'):
        shutil.copyfile(file, f'../../test/{file}')
        shutil.copyfile("../../test/template.xml", f"../../test/{os.path.splitext(file)[0]}.xml")
        print(f'{file}のコピーが終了しました。')
    print('-----------------------------------------------------')
    print()

# ------------------------------------------------------------------------------
# global_functions :: main
# ------------------------------------------------------------------------------
def main(cmd, args):

    # コマンドと引数が一致しているか確認し、一致していない場合は返る。
    arg_cnt = len(args) if args is not None else 0
    if cmd not in COMMAND_LIST or COMMAND_LIST[cmd] != arg_cnt:
        print(f"引数に誤りがあります。")
        print(f"{COMMAND_LIST.keys()}オプションのいずれかを指定し、正しい引数を指定して下さい。")
        return

    # helpだった場合の処理
    if cmd == 'help':
        help()
        return

    # Pythonファイルのパスに移動し、サブディレクトリを取得する
    os.chdir(os.path.dirname(os.path.abspath(__file__)))

    # アプリのサブディレクトリ一覧を絶対パスで取得
    curdir = os.getcwd()
    paths = [os.path.join(curdir, 'apps', f) for f in os.listdir('apps')]

    # 全サブディレクトリに対してコマンドを実行する。
    cmd_func = eval(cmd)
    for p in paths:
        cmd_func(p, args)

    print('処理が終了しました。')


# ------------------------------------------------------------------------------
# entry_point
# ------------------------------------------------------------------------------
if __name__ == '__main__':
    cmd, args = get_cmd_with_args()
    main(cmd, args)
