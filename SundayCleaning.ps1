<#
This is desinged to be run every Sunday, it does the following.
    #Future function: Check for and apply updates to the script from GitHub
    Clears the print queue.
    Synchronizes the computer time with an internet time server.
    Resets the network connection.
    Installs the PSWindowsUpdate module (if not already installed).
    Checks if it's the 3rd Sunday of the month and installs Windows updates accordingly.
    Clears the browser cache.
    Runs Disk Cleanup.
    Deletes temporary files and folders.
    Optimizes the C drive (and additional drives if added).
    if it is the 3rd Sunday
        Checks for disk errors if any are found it will have a full check disk run on the next reboot.
        Restarts the computer.

The log file is located at C:\Tech\SundayCleaningLog.txt

Ensure that the execution policy on the target system allows script execution.
    powershell.exe -ExecutionPolicy Bypass 

Copy this script to C:\Tech

Run this command as adminstator to schedule this script to be run every Sunday at 3:00 AM
        schtasks /Create /TN "SundayCleaningTask" /SC WEEKLY /D SUN /ST 03:00 /TR "powershell.exe -ExecutionPolicy Bypass -File C:\Tech\SundayCleaning.ps1" /RU SYSTEM /RL HIGHEST /F

.VERSION
    1.1.1
#>

function LogMessage {
    param(
        [string]$Message,
        [string]$LogFile = "C:\Tech\SundayCleaningLog.txt"
    )

    $LogEntry = "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') - $Message"
    $LogEntry | Out-File -FilePath $LogFile -Append
}

# Function to check if the current day is the 3rd Sunday of the month
function IsThirdSunday {
    $today = Get-Date
    $dayOfWeek = $today.DayOfWeek
    $weekOfMonth = [math]::ceiling($today.Day / 7)

    return ($dayOfWeek -eq 'Sunday' -and $weekOfMonth -eq 3)
}

# Function to check for and apply updates to the script from GitHub
function UpdateScriptFromGitHub {
    $githubRepoUrl = "https://github.com/Kegerator/PC-Admin/blob/main/SundayCleaning.ps1"
    $localScriptPath = "C:\Tech\SundayCleaning.ps1"

    try {
        $latestScript = Invoke-RestMethod -Uri $githubRepoUrl
        $encodedContent = $latestScript.content
        $decodedContent = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($encodedContent))

        # Get the local script version
        $localScriptVersion = (Get-Item $localScriptPath).VersionInfo.ProductVersion

        # Get the version of the script available on GitHub
        $githubScriptVersion = $decodedContent | Select-String -Pattern 'ProductVersion=(\d+\.\d+\.\d+\.\d+)' | ForEach-Object { $_.Matches.Groups[1].Value }

        # Compare versions
        if ([version]$githubScriptVersion -gt [version]$localScriptVersion) {
            $decodedContent | Set-Content -Path $localScriptPath -Force
            LogMessage "Script updated successfully from GitHub."
        } else {
            LogMessage "Local script is up to date. No update needed."
        }
    } catch {
        LogMessage "Failed to update the script from GitHub. Error: $_"
    }
}

function InstallPSWindowsUpdateModule {
    # Check if the PSWindowsUpdate module is installed
    $psWindowsUpdateModule = Get-Module -ListAvailable -Name PSWindowsUpdate

    if ($null -eq $psWindowsUpdateModule) {
        # If the module is not installed, attempt to install it from the PowerShell Gallery
        LogMessage "PSWindowsUpdate module is not installed. Installing it now..."
        try {
            Install-Module -Name PSWindowsUpdate -Force -AllowClobber -Scope CurrentUser
            LogMessage "PSWindowsUpdate module installed successfully."
        } catch {
            LogMessage "Failed to install the PSWindowsUpdate module. Error: $_"
        }
    } else {
        LogMessage "PSWindowsUpdate module is already installed."
    }
}

# Function to download and install updates using PSWindowsUpdate (for Windows 10)
function InstallUpdatesWin10 {
    LogMessage "Checking for updates using PSWindowsUpdate..."
    if (Get-Module -ListAvailable -Name PSWindowsUpdate) {
        Import-Module PSWindowsUpdate -ErrorAction Stop
        Get-WUInstall -AcceptAll
    } else {
        LogMessage "PSWindowsUpdate module not found. Please install it before running this script."
    }
}

# Function to download and install updates using WindowsUpdateProvider (for Windows 11)
function InstallUpdatesWin11 {
    LogMessage "Checking for updates using WindowsUpdateProvider..."
    try {
        $updateSession = New-Object -ComObject Microsoft.Update.Session
        $updateSearcher = $updateSession.CreateUpdateSearcher()
        $updates = $updateSearcher.Search("IsInstalled=0")
        if ($updates.Updates.Count -gt 0) {
            $updatesDownloader = $updateSession.CreateUpdateDownloader()
            $updatesDownloader.Updates = $updates.Updates
            $updatesDownloader.Download()
            $updatesInstaller = $updateSession.CreateUpdateInstaller()
            $updatesInstaller.Updates = $updates.Updates
            $installationResult = $updatesInstaller.Install()
            
            LogMessage "Updates installed successfully. Reboot is recommended to complete the update process."
        } else {
            LogMessage "No updates found."
        }
    } catch {
        LogMessage "Failed to check for or install updates. Error: $_"
    }
}


# Function to run Disk Cleanup
function RunDiskCleanup {
    LogMessage "Disk cleanup started."

    try {
        # Run the disk cleanup utility
        cleanmgr.exe -ArgumentList /sagerun:1

        LogMessage "Disk cleanup completed successfully."
    } catch {
        LogMessage "Failed to run disk cleanup. Error: $_"
    }
}


# Function to optimize drives
function OptimizeDrives {
    $drivesToOptimize = @("C", "D") # Add more drive letters here if needed

    foreach ($driveLetter in $drivesToOptimize) {
        LogMessage "Drive optimization started for Drive $driveLetter."

        try {
            Optimize-Volume -DriveLetter $driveLetter -Defrag -Verbose

            LogMessage "Drive optimization completed successfully for Drive $driveLetter."
        } catch {
            LogMessage "Failed to optimize Drive $driveLetter. Error: $_"
        }
    }
}


# Function to check disk errors
function CheckDiskErrors {
    LogMessage "Running Check Disk (non-destructive) for C: drive..."
    
    try {
        # Run chkdsk with /scan option for the C: drive
        & chkdsk C: /scan

        # Check the exit code of chkdsk to determine if any issues were found
        if ($LASTEXITCODE -eq 0) {
            LogMessage "Check Disk completed without errors."
        } else {
            LogMessage "Check Disk found errors or issues. Scheduling full scan and repair on the next reboot..."
            # Schedule full scan and repair on the next reboot
            & chkdsk C: /f /r
        }
    } catch {
        LogMessage "An error occurred while running Check Disk: $_"
    }
}
# function to clear the print queue
function ClearPrintQueue {
    $spoolerService = Get-Service -Name Spooler -ErrorAction SilentlyContinue

    if ($null -eq $spoolerService) {
        LogMessage "Print Spooler service is not installed or cannot be found."
        return
    }

    if ($spoolerService.Status -eq 'Running') {
        LogMessage "Stopping Print Spooler service..."
        Stop-Service -Name Spooler -Force

        # Wait a moment to ensure the service is stopped
        Start-Sleep -Seconds 5
    }

    $printJobs = Get-WmiObject -Query "Select * From Win32_PrintJob" -ErrorAction SilentlyContinue

    if ($null -ne $printJobs) {
        LogMessage "Deleting print jobs..."
        $printJobs | ForEach-Object {
            $_.Delete()
        }
    } else {
        LogMessage "No print jobs found in the queue."
    }

    LogMessage "Starting Print Spooler service..."
    Start-Service -Name Spooler
}

# function to sync the computer time to the internet
function SyncComputerTime {
    # Get the current system date and time
    $currentDateTime = Get-Date

    # Get the current internet time using the NTP (Network Time Protocol) server "time.windows.com"
    $ntpServer = "time.windows.com"
    try {
        $ntpResult = Invoke-WebRequest -Uri "http://$ntpServer" -UseBasicParsing
        $ntpTime = [DateTime]::ParseExact($ntpResult.Headers.Date, "ddd, dd MMM yyyy HH:mm:ss 'GMT'", [System.Globalization.CultureInfo]::InvariantCulture, [System.Globalization.DateTimeStyles]::AssumeUniversal)
    } catch {
        LogMessage "Failed to retrieve internet time from $ntpServer. Ensure that you have internet connectivity."
        return
    }

    # Calculate the time difference between system time and internet time
    $timeDifference = $ntpTime - $currentDateTime

    # Set the system time to the internet time
    Set-Date -Date ($currentDateTime + $timeDifference)

    LogMessage "Computer time synced to internet time from $ntpServer."
}

# Delete Temp Files
Function DeleteTemp {
    $TempPath = "$env:USERPROFILE\AppData\Local\Temp"
    $RecentPath = "$env:USERPROFILE\Recent"
    $PrefetchPath = "C:\Windows\Prefetch"
    $WindowsTempPath = "C:\Windows\Temp"
    $InetCachePath = "$env:USERPROFILE\AppData\Local\Microsoft\Windows\INetCache"
    $CBSTempPath = "C:\Windows\Logs\CBS"

    Remove-FilesAndFolders -Path $TempPath
    Remove-FilesAndFolders -Path $RecentPath
    Remove-FilesAndFolders -Path $PrefetchPath
    Remove-FilesAndFolders -Path $WindowsTempPath
    Remove-FilesAndFolders -Path $InetCachePath
    Remove-FilesAndFolders -Path $CBSTempPath
}

# Clear browser cache
Function ClearBrowserCache {
    RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 8
    RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 2
}

function ResetNetworkConnection {
    # Store the current network configuration
    $networkConfig = Get-NetIPConfiguration | Where-Object { $_.InterfaceAlias -eq 'Ethernet' }  # Replace 'Ethernet' with your network adapter alias

    # Purge DNS resolver cache using ipconfig
    LogMessage "Purging DNS resolver cache..."
    ipconfig /flushdns

    # Check if the interface is configured for DHCP
    if ($networkConfig.Dhcp) {
        LogMessage "Skipping network reset as the interface is configured for DHCP."
        return
    }

    # Reset the network connection using netsh
    LogMessage "Resetting network connection..."
    netsh interface set interface $networkConfig.InterfaceAlias admin=DISABLED
    netsh interface set interface $networkConfig.InterfaceAlias admin=ENABLED

    # Sleep for a few seconds to allow the network to reset
    Start-Sleep -Seconds 5

    # Restore the static IP address, subnet mask, and gateway settings
    LogMessage "Restoring static IP settings..."
    netsh interface ipv4 set address name=$networkConfig.InterfaceAlias source=static address=$networkConfig.IPv4Address IPAddress=$networkConfig.IPAddress
    netsh interface ipv4 set address name=$networkConfig.InterfaceAlias source=static address=$networkConfig.IPv4Address IPAddress=$networkConfig.IPAddress mask=$networkConfig.IPv4Netmask
    netsh interface ipv4 set address name=$networkConfig.InterfaceAlias gateway=$networkConfig.IPv4DefaultGateway gwmetric=$networkConfig.IPv4DefaultGatewayMetric

    LogMessage "Network connection has been reset without losing static IP settings."
}

# Main Script
#UpdateScriptFromGitHub
ClearPrintQueue
SyncComputerTime
ResetNetworkConnection
if (IsThirdSunday) {
    InstallPSWindowsUpdateModule
    if ([System.Environment]::OSVersion.Version -ge [Version]"10.0.22000") {
        InstallUpdatesWin11
    } else {
        InstallUpdatesWin10
    }
} else {
    LogMessage "Today is not the 3rd Sunday of the month. No updates will be installed."
}
ClearBrowserCache
RunDiskCleanup
DeleteTemp
OptimizeDrives
if (IsThirdSunday) {
    CheckDiskErrors
    LogMessage "Restarting the computer..."
    Restart-Computer -Force

}