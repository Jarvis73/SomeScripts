oh-my-posh init pwsh --config ~/.my.omp.json | Invoke-Expression

chcp 65001 > $null
Set-PSReadLineOption -PredictionSource History

. D:\Library\Documents\PowerShell\SomeScripts\win_scripts\Anaconda\CondaPythonEnv.ps1
. D:\Library\Documents\PowerShell\SomeScripts\win_scripts\TerminalProxy\TerminalProxy.ps1
. D:\Library\Documents\PowerShell\SomeScripts\win_scripts\tools.ps1

Set-Alias act ActivatePythonEnv
Set-Alias dea DeactivatePythonEnv
Set-Alias fly Set-Proxy
Set-Alias land Clear-Proxy
Set-Alias whereis where.exe

function which ($cmd_)
{
    Write-Host (Get-Command $cmd_).Path
}