# Powershell Scripts for Anaconda

## CondaPythonEnv

Add scripts below to your powershell startup script `Microsoft.PowerShell_profile.ps1` and change `<path to ...>` to corresponding path.

```powershell
# Include CondaPythonEnv.ps1
. <path to ...>\PowerShell\scripts\Anaconda\CondaPythonEnv.ps1

# Set alias
Set-Alias act ActivatePythonEnv
Set-Alias dea DeactivatePythonEnv
```
