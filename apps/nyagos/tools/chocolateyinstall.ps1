$ErrorActionPreference = 'Stop'; # stop on all errors
$destination = Join-Path (Get-ToolsLocation) $env:ChocolateyPackageName
$packageArgs = @{
    packageName    = $env:ChocolateyPackageName
    unzipLocation  = $destination
    softwareName   = 'nyagos*'
    url            = 'https://github.com/nyaosorg/nyagos/releases/download/4.4.18_0/nyagos-4.4.18_0-windows-386.zip'
    url64bit       = 'https://github.com/nyaosorg/nyagos/releases/download/4.4.18_0/nyagos-4.4.18_0-windows-amd64.zip'
    checksumType   = 'sha256' 
    checksumType64 = 'sha256' 
    checksum       = 'a8990c5839b6ce4b9a3724e7574922aefa5801e53232ee4c445edb92f5fabd04'
    checksum64     = 'bf08e15876d80db8e25c47b9afc61217752b05b78817bedf1deab9ba059421c0'
}

# Install nyagos
Install-ChocolateyZipPackage @packageArgs 

# Create Shortcut
$exename = Get-ChildItem( Join-Path $destination "*.exe")
$lnkpath = Join-Path ([Environment]::GetFolderPath('Desktop')) ($env:ChocolateyPackageName + ".lnk") 
Install-ChocolateyShortcut -ShortcutFilePath $lnkpath -TargetPath $exename[0].FullName
