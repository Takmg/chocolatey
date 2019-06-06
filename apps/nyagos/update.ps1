import-module au

$releases = 'https://github.com/zetamatta/nyagos/releases'

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
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    $url32 = $download_page.links | ? href -match 'windows-386.zip' | % href | select -First 1
    $url64 = $url32 -replace 'windows-386.zip$', 'windows-amd64.zip'
    $version = (Split-Path ( Split-Path $url32 ) -Leaf)
    $version = $version -replace '_', '.'

    $domin = 'https://github.com'
    @{
        URL32   = $domin + $url32
        URL64   = $domin + $url64
        Version = $version
    }
}

update