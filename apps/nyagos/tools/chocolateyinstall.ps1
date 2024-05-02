$ErrorActionPreference = 'Stop'; # stop on all errors
$destination = Join-Path (Get-ToolsLocation) $env:ChocolateyPackageName
$packageArgs = @{
    packageName    = $env:ChocolateyPackageName
    unzipLocation  = $destination
    softwareName   = 'nyagos*'
    url            = 'https://github.com/nyaosorg/nyagos/releases/download/4.4.15_1/nyagos-4.4.15_1-windows-386.zip'
    url64bit       = 'https://github.com/nyaosorg/nyagos/releases/download/4.4.15_1/nyagos-4.4.15_1-windows-amd64.zip'
    checksumType   = 'sha256' 
    checksumType64 = 'sha256' 
    checksum       = 'b16286bc32f5786fe757c472be68e9b04648fc8a189c6ca3ab7a241d667d73b3'
    checksum64     = '9056649b7a52e2634db22c628a97c02834e16775b00442cb216d10038fa7049a'
}

# Install nyagos
Install-ChocolateyZipPackage @packageArgs 

# Create Shortcut
$exename = Get-ChildItem( Join-Path $destination "*.exe")
$lnkpath = Join-Path ([Environment]::GetFolderPath('Desktop')) ($env:ChocolateyPackageName + ".lnk") 
Install-ChocolateyShortcut -ShortcutFilePath $lnkpath -TargetPath $exename[0].FullName
