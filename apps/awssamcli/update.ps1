import-module au

$releases = 'https://github.com/aws/aws-sam-cli/releases'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyinstall.ps1" = @{
            "(^[$]url64\s*=\s*)('.*')"      = "`$1'$($Latest.URL64)'"
            "(^[$]checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    $url64 = $download_page.links | ? href -match 'AWS_SAM_CLI_64_PY3.msi' | select -First 1 -expand href
    $version = (Split-Path ( Split-Path $url64 ) -Leaf)
    $version = $version.Remove(0,1)
    $version = $version -replace '_', '.'

    $domain = 'https://github.com'
    @{
        URL64   = $domain + $url64
        Version = $version
    }
}

Update -ChecksumFor 64