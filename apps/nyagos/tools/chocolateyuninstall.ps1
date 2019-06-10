$ErrorActionPreference = 'Stop'; # stop on all errors

$installPath = Join-Path (Get-ToolsLocation) $env:ChocolateyPackageName

if (Test-Path $installPath) {
    # Remove Shortcut
    $lnkpath = Join-Path ([Environment]::GetFolderPath('Desktop')) ($env:ChocolateyPackageName + ".lnk")
    if (Test-Path $lnkpath) {
        Remove-Item -path $lnkpath -Force
    }

    # Remove Package
    Remove-Item -path $installPath -Recurse -Force
}
