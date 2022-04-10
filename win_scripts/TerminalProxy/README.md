# Powershell Scripts for Terminal Proxy

## TerminalProxy

Add scripts below to your powershell startup script `Microsoft.PowerShell_profile.ps1` and change `<path to ...>` to corresponding path.

```powershell
# Include TerminalProxy.ps1
. <path to ...>\PowerShell\scripts\TerminalProxy\TerminalProxy.ps1

# Set alias
Set-Alias fly Set-Proxy
Set-Alias land Clear-Proxy
```
