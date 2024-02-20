<#
.SYNOPSIS
  Identify computer certificates on a Windows computer that will expire within the next 30 days.
.DESCRIPTION
  Functions as a Custom EXE sensor for PRTG to monitor certificate expiration.
.URL
  https://gist.github.com/IMJLA/4a2b66c5ef87a784f7b8f8cef2334c64
#>

param(

    # Name of the computer to search for expiring certificates
    [string]$ComputerName,

    # Number of days prior to certificate expiration at which PRTG alarms should be triggered
    [int]$Days = 30,

    # List of certificate thumbprints to ignore even if they are expired or expiring
    [string[]]$HashWhitelist,

    # Certificate Subject Name to ignore even if the certificates are expired or expiring. Match is performed using wildcards so use caution.
    [string]$SubjectWhitelist
    
)

if ($ComputerName) {
    $Certs = Invoke-Command -ComputerName $ComputerName -ScriptBlock {Get-ChildItem -Path 'cert:\localmachine\my' -Recurse}
}
else {
    $Certs = Get-ChildItem -Path 'cert:\localmachine\my' -Recurse
}
$ExpiredCerts = $Certs | Where-Object -FilterScript {
    $_.NotAfter -lt (Get-Date).AddDays($Days) -and
    $HashWhitelist -notcontains $_.Thumbprint
}

if ($SubjectWhitelist) {
    $ExpiredCerts = $ExpiredCerts | Where-Object -FilterScript {$_.SubjectName.Name -notlike "*$SubjectWhitelist*"}
}

$CertNames = ($ExpiredCerts.Name | Where-Object -FilterScript {$_ -ne ''}) -join ','
$CertFriendlyNames = ($ExpiredCerts.FriendlyName | Where-Object -FilterScript {$_ -ne ''}) -join ','

if ($ExpiredCerts.Count -eq 0) {
    $Message = "OK"
}
else {
    $Message = $ExpiredCerts.Thumbprint -join ','
}

Write-Output "$($ExpiredCerts.Count):$Message"