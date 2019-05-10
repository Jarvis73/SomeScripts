Set-Alias ll Get-ChildItem
Set-Alias jn jupyter-notebook.exe
Set-Alias whereis where.exe

$Host.UI.RawUI.WindowTitle = "PowerShell"
$doc = [Environment]::GetFolderPath("MyDocuments")

Import-Module "Oh-My-Posh" -DisableNameChecking -NoClobber

function prompt
{
    $connection = "@"
    $begin = "$"
    if ($global:_GLOBAL_POWERSHELL_PROMPT -ne "") {
        Write-Host ("$global:_GLOBAL_POWERSHELL_PROMPT") -NoNewline -ForegroundColor DarkRed
    }
    Write-Host ("Jarvis ") -Nonewline -ForegroundColor DarkCyan
    Write-Host ("$connection ") -Nonewline -ForegroundColor Gray
    Write-Host $pwd.ProviderPath -NoNewLine -ForegroundColor Blue
    $realLASTEXITCODE = $LASTEXITCODE
    Write-VcsStatus
    $global:LASTEXITCODE = $realLASTEXITCODE
    Write-Host ("`n$begin") -nonewline -foregroundcolor DarkRed  
    return " "  
}

function Show-Color( [System.ConsoleColor] $color )  
{  
    $fore = $Host.UI.RawUI.ForegroundColor  
    $Host.UI.RawUI.ForegroundColor = $color  
    Write-Output ($color).toString()  
    $Host.UI.RawUI.ForegroundColor = $fore  
}  

function Show-AllColor  
{  
    Show-Color('Black')  
    Show-Color('DarkBlue')  
    Show-Color('DarkGreen')  
    Show-Color('DarkCyan')  
    Show-Color('DarkRed')  
    Show-Color('DarkMagenta')  
    Show-Color('DarkYellow')  
    Show-Color('Gray')  
    Show-Color('DarkGray')  
    Show-Color('Blue')  
    Show-Color('Green')  
    Show-Color('Cyan')  
    Show-Color('Red')  
    Show-Color('Magenta')  
    Show-Color('Yellow')  
    Show-Color('White')  
}  

