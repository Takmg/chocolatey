import-module au

$releases = 'https://api.github.com/repos/aws/aws-sam-cli/releases/latest'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyinstall.ps1" = @{
            "(^[$]url64\s*=\s*)('.*')"      = "`$1'$($Latest.URL64)'"
            "(^[$]checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
    }
}

function global:au_GetLatest {
    $download_data = &gh api $releases | ConvertFrom-Json
    $url64 = $download_data.assets | ? name -match "AWS_SAM_CLI_64_PY3" | select -First 1  -expand browser_download_url
    $version = $download_data.tag_name -replace 'v' , '' -replace '_', '.'

    @{
        URL64   = $url64
        Version = $version
    }
}

Update -ChecksumFor 64 -NoReadme