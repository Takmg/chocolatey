$ErrorActionPreference = 'Stop'; # stop on all errors
$destination = Join-Path (Get-ToolsLocation) $env:ChocolateyPackageName
$packageArgs = @{
    packageName    = $env:ChocolateyPackageName
    unzipLocation  = $destination
    softwareName   = 'nyagos*'
    url            = 'https://github.com/zetamatta/nyagos/releases/download/4.4.9_2/nyagos-4.4.9_2-windows-386.zip'
    url64bit       = 'https://github.com/zetamatta/nyagos/releases/download/4.4.9_2/nyagos-4.4.9_2-windows-amd64.zip'
    checksumType   = 'sha256' 
    checksumType64 = 'sha256' 
    checksum       = 'd7989816213f6e036b367d8ae07a4b13c8623d7ba4123af8c2495bd290bbfaaf'
    checksum64     = 'd6ec9e93a3b11806a9cd5e2f5436d42dfb42f88769cd952f2bcc1bcd9bd21eec'
}

# Install nyagos
Install-ChocolateyZipPackage @packageArgs 

# Create Shortcut
$exename = Get-ChildItem( Join-Path $destination "*.exe")
$lnkpath = Join-Path ([Environment]::GetFolderPath('Desktop')) ($env:ChocolateyPackageName + ".lnk") 
Install-ChocolateyShortcut -ShortcutFilePath $lnkpath -TargetPath $exename[0].FullName
