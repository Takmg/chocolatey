$ErrorActionPreference = 'Stop'; # stop on all errors

$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$destination = Join-Path (Get-ToolsLocation) $env:ChocolateyPackageName

$packageArgs = @{
    packageName = $env:ChocolateyPackageName
    destination = $destination
    file        = "$toolsPath\stir131.lzh"
}

Get-ChocolateyUnzip @packageArgs
Remove-Item $toolsPath\*.lzh -ea 0

# Create Shortcut
$exename = Get-ChildItem( Join-Path $destination "*.exe")
$lnkpath = Join-Path ([Environment]::GetFolderPath('Desktop')) ($exename[0].BaseName + ".lnk") 
Install-ChocolateyShortcut -ShortcutFilePath $lnkpath -TargetPath $exename[0].FullName
