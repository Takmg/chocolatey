$ErrorActionPreference = 'Stop'; # stop on all errors
$destination = Join-Path (Get-ToolsLocation) $env:ChocolateyPackageName
$packageArgs = @{
    packageName    = $env:ChocolateyPackageName
    unzipLocation  = $destination
    softwareName   = 'nyagos*'
    url            = 'https://github.com/zetamatta/nyagos/releases/download/4.4.9_0/nyagos-4.4.9_0-windows-386.zip'
    url64bit       = 'https://github.com/zetamatta/nyagos/releases/download/4.4.9_0/nyagos-4.4.9_0-windows-amd64.zip'
    checksumType   = 'sha256' 
    checksumType64 = 'sha256' 
    checksum       = '37f21c811d4c51f1fca0630eced16d1cb8c2600e683dbc60c10dbab8b275f720'
    checksum64     = '6901caae5c468388febaade13fee4e33d6f5ddf360c4b2b81bb7189b28e5c15e'
}

# Install nyagos
Install-ChocolateyZipPackage @packageArgs 

# Create Shortcut
$exename = Get-ChildItem( Join-Path $destination "*.exe")
$lnkpath = Join-Path ([Environment]::GetFolderPath('Desktop')) ($env:ChocolateyPackageName + ".lnk") 
Install-ChocolateyShortcut -ShortcutFilePath $lnkpath -TargetPath $exename[0].FullName
