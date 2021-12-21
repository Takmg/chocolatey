$ErrorActionPreference = 'Stop'; # stop on all errors
$destination = Join-Path (Get-ToolsLocation) $env:ChocolateyPackageName
$packageArgs = @{
    packageName    = $env:ChocolateyPackageName
    unzipLocation  = $destination
    softwareName   = 'nyagos*'
    url            = 'https://github.com/nyaosorg/nyagos/releases/download/4.4.11_0/nyagos-4.4.11_0-windows-386.zip'
    url64bit       = 'https://github.com/nyaosorg/nyagos/releases/download/4.4.11_0/nyagos-4.4.11_0-windows-amd64.zip'
    checksumType   = 'sha256' 
    checksumType64 = 'sha256' 
    checksum       = 'bc36f7235087006a056862fa84ce51eef2afe4ae8b93ee32cd0ebabd41b73bf7'
    checksum64     = '4c3fb26340ca64a931b860e447b67e586bdb5e707058824857cac05cce280377'
}

# Install nyagos
Install-ChocolateyZipPackage @packageArgs 

# Create Shortcut
$exename = Get-ChildItem( Join-Path $destination "*.exe")
$lnkpath = Join-Path ([Environment]::GetFolderPath('Desktop')) ($env:ChocolateyPackageName + ".lnk") 
Install-ChocolateyShortcut -ShortcutFilePath $lnkpath -TargetPath $exename[0].FullName
