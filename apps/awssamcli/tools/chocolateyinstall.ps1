$ErrorActionPreference = 'Stop';

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64 = 'https://github.com/aws/aws-sam-cli/releases/download/v1.95.0/AWS_SAM_CLI_64_PY3.msi'
$checksum64 = 'feb7ff6aba81a225b74b479847abcb3a70a8c92b4ea5bfeadea59289fefe01f0'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $toolsDir
  fileType       = 'MSI'
  url64bit       = $url64
  softwareName   = 'AWS SAM Command Line Interface*'
  checksum64     = $checksum64
  checksumType64 = 'sha256'
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
