# https://www.prajwaldesai.com/get-public-ip-address-using-powershell/
# https://woshub.com/get-external-ip-powershell/

# GitHub URL
# https://github.com/Alvin1978/Powershell/blob/main/Azure/Get-PublicIP.ps1



# Other Alternatives:
# (Invoke-WebRequest -uri "http://ifconfig.me/ip").Content
# (Invoke-WebRequest -uri "https://api.ipify.org/").Content

# Get Public IP adress
function MyPublicIP {
(Invoke-RestMethod -Uri ('https://ipinfo.io/')).ip
}

$PublicIP = MyPublicIP
# $PublicIP = $null
MyPublicIP



# Get Private IP adress
<#
Function Get-IpAddress {
    Get-NetIPAddress -AddressFamily IPv4 -AddressState Preferred | `
    Where-Object { $_.PrefixOrigin -ne 'WellKnown' } | `
    Select-Object -ExpandProperty IPAddress
}
Get-IpAddress


#>

# Get Public IP adress from GitHub.
<#
https://github.com/Alvin1978/Powershell/blob/main/Azure/Get-PublicIP.ps1
https://raw.githubusercontent.com/Alvin1978/Powershell/main/Azure/Get-PublicIP.ps1

$ScriptFromGitHub = Invoke-WebRequest https://raw.githubusercontent.com/Alvin1978/Powershell/main/Azure/Get-PublicIP.ps1
Invoke-Expression $($ScriptFromGitHub.Content)

#>