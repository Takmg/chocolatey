$ErrorActionPreference = 'Stop'; # stop on all errors
$destination = Join-Path (Get-ToolsLocation) $env:ChocolateyPackageName
$packageArgs = @{
    packageName    = $env:ChocolateyPackageName
    unzipLocation  = $destination
    softwareName   = 'nyagos*'
    url            = 'https://github.com/zetamatta/nyagos/releases/download/4.4.5_2/nyagos-4.4.5_2-windows-386.zip'
    url64bit       = 'https://github.com/zetamatta/nyagos/releases/download/4.4.5_2/nyagos-4.4.5_2-windows-amd64.zip'
    checksumType   = 'sha256' 
    checksumType64 = 'sha256' 
    checksum       = '412d66a95fd34bec825a7579335a59724125977c7ce55588bcaf81e918633d63'
    checksum64     = 'edc0f1411344a1b0b2b675e1609264a7cf670ae6895cf6a33777d90688d42f1a'
}

# Install nyagos
Install-ChocolateyZipPackage @packageArgs 

# Create Shortcut
$exename = Get-ChildItem( Join-Path $destination "*.exe")
$lnkpath = Join-Path ([Environment]::GetFolderPath('Desktop')) ($env:ChocolateyPackageName + ".lnk") 
Install-ChocolateyShortcut -ShortcutFilePath $lnkpath -TargetPath $exename[0].FullName
