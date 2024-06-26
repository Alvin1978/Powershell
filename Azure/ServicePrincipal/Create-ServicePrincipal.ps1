# Create-ServicePrincipal.ps1

# https://github.com/rachelf27/AzurePowerShellAutomation/blob/develop/Roles_Polcies/Create-ServicePrincipal.ps1

<#
.SYNOPSIS
    A function to create a new Azure Service Principal.

.DESCRIPTION
    This function creates a new Service Principal using a privileged Application authentication
    https://learn.microsoft.com/en-us/powershell/azure/create-azure-service-principal-azureps?view=azps-10.3.0#code-try-0

.PARAMETER variables
    A hashtable containing the variables needed for the operation.
    Add your variables to the AccountVariables.txt and change the filename to CustomVariables.txt
    I have added the .gitignore, CustomVariables.txt to ensure secure data will not be uploaded to GitHub.
    If preferred, any Secrets, add directly to the Key Vault and call the Key Vault Secrets for security.
#>

# Import the Check-MyAzAcntConnect.psm1
$ScriptRoot = "$env:OneDrive\code\GitHub\PowerShell\Azure"
$modulePathAzConnect = Join-Path -Path $ScriptRoot -ChildPath "\Connect\Check-MyAzAcntConnect.psm1"
Import-Module $modulePathAzConnect -Verbose

function New-MyAzServicePrincipal {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [hashtable]$variables
    )

    # Authenticate to Azure using the imported function
    Get-MyAzAccountFunc
    
    try {
        # Extract the Service Principal name from the hash table and append with timestamp
        $servicePrincipalName = "$($variables['servicePrincipalName'])$(Get-Date -Format 'yyMMddHHmm')"
        
        # Create the service principal and capture the password
        $sp = New-AzADServicePrincipal -DisplayName $servicePrincipalName
        $spPassword = $sp.PasswordCredentials.SecretText
        return $spPassword
    }
    catch {
        Write-Error "Error creating Service Principal: $_"
        return $null
    }  
}

# Import the variables from CustomVariables.txt
$variablesPath = Join-Path -Path $ScriptRoot -ChildPath "../CustomVariables.txt"

# Read the variables from CustomeVariables.txt
$variables = [ordered]@{}
Get-Content $variablesPath | Foreach-Object {
    $key, $value = $_.Split('=').Trim()
    $variables[$key] = $value
}

New-MyAzServicePrincipal -variables $variables
