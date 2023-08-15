<#
Script Summary:
This PowerShell script is designed to perform the following tasks related to managing credentials and settings on a Windows system:

1. Remove Cached Microsoft Account Credentials:
   - It uses the `cmdkey` command to list and remove cached Microsoft account credentials stored on the system.

2. Remove Cached Phone Credentials (if Applicable):
   - It employs the `cmdkey` command to list and remove cached phone credentials stored on the system.

3. Disable Syncing of Microsoft Accounts and Phones:
   - It modifies the Windows Registry to disable the syncing of Microsoft accounts and phones on the system.

Each task is wrapped in a `try` and `catch` block to handle potential errors and provide informative messages about the success or failure of each operation.

Note: Run this script with administrative privileges and test it in a controlled environment before deploying it to production systems.

Author: Jeff
Date: August 8, 2023
#>

try {
    # Remove cached Microsoft account credentials
    $accounts = cmdkey /list | Where-Object { $_ -like "*MicrosoftAccount*" }
    foreach ($account in $accounts) {
        $accountName = $account -replace "Target: ", ""
        $null = cmdkey /delete:$accountName
    }

    Write-Host "Cached Microsoft account credentials removed successfully."
} catch {
    Write-Host "An error occurred: $($Error[0].Exception.Message)"
}


try {
    # Remove cached phone credentials (if applicable)
    $phoneAccounts = cmdkey /list | Where-Object { $_ -like "*Phone*" }
    foreach ($account in $phoneAccounts) {
        $accountName = $account -replace "Target: ", ""
        $null = cmdkey /delete:$accountName
    }

    Write-Host "Cached phone credentials removed successfully."
} catch {
    Write-Host "An error occurred: $($Error[0].Exception.Message)"
}



try {
    # Disable syncing of Microsoft accounts and phones
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\SettingSync" -Name "SyncEnabled" -Value 0

    Write-Host "Syncing of Microsoft accounts and phones disabled successfully."
} catch {
    Write-Host "An error occurred: $($Error[0].Exception.Message)"
}

