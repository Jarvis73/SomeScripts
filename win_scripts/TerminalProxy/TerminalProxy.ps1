# Proxy settings

function Get-InternetProxy
 { 
    <# 
            .SYNOPSIS 
                Determine the internet proxy address
            .DESCRIPTION
                This function allows you to determine the the internet proxy address used by your computer
            .EXAMPLE 
                Get-InternetProxy
            .Notes 
                Author : Antoine DELRUE 
                WebSite: http://obilan.be 
    #> 

    $proxies = (Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings').proxyServer
    if ($proxies)
    {
        if ($proxies -ilike "*=*")
        {
            $proxies -replace "=","://" -split(';') | Select-Object -First 1
        }

        else
        {
            $proxies
        }
    }    
}

function Clear-Proxy
{
    # temporary
    Remove-Item env:HTTP_PROXY
    Remove-Item env:HTTPS_PROXY
    # Write-Host "`n   CLOSE powershell proxy channel!`n"
}

function Set-Proxy
{
    $proxy = Get-InternetProxy
    # temporary
    $env:HTTP_PROXY = $proxy
    $env:HTTPS_PROXY = $proxy
    # Write-Host "`n   OPEN powershell proxy channel!`n"
}