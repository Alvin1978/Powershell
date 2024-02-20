<#
https://kamilpro.com/powershell-for-it-professionals-18-working-with-text-strings/
#>


# String creation
$FirstName = "Kamil"
$Surname = "Procyszyn"

# String concatenation
"Hi, my name is " + $FirstName + " and my surname is " + $Surname.ToUpper() + ", it's nice to meet you."

# String interpolation
"Hi, my name is $FirstName and my surname is $($Surname.ToUpper()), it's nice to meet you."

# String with -f
"Hi, my name is {0} and my surname is {1}, it's nice to meet you." -f $FirstName, $Surname.ToUpper()

# Quotation marks
"$FirstName $SurName"
'$FirstName $SurName'
'{0} {1}' -f $FirstName, $Surname

# Joining string
$FullName = "$FirstName $Surname"
$FullName

# String as array
$FirstName[0]
$FirstName[-1]
$FirstName[0..2]

# String methods
$FirstName | Get-Member
$FirstName.ToLower()

$FullName
$FullName.IndexOf(' ')
$index = $FullName.IndexOf(' ')
$FullName.Substring($index + 1)

#Creating a username with three first letters of firstname, followed by underscore, followed by surname from full name
$FullName
$FullName.IndexOf(' ')
$index = $FullName.IndexOf(' ')

$Fir = $FullName.Substring(0, 3)
$Sur = $FullName.Substring($index + 1)
$Username = "{0}_{1}" -f $Fir, $Sur
$Username

### Select-String - Grep of PowerShell
### Don't confuse with Select/Select-Object

# Finding specific prase
vssadmin list shadows
vssadmin list shadows | Select-String 'creation time:'
vssadmin list shadows | Select-String 'creation time:' -Context 1
vssadmin list shadows | Select-String 'creation time:' -Context 0,4
vssadmin list shadows | Select-String 'creation time:' -Context 1,4

# Same with text files
Get-Content C:\Windows10Upgrade\upgrader_default.log
Get-Content C:\Windows10Upgrade\upgrader_default.log | Measure-Object
Get-Content C:\Windows10Upgrade\upgrader_default.log | Select-String "Error"

# Practical example - stripping time offset from w32tm
$time = w32tm /stripchart /computer:time.windows.com /dataonly /samples:1
$time
$time[-1]
$time[-1].Split(',')
$time[-1].Split(',')[-1]
$offset = $time[-1].Split(',')[-1]
$offset
$offset.IndexOf('.')
$offset = $offset.Substring(0, $offset.IndexOf('.'))
$offset.Trim()

# Regex - Regular expressions
$time | Select-String -Pattern '(\d+\.\d+s)$'
# We can check this website: https://regexr.com/