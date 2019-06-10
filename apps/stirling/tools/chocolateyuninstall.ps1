$ErrorActionPreference = 'Stop'
 
$installPath = Join-Path (Get-ToolsLocation) $env:ChocolateyPackageName

if (Test-Path $installPath) {
    # Remove Shortcut
    $exename = Get-ChildItem( Join-Path $installPath "*.exe")
    $lnkpath = Join-Path ([Environment]::GetFolderPath('Desktop')) ($exename[0].BaseName + ".lnk")
    Remove-Item -path $lnkpath -Force

    # Remove Install File
    Remove-Item -path $installPath -Recurse -Force
}
