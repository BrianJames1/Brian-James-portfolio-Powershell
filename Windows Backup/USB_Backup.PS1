$USB_Location = Read-host -prompt "PLease enter the drive letter of the USB"
$ComputerName = gc env:computername 
$UserProfiles = Get-Childitem "C:\Users" -directory

$folders = @('Desktp','Downloads','Favorites','Documents','Pictures','AppData\Local\Morilla','AppData\Local\Google')

foreach ($UserProfile in $UserProfiles){
    foreach ($folder in $folders){
        $BackupSource = $UserProfile.Fullname + "\" + $folder
        $BackupDestination = $USB_Location + "\" + $ComputerName + "\" + $UserProfile.Name + "\" + $folder
        Copy-Item -ErrorAction silentlyContinue -Recurse -path $BackupSource -Destination $BackupDestination
    }
}