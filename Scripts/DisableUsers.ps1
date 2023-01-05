<#
.SYNOPSIS
  Disable accounts based on CSV file with header "Username".
  The file path has to be "C:\path\to\" and named "Users2Disable.csv" (case sensitive)
.DESCRIPTION
  Disables an AD account. Requires RunAsAdministrator permissions to run
.OUTPUTS
  IF user has been disabled or IF username not found or is already disabled 
#>

# Import
$users = Import-Csv C:\path\to\Users2Disable.csv

#Loop through the data in the variable and use the Get-ADUser cmdlet to retrieve the user object for each username. Then, use the Set-ADUser cmdlet to disable the user account if it is not already disabled. 

foreach ($user in $users)
{
    $username = $user.Username
    $ADUser = Get-ADUser -Filter "SamAccountName -eq '$username'" -Properties Enabled
    if ($ADUser.Enabled -eq $true)
    {
        Set-ADUser -Identity $ADUser -Enabled $false
        Write-Output "User $username has been disabled"
    }
    else
    {
        Write-Output "Error: either $username was not found or it is already disabled"
    }
}
