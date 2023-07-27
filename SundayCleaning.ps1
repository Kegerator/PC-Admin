<#
This is desinged to be run every Sunday, it does the following.
    Clears the print queue.
    Synchronizes the computer time with an internet time server.
    Resets the network connection.
    Installs the PSWindowsUpdate module (if not already installed).
    Checks if it's the 3rd Sunday of the month and installs Windows updates accordingly.
    Clears the browser cache.
    Runs Disk Cleanup.
    Deletes temporary files and folders.
    Optimizes the C drive (and additional drives if added).
    Checks for disk errors and fixes them if found.
    Restarts the computer if it is the 3rd Sunday.

Copy this script to C:\Tech

Run this command as adminstator to schedule this script to be run every Sunday at 3:00 AM
        schtasks /Create /TN "SundayCleaningTask" /SC WEEKLY /D SUN /ST 03:00 /TR "powershell.exe -ExecutionPolicy Bypass -File C:\Tech\SundayCleaning.ps1" /RU SYSTEM /RL HIGHEST /F

#>

# Function to check if the current day is the 3rd Sunday of the month
function IsThirdSunday {
    $today = Get-Date
    $dayOfWeek = $today.DayOfWeek
    $weekOfMonth = [math]::ceiling($today.Day / 7)

    return ($dayOfWeek -eq 'Sunday' -and $weekOfMonth -eq 3)
}

function Install-PSWindowsUpdateModule {
    # Check if the PSWindowsUpdate module is installed
    $psWindowsUpdateModule = Get-Module -ListAvailable -Name PSWindowsUpdate

    if ($psWindowsUpdateModule -eq $null) {
        # If the module is not installed, attempt to install it from the PowerShell Gallery
        Write-Host "PSWindowsUpdate module is not installed. Installing it now..."
        try {
            Install-Module -Name PSWindowsUpdate -Force -AllowClobber -Scope CurrentUser
            Write-Host "PSWindowsUpdate module installed successfully."
        } catch {
            Write-Host "Failed to install the PSWindowsUpdate module. Error: $_"
        }
    } else {
        Write-Host "PSWindowsUpdate module is already installed."
    }
}

# Function to download and install updates using PSWindowsUpdate (for Windows 10)
function InstallUpdatesWin10 {
    Write-Host "Checking for updates using PSWindowsUpdate..."
    if (Get-Module -ListAvailable -Name PSWindowsUpdate) {
        Import-Module PSWindowsUpdate -ErrorAction Stop
        Get-WUInstall -AcceptAll -AutoReboot
    } else {
        Write-Host "PSWindowsUpdate module not found. Please install it before running this script."
    }
}

# Function to download and install updates using WindowsUpdateProvider (for Windows 11)
function InstallUpdatesWin11 {
    Write-Host "Checking for updates using WindowsUpdateProvider..."
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
            if ($installationResult.RebootRequired) {
                Write-Host "Updates installed successfully. Reboot is required."
            } else {
                Write-Host "Updates installed successfully. No reboot required."
            }
        } else {
            Write-Host "No updates found."
        }
    } catch {
        Write-Host "Failed to check for or install updates. Error: $_"
    }
}

# Function to run Disk Cleanup
function Run-DiskCleanup {
    cleanmgr.exe -ArgumentList /sagerun:1
}

# Function to optimize drives
function Optimize-Drives {
    Optimize-Volume -DriveLetter "C" -Defrag -Verbose
    # If you have additional drives, add their letters and run Optimize-Volume for them as well.
    # For example:
    # Optimize-Volume -DriveLetter "D" -Defrag -Verbose
}

# Function to check disk errors
function Check-DiskErrors {
    chkdsk /f /r
}

# function to clear the print queue
function Clear-PrintQueue {
    $spoolerService = Get-Service -Name Spooler -ErrorAction SilentlyContinue

    if ($spoolerService -eq $null) {
        Write-Host "Print Spooler service is not installed or cannot be found."
        return
    }

    if ($spoolerService.Status -eq 'Running') {
        Write-Host "Stopping Print Spooler service..."
        Stop-Service -Name Spooler -Force

        # Wait a moment to ensure the service is stopped
        Start-Sleep -Seconds 5
    }

    $printJobs = Get-WmiObject -Query "Select * From Win32_PrintJob" -ErrorAction SilentlyContinue

    if ($printJobs -ne $null) {
        Write-Host "Deleting print jobs..."
        $printJobs | ForEach-Object {
            $_.Delete()
        }
    } else {
        Write-Host "No print jobs found in the queue."
    }

    Write-Host "Starting Print Spooler service..."
    Start-Service -Name Spooler
}

# function to sync the computer time to the internet
function Sync-ComputerTime {
    # Get the current system date and time
    $currentDateTime = Get-Date

    # Get the current internet time using the NTP (Network Time Protocol) server "time.windows.com"
    $ntpServer = "time.windows.com"
    try {
        $ntpResult = Invoke-WebRequest -Uri "http://$ntpServer" -UseBasicParsing
        $ntpTime = [DateTime]::ParseExact($ntpResult.Headers.Date, "ddd, dd MMM yyyy HH:mm:ss 'GMT'", [System.Globalization.CultureInfo]::InvariantCulture, [System.Globalization.DateTimeStyles]::AssumeUniversal)
    } catch {
        Write-Host "Failed to retrieve internet time from $ntpServer. Ensure that you have internet connectivity."
        return
    }

    # Calculate the time difference between system time and internet time
    $timeDifference = $ntpTime - $currentDateTime

    # Set the system time to the internet time
    Set-Date -Date ($currentDateTime + $timeDifference)

    Write-Host "Computer time synced to internet time from $ntpServer."
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

function Reset-NetworkConnection {
    # Store the current network configuration
    $networkConfig = Get-NetIPConfiguration | Where-Object { $_.InterfaceAlias -eq 'Ethernet' }  # Replace 'Ethernet' with your network adapter alias

    # Purge DNS resolver cache using ipconfig
    Write-Host "Purging DNS resolver cache..."
    ipconfig /flushdns

    # Check if the interface is configured for DHCP
    if ($networkConfig.Dhcp) {
        Write-Host "Skipping network reset as the interface is configured for DHCP."
        return
    }

    # Reset the network connection using netsh
    Write-Host "Resetting network connection..."
    netsh interface set interface $networkConfig.InterfaceAlias admin=DISABLED
    netsh interface set interface $networkConfig.InterfaceAlias admin=ENABLED

    # Sleep for a few seconds to allow the network to reset
    Start-Sleep -Seconds 5

    # Restore the static IP address, subnet mask, and gateway settings
    Write-Host "Restoring static IP settings..."
    netsh interface ipv4 set address name=$networkConfig.InterfaceAlias source=static address=$networkConfig.IPv4Address IPAddress=$networkConfig.IPAddress
    netsh interface ipv4 set address name=$networkConfig.InterfaceAlias source=static address=$networkConfig.IPv4Address IPAddress=$networkConfig.IPAddress mask=$networkConfig.IPv4Netmask
    netsh interface ipv4 set address name=$networkConfig.InterfaceAlias gateway=$networkConfig.IPv4DefaultGateway gwmetric=$networkConfig.IPv4DefaultGatewayMetric

    Write-Host "Network connection has been reset without losing static IP settings."
}

# Main Script
Clear-PrintQueue
Sync-ComputerTime
Reset-NetworkConnection
if (IsThirdSunday) {
    Install-PSWindowsUpdateModule
    if ([System.Environment]::OSVersion.Version -ge [Version]"10.0.22000") {
        InstallUpdatesWin11
    } else {
        InstallUpdatesWin10
    }
} else {
    Write-Host "Today is not the 3rd Sunday of the month. No updates will be installed."
}
ClearBrowserCache
Run-DiskCleanup
DeleteTemp
Optimize-Drives
Check-DiskErrors
Write-Host "Restarting the computer..."
if (IsThirdSunday) {
    Restart-Computer -Force
}