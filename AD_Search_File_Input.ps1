# The Tech Variables is used to grab your username so the script can export the CSV file to a particular location
$Tech = $env:USERNAME
Write-host "Welcome to AD Search $tech"
#User list file path input 
$Userfile = Read-Host -Prompt "Please enter the file location of your user list"
$File = Get-Content -path "$Userfile"
# The Path Variable is used to place the exported CSV file in a location on your PC
$Path = "C:\Users\$Tech\Downloads\AD_USERS.CSV" 
Write-Host "Please wait verifying and exporting users"
#initializes an array for users 
$Users = @()
# The Users Variable is used to Get all users and filter through the desired properties wihtin the AD Accounnt
foreach($Username in $File){
    #Trims @imegcorp.com to simplify down to the username 
    $Username = $username.trim('@imegcorp.com')
    #Gets rid of any spaces 
    $username = $username.Trim()
    #checks for empty usernames to avoid errors 
    if ($username -eq ""){continue}
    #Trys to get the user via the username 
    try {
            $user = Get-ADUser -Identity $username -Property DisplayName, EmailAddress, Manager, Team, Memberof, Title, Department, Office, City, State, Country, Enabled -ErrorAction stop}
    catch {
        Write-Host "user not found in AD: $username"
        continue}
if ($user){
    #Adds Users to array
    $Users += [PSCustomObject]@{
        "Display"       = $user.DisplayName
        "Email"         = $user.EmailAddress
        "Title"         = $user.Title
        "Manager"       = if ($user.Manager) {(Get-ADUser -Identity $user.Manager -property DisplayName).DisplayName} else{""}
        "Department"    = $user.Department
        "Office"        = $user.Office
        "City"          = $user.City
        "State"         = $user.State
        "Country"       = $user.Country
        }
    }
}
#Exports the CSV File in UTF8 Encryption
if ($Users.count -gt 0){
$Users | Export-Csv -Path $Path -NoTypeInformation -Encoding utf8
#This lets the user of the script know where to locate the CSV file 
Write-Host "Export Completed, File will be located on C:\Users\$Tech\Downloads\ name of file is AD_USERS.CSV"}
Else{
    Write-Host "No valid users were found"
}