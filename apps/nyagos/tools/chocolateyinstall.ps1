$ErrorActionPreference = 'Stop'; # stop on all errors
$destination = Join-Path (Get-ToolsLocation) $env:ChocolateyPackageName
$packageArgs = @{
    packageName    = $env:ChocolateyPackageName
    unzipLocation  = $destination
    softwareName   = 'nyagos*'
    url            = 'https://github.com/nyaosorg/nyagos/releases/download/4.4.13_3/nyagos-4.4.13_3-windows-386.zip'
    url64bit       = 'https://github.com/nyaosorg/nyagos/releases/download/4.4.13_3/nyagos-4.4.13_3-windows-amd64.zip'
    checksumType   = 'sha256' 
    checksumType64 = 'sha256' 
    checksum       = 'c519c133205fcf5808543b286050bae7b696de686c1aa7bed19ea964f4054c59'
    checksum64     = 'bd3dce4e51232834804ca10de1ea119e434f26ca5e2da680151827c1bd62dd97'
}

# Install nyagos
Install-ChocolateyZipPackage @packageArgs 

# Create Shortcut
$exename = Get-ChildItem( Join-Path $destination "*.exe")
$lnkpath = Join-Path ([Environment]::GetFolderPath('Desktop')) ($env:ChocolateyPackageName + ".lnk") 
Install-ChocolateyShortcut -ShortcutFilePath $lnkpath -TargetPath $exename[0].FullName
