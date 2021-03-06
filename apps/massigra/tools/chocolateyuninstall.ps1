$ErrorActionPreference = 'Stop'

$installPath = Join-Path (Get-ToolsLocation) $env:ChocolateyPackageName

if (Test-Path $installPath) {
    # Remove Shortcut
    $lnkpath = Join-Path ([Environment]::GetFolderPath('Desktop')) ("MassiGra.lnk")
    if (Test-Path $lnkpath) {
        Remove-Item -path $lnkpath -Force
    }

    # Remove Item
    Remove-Item -path $installPath -Recurse -Force
}
