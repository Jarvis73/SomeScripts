Function Get-MD5-SUM {
    param (
        [parameter(Mandatory=$True)]
        # Provide path to file
        [string]$file
    )

    $sumval = Get-FileHash $file -Algorithm MD5 | Select-Object Hash -ExpandProperty Hash
    Write-Host $sumval  $file
}

Function Get-SHA256-SUM {
    param (
        [parameter(Mandatory=$True)]
        # Provide path to file
        [string]$file
    )

    $sumval = Get-FileHash $file -Algorithm SHA256 | Select-Object Hash -ExpandProperty Hash
    Write-Host $sumval  $file
}

Set-Alias md5sum Get-MD5-SUM
Set-Alias sha256sum Get-SHA256-SUM
