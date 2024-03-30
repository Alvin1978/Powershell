
# Determine if you have the AzureRM PowerShell module installed:
Get-Module -Name AzureRM -ListAvailable

# Set the PowerShell execution policy to remote signed:
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# Use the Install-Module cmdlet to install the Az PowerShell module:
Install-Module -Name Az -Repository PSGallery -Force

#Update the Az PowerShell module
Update-Module -Name Az -Force



#############################
# Connecting to Azure
## Authenticate to Azure tenant
Connect-AzAccount