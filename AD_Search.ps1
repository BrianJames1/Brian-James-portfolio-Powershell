# The Tech Variables is used to grab your username so the script can export the CSV file to a particular location
$Tech = $env:USERNAME
Write-host "Welcome to AD Search $tech"
# The Path Variable is used to place the exported CSV file in a location on your PC
$Path = "C:\Users\$Tech\Downloads\AD_USERS.CSV" 
Write-Host "Please wait exporting users"
# The Users Variable is used to Get all users and filter through the desired properties wihtin the AD Accounnt
$Users = Get-ADUser -Filter * -Property DisplayName, EmailAddress, Manager, Title, Department, Office, City, State, Country, Enabled |
    Select-Object @{Name="Display";Expression={$_.DisplayName}},
                  @{Name="Email";Expression={$_.EmailAddress}},
                  @{Name="Title";Expression={$_.Title}},
                  @{Name="Manager";Expression={(Get-ADUser $_.Manager -property DisplayName).DisplayName}},
                  @{Name="Department";Expression={$_.Department}},
                  @{Name="Office";Expression={$_.Office}},
                  @{Name="City";Expression={$_.City}},
                  @{Name="State";Expression={$_.State}},
                  @{Name="Country";Expression={$_.Country}},
                  @{Name="Status";Expression={if ($_.Enabled) {"Enabled"} else {"Disabled"}}}
#Exports the CSV File in UTF8 Encryption
$Users | Export-Csv -Path $Path -NoTypeInformation -Encoding utf8
#This lets the user of the script know where to locate the CSV file 
Write-Host "Export Completed, File will be located on C:\Users\$Tech\Downloads\ name of file is AD_USERS.CSV"