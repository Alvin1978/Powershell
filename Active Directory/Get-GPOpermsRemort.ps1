# https://github.com/vamdevmishra/MyScripts/blob/master/gpopermsreport.ps1

# Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser

$report = @()
$allgpos=Get-GPO -All
foreach($gpo in $allgpos)
 {
  
  $gpopermissions=Get-GPPermissions -Guid $gpo.id -All

  # to get the gpo permission seperately
    $gpoperms=@()
    foreach($gpopermission in $gpopermissions)
    {
     if($gpopermission.Trustee.sidtype -eq "WellKnownGroup") {$TrusteeType="Group"} else {$TrusteeType=$gpopermission.Trustee.sidtype}
      $object = [PSCustomObject]@{
        GPOName = $gpo.DisplayName
        Trustee = $gpopermission.Trustee.Name
        TrusteeType=$TrusteeType
        Permission=$gpopermission.Permission
        Inherited=$gpopermission.Inherited
        }

        $gpoperms+=$object
    }

  $report+=$gpoperms

 }
 
 $report | Export-Csv -NoTypeInformation gpoperm.csv




 <# Apply new GPO permissions
 https://github.com/vamdevmishra/MyScripts/blob/master/applygpoperms.ps1

 $perm = import-csv C:\Temp\gpoperm.csv
 $perm | %{Set-GPPermissions -Name $_.gpoName -TargetName $_.trustee -TargetType $_.trusteetype -PermissionLevel $_.Permission}

 #>