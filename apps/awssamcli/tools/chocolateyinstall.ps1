$ErrorActionPreference = 'Stop';

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64 = 'https://github.com/aws/aws-sam-cli/releases/download/v1.132.0/AWS_SAM_CLI_64_PY3.msi'
$checksum64 = 'f3b9462b53f7b5f401dc6f6dc7a26243fbc0a92044d51e34a74788bb5461c8df'

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
