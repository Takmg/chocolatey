$ErrorActionPreference = 'Stop'
 
$installPath = Join-Path (Get-ToolsLocation) $env:ChocolateyPackageName

if (Test-Path $installPath) {
    # Remove Shortcut
    $lnkpath = Join-Path ([Environment]::GetFolderPath('Desktop')) ("Stirling.lnk")
    Remove-Item -path $lnkpath -Force

    # Remove Install File
    Remove-Item -path $installPath -Recurse -Force
}
