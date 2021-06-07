$ErrorActionPreference = 'Stop'; # stop on all errors
$destination = Join-Path (Get-ToolsLocation) $env:ChocolateyPackageName
$packageArgs = @{
    packageName    = $env:ChocolateyPackageName
    unzipLocation  = $destination
    softwareName   = 'nyagos*'
    url            = 'https://github.com/zetamatta/nyagos/releases/download/4.4.9_7/nyagos-4.4.9_7-windows-386.zip'
    url64bit       = 'https://github.com/zetamatta/nyagos/releases/download/4.4.9_7/nyagos-4.4.9_7-windows-amd64.zip'
    checksumType   = 'sha256' 
    checksumType64 = 'sha256' 
    checksum       = '44c7451cbcf3b69112450166b0d6cf2971a8c4bfc4a6823d13b74841ab5ce501'
    checksum64     = '4e35ce35abf32f22d120e27b1910fd915ebacc88f8d67bee46ec868142663c44'
}

# Install nyagos
Install-ChocolateyZipPackage @packageArgs 

# Create Shortcut
$exename = Get-ChildItem( Join-Path $destination "*.exe")
$lnkpath = Join-Path ([Environment]::GetFolderPath('Desktop')) ($env:ChocolateyPackageName + ".lnk") 
Install-ChocolateyShortcut -ShortcutFilePath $lnkpath -TargetPath $exename[0].FullName
