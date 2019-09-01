$ErrorActionPreference = 'Stop'; # stop on all errors
$destination = Join-Path (Get-ToolsLocation) $env:ChocolateyPackageName
$packageArgs = @{
    packageName    = $env:ChocolateyPackageName
    unzipLocation  = $destination
    softwareName   = 'nyagos*'
    url            = 'https://github.com/zetamatta/nyagos/releases/download/4.4.5_0/nyagos-4.4.5_0-windows-386.zip'
    url64bit       = 'https://github.com/zetamatta/nyagos/releases/download/4.4.5_0/nyagos-4.4.5_0-windows-amd64.zip'
    checksumType   = 'sha256' 
    checksumType64 = 'sha256' 
    checksum       = 'E5924AECCA9E8A142B6185F7068C04A1D75D44A0B3B91039C5CFA75D898CA458'
    checksum64     = 'CB68795A05C4632E906AF335FA413612B7897E4ABA9E6754635B204AA69F42ED'
}

# Install nyagos
Install-ChocolateyZipPackage @packageArgs 

# Create Shortcut
$exename = Get-ChildItem( Join-Path $destination "*.exe")
$lnkpath = Join-Path ([Environment]::GetFolderPath('Desktop')) ($env:ChocolateyPackageName + ".lnk") 
Install-ChocolateyShortcut -ShortcutFilePath $lnkpath -TargetPath $exename[0].FullName
