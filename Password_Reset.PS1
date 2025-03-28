do
{
    Write-host "Welcome to Password Checker"
    $user = Read-host -prompt "Please enter the users Username (FirstName.MI.LastName)"
    net user $user /domain
    $Expired = Read-Host -Prompt "Is the users Password Expired? Y or N"
    if($Expired -eq 'Y')
    {
        $Password = Read-Host -Prompt "Please enter a new Password for the user"
        Set-ADAccountPassword -Identity $user -Reset -NewPassword (ConvertTo-SecureString -AsPlainText "$Password" -Force)
        Set-ADUser -Identitiy "$User" -ChangePasswordAtLogon $true
    } 
    elseif ($Expired -eq 'N') 
    {
        Continue
    }
$Continue = Read-Host -prompt "Do you need to check another users password"
}While($Continue -eq 'Y')