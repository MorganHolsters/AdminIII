<#
.SYNOPSIS
  Create AD account based on CSV file with headers "Username", "Name", "GivenName", "Surname", "DisplayName", "Email", "OU", and "Password".
  The file path has to be "C:\ps\files\" and named "Users2Add.csv" (case sensitive)
.DESCRIPTION
  Creates a AD account. Requires RunAsAdministrator permissions to run
.OUTPUTS
  1. If username has been created without errors : User Created successfully
  2. If username exists : The username already exists + no account creation
#>
# Import 
Import-Module ActiveDirectory

#Use the Import-Csv cmdlet to read the CSV file and store the data in a variable.
$users = Import-Csv C:\ps\files\Users2Add.csv

# Loop through the data in the variable and use the New-ADUser cmdlet to create a new user account for each record.
foreach ($user in $users)
{
    $username = $user.Username
    if (!(Get-ADUser -Filter "SamAccountName -eq '$username'"))
    {
        New-ADUser -SamAccountName $username -Name $user.Name -GivenName $user.GivenName -Surname $user.Surname -DisplayName $user.DisplayName -EmailAddress $user.Email -OrganizationalUnit $user.OU -Enabled $true -AccountPassword (ConvertTo-SecureString $user.Password -AsPlainText -Force) -ChangePasswordAtLogon $false
        Write-Output "User Created successfully : $username ($user.Name $user.Surname)
    }
    else
    {
        Write-Warning "The username: $username already exists. Please find a new one for this user: $user.Surname $user.GivenName
    }
}
<#
Note: The above script assumes that the CSV file has columns with headers named "Username", "Name", "GivenName", "Surname", "DisplayName", "Email", "OU", and "Password". 
#>