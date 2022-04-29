$ErrorActionPreference = 'Stop'; # stop on all errors
$destination = Join-Path (Get-ToolsLocation) $env:ChocolateyPackageName
$packageArgs = @{
    packageName    = $env:ChocolateyPackageName
    unzipLocation  = $destination
    softwareName   = 'nyagos*'
    url            = 'https://github.com/nyaosorg/nyagos/releases/download/4.4.12_0/nyagos-4.4.12_0-windows-386.zip'
    url64bit       = 'https://github.com/nyaosorg/nyagos/releases/download/4.4.12_0/nyagos-4.4.12_0-windows-amd64.zip'
    checksumType   = 'sha256' 
    checksumType64 = 'sha256' 
    checksum       = 'fa347bb5eb81de622f9225123a8e072a61188119adbd3dc74df21592ccc51e71'
    checksum64     = 'b450a64069a1e9aac3b2173a82510b550f3d1fca0be0659e1d17263e9b1295ed'
}

# Install nyagos
Install-ChocolateyZipPackage @packageArgs 

# Create Shortcut
$exename = Get-ChildItem( Join-Path $destination "*.exe")
$lnkpath = Join-Path ([Environment]::GetFolderPath('Desktop')) ($env:ChocolateyPackageName + ".lnk") 
Install-ChocolateyShortcut -ShortcutFilePath $lnkpath -TargetPath $exename[0].FullName
