# Powershell 脚本

* [Microsoft.PowerShell_profile.ps1](/scripts/Microsoft.PowerShell_profile.ps1) Startup scripts
* [GetBingWallPaper.ps1](/scripts/GetBingWallPaper.ps1) Set Bing pictures to wallpaper everyday
* [CondaPythonEnv.ps1](/scripts/Anaconda/CondaPythonEnv.ps1) Activate/Deactivate Anaconda virtual environment in Powershell (Keep inside current powershell program)
* [tools.ps1](/scripts/tools.ps1) Some useful tools
    * `md5sum`
    * `sha256sum`


## Notice

This scripts are better to work with [Modified Oh-My-Posh](https://github.com/Jarvis73/oh-my-posh)


## Usage

Include the wanted scripts in the `Microsoft.PowerShell_profile.ps1` and `Microsoft.VSCode_profile.ps1` using dot operation (`.`). 

```pwsh
. /path/to/powershell/scripts/GetBingWalPaper.ps1
. /path/to/powershell/scripts/Anaconda/CondaPyThonEnv.ps1
. /path/to/powershell/scripts/tools.ps1
```

`Microsoft.PowerShell_profile.ps1` and `Microsoft.VSCode_profile.ps1` can be find/created in 

1. `<Windows Libdary>/Documents/WindowsPowerShell`, if you are using `Windows PowerShell`, or
2. `<Windows Libdary>/Documents/PowerShell`, if you are using `PowerShell Core`. 

*Note: Windows PowerShell and PowerShell Core are different.* 

> Although this repository started as a fork of the Windows PowerShell code base, changes made in this repository do not make their way back to Windows PowerShell 5.1 automatically. This also means that issues tracked here are only for PowerShell Core 6 and higher. Windows PowerShell specific issues should be reported with the Feedback Hub app, by choosing "Apps > PowerShell" in category.

See Github [PowerShell/PowerShell](https://github.com/PowerShell/PowerShell) for more details.

