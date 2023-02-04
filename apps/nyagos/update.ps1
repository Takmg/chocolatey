import-module au

$releases = 'https://api.github.com/repos/zetamatta/nyagos/releases/latest'

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"        = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*url64bit\s*=\s*)('.*')"   = "`$1'$($Latest.URL64)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
    }
}

function global:au_GetLatest {
    $download_data = Invoke-WebRequest -Uri $releases -UseBasicParsing | ConvertFrom-Json
    $url32 = $download_data.assets | ? name -match "windows-386.zip" | select -First 1  -expand browser_download_url
    $url64 = $url32 -replace 'windows-386.zip$', 'windows-amd64.zip'
    $version = $download_data.tag_name -replace 'v' , '' -replace '_', '.'

    @{
        URL32   = $url32
        URL64   = $url64
        Version = $version
    }
}

update -NoReadme