$ErrorActionPreference = 'Stop'; # stop on all errors
$destination = Join-Path (Get-ToolsLocation) $env:ChocolateyPackageName
$packageArgs = @{
    packageName   = $env:ChocolateyPackageName
    unzipLocation = $destination
    softwareName  = 'stirling*'
    url           = 'http://ftp.vector.co.jp/10/71/2144/stir131.lzh'
    checksumType  = 'sha256' 
    checksum      = 'BBE9FB3D9B076ECC68B8D015F6435A171847657D1CF521653B625DC93C74D1FA'
}

# Install stirling
Install-ChocolateyZipPackage @packageArgs 

# Create Shortcut
$exename = Get-ChildItem( Join-Path $destination "*.exe")
$lnkpath = Join-Path ([Environment]::GetFolderPath('Desktop')) ("Stirling.lnk") 
Install-ChocolateyShortcut -ShortcutFilePath $lnkpath -TargetPath $exename[0].FullName
