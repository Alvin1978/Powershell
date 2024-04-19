

# Powershell Get - (run these lines below one at a time (It could prompt Y/N for installing the NuGet provider))
Install-Module PowerShellGet -AllowClobber -Force    -- Install Module Powershell Get
Remove-Module Powershellget
Remove-Module PackageManagement
Import-Module Powershellget -MinimumVersion 2.2.5


# Azure
Install-Module Az               -- Install Az Module.
Update-PSResource Az -WhatIf    -- Simulate updating your Az modules.
Update-PSResource Az            -- Update your Az modules.

# Windows Update
Install-Module PSWindowsUpdate                      -- Install the module to run Windows Update in Powershell.
Get-WindowsUpdate                                   -- Check for Windows updates with PowerShell.
Get-WindowsUpdate -AcceptAll -Install -AutoReboot   -- Download and install all the available updates and reboot the system.
Install-WindowsUpdate                               -- Install the available Windows 10 updates.
Get-WindowsUpdate -Install -KBArticleID 'KB5031445' -- Download, install a specific update and reboot the system.