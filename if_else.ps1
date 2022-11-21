# https://www.computerperformance.co.uk/powershell/if-statement/


##EXAMPLE 1A: PLAIN ‘IF’
# PowerShell If Statement Simple Example
$Number = -10
If ($Number -gt 0) {"Bigger thanzero"}
else {"Number smaler than zero"}




##EXAMPLE 1B: POWERSHELL IF -NOT STATEMENT TO CHECK FOR A SERVICE
# PowerShell script to check whether a service is installed
Clear-Host
$Name = "Alerter"
$Service = Get-Service -display $Name -ErrorAction SilentlyContinue
If (-Not $Service) {
$Name + " is not installed on this computer."
}

# PowerShell If statement to check whether a service is installed
Clear-Host
$Name = "Print Spooler"
$Service = Get-Service -display $Name -ErrorAction SilentlyContinue
If (-Not $Service) {$Name + " is not installed on this computer."}
Else {$Name + " is installed."
$Name + "'s status is: " + $service.Status }

##EXAMPLE 1C: POWERSHELL IF STATEMENT TO CHECK IP ADDRESSES
# PowerShell If Statement To Test Ip Addresses
$i =1
$Ip = "192.168.1."
Write-Host "IP Address"
Write-Host "----------------------------------------"
Do { $Ip4th = $Ip + $i
$Pingy = Get-WmiObject Win32_PingStatus -f "Address='$Ip4th'"
If($Pingy.StatusCode -eq 0) {
"{0,0} {1,5} {2,5}" -f
$Pingy.Address, $Pingy.StatusCode," ON NETWORK"}
else
{"{0,0} {1,5} {2,5}" -f $Pingy.Address, $Pingy.StatusCode, " xxxxxxxxx"
}
$i++
}
until ($i -eq 20)


##EXAMPLE 1D: FILE CONTENT EXAMPLE OF PLAIN ‘IF’
# Help on PowerShell's if statements
Clear-Host
$File = Get-Help about_BeforeEach_AfterEach
If ($File -Match "The if Statement") {
"We have the correct help file"
}

##EXAMPLE 2A: ‘IF’ WITH ‘ELSE’
# Help on PowerShell's Else statements
Update-Help
$File = Get-Help about_BeforeEach_AfterEach
If ($File -Match "The if Statement") {"We have the correct help file"}
Else {"The string is wrong"}