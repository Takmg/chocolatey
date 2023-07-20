$ErrorActionPreference = 'Stop';

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64 = 'https://github.com/aws/aws-sam-cli/releases/download/v1.92.0/AWS_SAM_CLI_64_PY3.msi'
$checksum64 = 'e6b3c4913a042397957655dba0ba2f904a2165f9b350e56709bfb68ea0cce1d4'

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
