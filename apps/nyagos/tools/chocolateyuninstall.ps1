$ErrorActionPreference = 'Stop'; # stop on all errors
$installPath = Join-Path (Get-ToolsLocation) $env:ChocolateyPackageName
if (Test-Path $installPath) {
    Remove-Item -path $installPath -Recurse -Force
}

# no remove shortcut 
Write-Host ''
Write-Host '---------------------------------------------------'
Write-Host "Please manually delete the nyagos.lnk shortcut created on the desktop when installed."
Write-Host '---------------------------------------------------'
Write-Host ''