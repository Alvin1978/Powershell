<#
https://kamilpro.com/powershell-for-it-professionals-17-scripting-part-4-parameters-running-remotely-and-formatting/
#>



[cmdletbinding()]
param(
    [string[]]$ComputerName = 'localhost'
)

Invoke-Command -ComputerName $ComputerName -ScriptBlock {
    Write-Verbose "Getting OS Info"
    $OS = Get-CimInstance -ClassName Win32_OperatingSystem
    
    Write-Verbose "Checking if its a server"
    $server = $false
    IF ($os.Caption -like "*Server*") { $server = $true }
    
    Write-Verbose "Retrieving IP configuration"
    $Network = Get-NetAdapter | 
        Where-Object { $_.Status -eq 'Up' } | Get-NetIPConfiguration
    
        Write-Verbose "Last updates"
    $Updates = Get-HotFix | 
        Sort-Object InstalledOn -Descending | Select-Object -First 5

    $result = [pscustomobject]@{
        'OSName'        = $OS.Caption
        'OSVersion'     = $OS.Version
        'OSInstallDate' = $OS.InstallDate
        'isServer'      = $Server
        'IPv4Address'   = $Network.IPv4Address.IPAddress
        'Gateway'       = $Network.IPv4DefaultGateway.nexthop
        'DNS'           = $Network.DNSServer | Where-Object { $_.AddressFamily -eq '2' } | Select-Object ServerADdresses -ExpandProperty ServerAddresses
        'Updates'       = $Updates.HotfixID | Out-String
    }
    Write-Verbose "Checking network connectivity"
    $pingGateway = Test-NetConnection -ComputerName $result.Gateway -InformationLevel Quiet
    $pingDNS = Test-NetConnection -ComputerName $result.DNS[0] -InformationLevel Quiet
    $pingWebsite = Test-NetConnection -ComputerName 'kamilpro.com' -InformationLevel Quiet

    
    $params = @{
        MemberType = 'NoteProperty'
        Value = $pingGateway
        Name = 'pingGateway'
    }
    $result | Add-Member @params
    
    $result | Add-Member -MemberType NoteProperty -Value $pingDNS -Name 'pingDNS'
    $result | Add-Member -MemberType NoteProperty -Value $pingWebsite -Name 'pingWebsite'
    # Installed roles – server only

    IF ($result.isServer = $true) {
        $roles= Get-WindowsFeature | 
            Where-Object { $_.Installed -eq $True -AND $_.FeatureType -eq 'Role' } |
            Select-Object Name -ExpandProperty Name
        $result | 
            Add-Member -MemberType NoteProperty -Value $roles -Name 'Roles'
    }

    return $result
}