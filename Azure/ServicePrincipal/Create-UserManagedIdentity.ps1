# Create-UserManagedIdentity.ps1

<#
.SYNOPSIS
    A function to create an Azure User Managed Identity.
...

# Import the Check-MyAzAcntConnect.psm1
$modulePath = Join-Path -Path $PSScriptRoot -ChildPath "../Connect/Check-MyAzAcntConnect.psm1"
Import-Module $modulePath -Verbose

#>

# Assuming Check-MyAzAcntConnect.psm1 has been imported above...

function New-MyAzUserManagedIdentity() {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [hashtable]$variables
    )
    # Authenticate to Azure using the imported function
    Get-MyAzAccountFunc

    # Extract the variables from the hash table 
    $location = $variables["location"]
    $resourceGroupName = $variables["resourceGroupName"]
    # Dynamic naming for the managed identity with a timestamp suffix.
    $userManagedIdentityName = $variables["userManagedIdentityName"] + (Get-Date -Format 'yyyyMMddHHmmss')

    # Create a User Managed Identity
    New-AzUserAssignedIdentity -Location $location -ResourceGroupName $resourceGroupName -Name $userManagedIdentityName
}

# Import variables from the custom file and execute the function
...

New-MyAzUserManagedIdentity -variables $variables