<#
.SYNOPSIS
  Unlock accounts based on CSV file with header "Username".
  The file path has to be "C:\ps\files\" and named "Users2Unlock.csv" (case sensitive)
.DESCRIPTION
  Unlocks an AD account that is locked due to too many failed login attempts. Requires RunAsAdministrator permissions to run
.OUTPUTS
  If the operation is successful, it displays a success message with the username that was unlocked. Otherwise, it displays an error message with the username.
#>

# Import the user names from the CSV file
Import-Module ActiveDirectory
$users = Import-Csv -Path 'C:\ps\files\Users2Unlock.csv'

# Loop through each user in the CSV file
foreach ($user in $users) {
    $username = $user.Username

    # Unblock the user account
    try {
        Unlock-ADAccount -Identity $username
        Write-Host "Successfully unlocked user account: $username"
    } catch {
        Write-Host "Error unlocking user account: $username"
    }
}

<#
Note: The above script assumes that the CSV file has a column with a header named "Username". 
#>