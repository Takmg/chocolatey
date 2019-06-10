$ErrorActionPreference = 'Stop'; # stop on all errors

$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$destination = Join-Path (Get-ToolsLocation) $env:ChocolateyPackageName

$packageArgs = @{
    packageName = $env:ChocolateyPackageName
    destination = $destination
    file        = "$toolsPath\MassiGra045.zip"
}

Get-ChocolateyUnzip @packageArgs
Remove-Item $toolsPath\*.zip -ea 0

# Create Shortcut
$exename = Get-ChildItem( Join-Path $destination "*.exe")
$lnkpath = Join-Path ([Environment]::GetFolderPath('Desktop')) ("MassiGra.lnk")
Install-ChocolateyShortcut -ShortcutFilePath $lnkpath -TargetPath $exename[0].FullName
