$ErrorActionPreference = 'Stop';

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64 = 'https://github.com/aws/aws-sam-cli/releases/download/v1.79.0/AWS_SAM_CLI_64_PY3.msi'
$checksum64 = 'cd6673cde7f2171835b1e9b6d36de96ef84d9bd78011fa92cd9f1d8228be7dbc'

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
