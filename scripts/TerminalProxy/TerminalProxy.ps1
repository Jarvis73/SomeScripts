# Proxy settings
function Clear-Proxy-ZJW
{
    # temporary
    Remove-Item env:HTTP_PROXY
    Remove-Item env:HTTPS_PROXY
    Write-Host "`n   CLOSE powershell proxy channel!`n"
}

function Set-Proxy-ZJW
{
    $proxy = 'http://localhost:1080'
    # temporary
    $env:HTTP_PROXY = $proxy
    $env:HTTPS_PROXY = $proxy
    Write-Host "`n   OPEN powershell proxy channel!`n"
}