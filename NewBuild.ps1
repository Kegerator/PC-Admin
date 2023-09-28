##########
# Win10 Initial Setup Script
# Author: Jeff 
##########

<#

11/03/2021 Infinity Add Ons - Rename this PC

11/03/2021 Infinity Add Ons - Launch the install of the Simple Help client

11/03/2021 Service Tweaks - Stop Windows 11 from instsalling

12/17/2021 Network - Disbale Multicasting

12/30/2021 UI Tweaks - Show File Extensions in File Explorer
        UI Tweaks - Stop the Shareing Wizard

01/22/2022 Infinity Add Ons - Block 60% of Malware by turing on 
        Enable Virturual Machine Platform
        Enable Hyper Visore platform
        Core Isolation and Memrory integrity
        **** DISABLED - Too many problems installing software ****

01/24/2022 Network - Turn Ethernet power saving off
        Disable NetAdapterPowerManagement
        Disable Energy-Efficient Ethernet
        Disable Flow Control
        Disable Receive Side Scaling
        Disable Green Ethernet
        Disable Power Saving Mode
        Disable ARP Offload
        Disable NS Offload
        Disable TCP Checksum Offload (IPv4)
        Disable UDP Checksum Offload (IPv4)
        Disable Interrupt Moderation
        Disable Jumbo Frame
        Disable Jumbo Packet
        Disable Packet Priority & VLAN
        Disable Enable PME
        Disable Interrupt Moderation

09/02/2022 Enable Periodic Registry Backup

11/09/2022 - Infinity Add Ons
    Enable system restore
    Schedule the Restore Point to run every 63 days

01/30/2023 - Infinity Add Ons
    Schedule a job to do a simple cleanup the third Sunday of the month at 3:00 AM
    Schedule a reboot the third Sunday of the month at 6 AM

02/08/2023 - Privacy Settings
    Disable Offer to Save Passwords in Google Chrome for All Users
    Disable Save Passwords in Microsoft Edge

02/09/2023 - Privacy Settings
    Block users from adding Microsoft Accounts
    ***This would block them from using Office 365***
    Commented out this feature 

07/03/2023 - Infinity Add Ons
    Enable Windows Sandbox

08/17/2023 - UI Tweaks
    Hide Task View button on the task bar    
    Hide the widgets button on the task bar
    Remove Chat button on task bar
    Set the taskbar to the Left

#>

# If this does not run, run the following command to allow PowerShell scripts
#Set-ExecutionPolicy Unrestricted -Force

#This will self elevate the script so with a UAC prompt since this script needs to be run as an Administrator in order to function properly.
If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
    Write-Host "You didn't run this script as an Administrator. This script will self elevate to run as an Administrator and continue."
    Start-Process powershell.exe -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File `"{0}`"" -f $PSCommandPath) -Verb RunAs
    Exit
}

##########
# Infinity Add Ons
##########

# Looking for the Flash Drive
$USBDrive = (Get-WmiObject win32_diskdrive | Where-Object{$_.interfacetype -eq "USB"} | ForEach-Object{Get-WmiObject -Query "ASSOCIATORS OF {Win32_DiskDrive.DeviceID=`"$($_.DeviceID.replace('\','\\'))`"} WHERE AssocClass = Win32_DiskDriveToDiskPartition"} |  ForEach-Object{Get-WmiObject -Query "ASSOCIATORS OF {Win32_DiskPartition.DeviceID=`"$($_.DeviceID)`"} WHERE AssocClass = Win32_LogicalDiskToPartition"} | ForEach-Object{$_.deviceid})

# Copy the Tech files and Help to the PC
# Old Code: robocopy $USBDrive'\\Build\\Tech\\'  'C:\\Tech\\' /R:2 /W:1
$sourcePath = Join-Path -Path $USBDrive -ChildPath 'Build\Tech'
$destinationPath = 'C:\Tech'
Copy-Item -Path $sourcePath -Destination $destinationPath -Recurse -Force

# Old Code: robocopy 'C:\\Tech\\' 'C:\\ProgramData\\Microsoft\\Windows\\Start Menu\\Programs\\StartUp\\' 'Help.lnk' /R:2 /W:1
$sourcePath = 'C:\Tech'
$destinationPath = 'C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup'
$fileToCopy = 'Help.lnk'
Copy-Item -Path (Join-Path -Path $sourcePath -ChildPath $fileToCopy) -Destination $destinationPath -Force


# Insrtall Russian Language
$LanguageList = Get-WinUserLanguageList
$LanguageList.Add("ru")
Set-WinUserLanguageList $LanguageList -Confirm:$False

# Prompt the user for the new computer name and perform validation
do {
    $name = Read-Host 'Enter the new computer name'
    if ($name -match "^[a-zA-Z0-9-]+$") {
        $isValid = $true
    } else {
        Write-Host "Invalid computer name. The name can only contain letters, numbers, and hyphens."
        $isValid = $false
    }
} while (-not $isValid)

# Rename the computer
try {
    Rename-Computer -NewName $name 
} catch {
    Write-Host "An error occurred: $_"
}


# Launch the install of the Simple Help client
& 'C:\Tech\Remote Access-windows64-online.exe'

# Enable system restore on the PC
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore" -Name "DisableSR" -Type Dword -Value 1 

# Enable System Restore for C:
Enable-ComputerRestore -Drive "C:\"

# Set the Restore Storage Size
vssadmin resize shadowstorage /On=%SystemDrive% /For=%SystemDrive% /Maxsize=30GB

# Schedule the Restore Point to run every 63 days
schtasks /create /tn RestorePoint /tr "powershell.exe Checkpoint-Computer -Description RestorePoint" /sc daily /mo 63 /sd 11/09/2022 /st 22:00

<# This is desinged to be run every Sunday, it does the following.
    #Future function: Check for and apply updates to the script from GitHub
    Clears the print queue.
    Synchronizes the computer time with an internet time server.
    Resets the network connection.
    Installs the PSWindowsUpdate module (if not already installed).
    If it is the 3rd Sunday of the month:  Installs Windows updates accordingly.
    Clears the browser cache.
    Runs Disk Cleanup.
    Deletes temporary files and folders.
    Optimizes the C drive (and additional drives if added).
    If it is the 3rd Sunday of the month: 
        Checks for disk errors if any are found it will have a full check disk run on the next reboot.
        Restarts the computer.

The log file is located at C:\Tech\SundayCleaningLog.txt
#>
schtasks /Create /TN "Sunday Cleaning" /SC WEEKLY /D SUN /ST 00:01 /TR "powershell.exe -ExecutionPolicy Bypass -File C:\Tech\SundayCleaning.ps1" /RU SYSTEM /RL HIGHEST /F

# Enable Windows Sandbox
Enable-WindowsOptionalFeature -FeatureName "Containers-DisposableClientVM" -All -Online -NoRestart

# This function will run later
# This as been discontiued, It prevented software from installing
Function Block60 {
    $TextBoxOutput.Text += "Blocking 60% of Malware..."

    # Enable Virturual Machine Platform
    DISM /online /enable-feature /featurename:VirtualMachinePlatform /all

    # Enable Hyper Visore platform
    DISM /Online /Enable-Feature /FeatureName:HypervisorPlatform /all

    # Core Isolation and Memrory integrity
    # Set the location to the registry
    Set-Location -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios'
    # Create a new Key
    Get-Item -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios' | New-Item -Name 'HypervisorEnforcedCodeIntegrity' -Force
    # Create new items with values
    New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" -Name 'Enabled' -PropertyType DWord -Value 1
    # Get out of the Registry
    Pop-Location
}


##########
# Power
##########

# Set power to High
& powercfg.exe -x -monitor-timeout-ac 60
& powercfg.exe -x -monitor-timeout-dc 60
& powercfg.exe -x -disk-timeout-ac 0
& powercfg.exe -x -disk-timeout-dc 0
& powercfg.exe -x -standby-timeout-ac 0
& powercfg.exe -x -standby-timeout-dc 0
& powercfg.exe -x -hibernate-timeout-ac 0
& powercfg.exe -x -hibernate-timeout-dc 0
# Disable USB Selective Suspend 
& powercfg /SETDCVALUEINDEX SCHEME_CURRENT 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 0
# Disable hibernation/sleep
Start-Process 'powercfg.exe' -Verb runAs -ArgumentList '/h off'
# Disable Connected Standby (CSEnabled)
Set-ItemProperty -Path "HKLM:\SYSTEM\\CurrentControlSet\Control\Power" -Name "CSEnabled" -Type DWord -Value 0


##########
# Ninite Apps
##########
# A # in front means it won't install
$niniteapps = @(
    # ".net4.7",
    "7zip",
    # "adaware",
    # "aimp",
    # "air",
    # "audacity",
    # "avast",
    # "avg",
    # "avira",
    # "cccp",
    # "cdburnerxp",
    "chrome"
    # "classicstart",
    # "cutepdf",
    # "dropbox",
    # "eclipse",
    # "emule",
    # "essentials",
    # "evernote",
    # "everything",
    # "faststone",
    # "filezilla",
    # "firefox",
    # "foobar",
    # "foxit",
    # "gimp",
    # "glary",
    # "gom",
    # "googledrive",
    # "googleearth",
    # "greenshot",
    # "handbrake",
    # "imgburn",
    # "infrarecorder",
    # "inkscape",
    # "irfanview",
    # "itunes",
    # "java8",
    # "jdk8",
    # "jdkx8",
    # "keepass2",
    # "klitecodecs",
    # "launchy",
    # "libreoffice",
    # "malwarebytes",
    # "mediamonkey",
    # "mozy",
    # "musicbee",
    # "notepadplusplus",
    # "nvda",
    # "onedrive",
    # "openoffice",
    # "operaChromium",
    # "paint.net",
    # "pdfcreator",
    # "peazip",
    # "pidgin",
    # "putty",
    # "python",
    # "qbittorrent",
    # "realvnc",
    # "revo",
    # "shockwave",
    # "silverlight",
    # "skype",
    # "spotify",
    # "spybot2",
    # "steam",
    # "sugarsync",
    # "sumatrapdf",
    # "super",
    # "teamviewer12",
    # "teracopy",
    # "thunderbird",
    # "trillian",
    # "vlc",
    # "vscode",
    # "winamp",
    # "windirstat",
    # "winmerge",
    # "winrar",
    # "winscp",
    # "xnview"
)

# Download ninite and install the selected apps
Write-Host "Downloading Ninite ..."
    
$ofs = '-'
$niniteurl = "https://ninite.com/" + $niniteapps + "/ninite.exe"
$output = "C:\Ninite.exe"
   
Invoke-WebRequest $niniteurl -OutFile $output
& $output

Write-Host
Read-Host "Press ENTER when all applications have been installed by Ninite"

##########
# Disable Scheduled Tasks
##########

# schtasks /Change /TN "Microsoft\Windows\AppID\SmartScreenSpecific" /disable
schtasks /Change /TN "Microsoft\Windows\Application Experience\AitAgent" /disable
schtasks /Change /TN "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /disable
# schtasks /Change /TN "Microsoft\Windows\Application Experience\ProgramDataUpdater" /disable
# schtasks /Change /TN "Microsoft\Windows\Application Experience\StartupAppTask" /disable
schtasks /Change /TN "Microsoft\Windows\Autochk\Proxy" /disable
# schtasks /Change /TN "Microsoft\Windows\CloudExperienceHost\CreateObjectTask" /disable
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\BthSQM" /disable
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /disable
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" /disable
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Uploader" /disable
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /disable
# schtasks /Change /TN "Microsoft\Windows\Maintenance\WinSAT" /disable
# schtasks /Change /TN "Microsoft\Windows\PI\Sqm-Tasks" /disable
schtasks /Change /TN "Microsoft\Windows\Shell\FamilySafetyMonitor" /disable
schtasks /Change /TN "Microsoft\Windows\Shell\FamilySafetyRefresh" /disable
schtasks /Change /TN "Microsoft\Windows\Shell\FamilySafetyUpload" /disable
# schtasks /Change /TN "Microsoft\Windows\WindowsUpdate\Automatic App Update" /disable
schtasks /Change /TN "\Microsoft\Windows\Shell\FamilySafetyMonitor" /disable
schtasks /Change /TN "\Microsoft\Windows\Shell\FamilySafetyMonitorToastTask" /disable
schtasks /Change /TN "\Microsoft\Windows\Shell\FamilySafetyRefreshTask" /disable
# schtasks /Change /TN "\Microsoft\Windows\NetTrace\GatherNetworkInfo" /disable
schtasks /Change /TN "\Microsoft\Windows\Maps\MapsUpdateTask" /disable
schtasks /Change /TN "\Microsoft\Windows\Maps\MapsToastTask" /disable

schtasks /Change /TN "Microsoft\XblGameSave\XblGameSaveTask" /disable
schtasks /Change /TN "Microsoft\XblGameSave\XblGameSaveTaskLogon" /disable


##########
# Privacy Settings
##########

# Block users from adding Microsoft Accounts
# ***This would block them from using Office 365***
# 0 = Allow Microsoft Accounts
# 1 = Users can't add Microsoft Accounts
# 3 = Users can't add or log on with Microsoft accounts
# Write-Host "Block users from adding Microsoft Accounts"
# Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\Settings\AllowYourAccount" -Name "NoConnectedUser" -Type DWord -Value 1

# Disable Offer to Save Passwords in Google Chrome for All Users
# Define a function to disable the offer to save passwords in Google Chrome
function DisableChromePasswordManager {
    try {
        # Set the registry value to disable Chrome's Password Manager
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Google\Chrome" -Name "PasswordManagerEnabled" -Type DWord -Value 0

        # Output a success message
        Write-Host "Password Manager in Google Chrome has been disabled for all users."
    } catch {
        # Output a detailed error message if an exception occurs
        Write-Host "An error occurred while disabling Chrome's Password Manager:"
        Write-Host "$($_.Exception.Message)"
    }
}
# Call the function to disable Chrome's Password Manager
DisableChromePasswordManager


function DisableEdgeSavePasswords {
    Write-Host "Disabling password saving in Microsoft Edge..."
    try {
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Main" -Name "FormSuggest Passwords" -Type String -Value "no"

        # Output a success message
        Write-Host "Password saving in Microsoft Edge has been disabled."
    } catch {
        # Output a detailed error message if an exception occurs
        Write-Host "An error occurred while disabling password saving in Microsoft Edge:"
        Write-Host "$($_.Exception.Message)"
    }
}
# Call the function to disable password saving in Microsoft Edge
DisableEdgeSavePasswords

# Disable Sharing Wizzard
Write-Host "Disabling Sharing Wizzard"
try {
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "SharingWizardOn" -Type DWord -Value 0
} catch {
    Write-Host "An error occurred: $_.Exception.Message"
}

# Disable Telemetry
Write-Host "Disabling Telemetry..."
try {
    Set-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 0
} catch {
    Write-Host "An error occurred: $_.Exception.Message"
}

# Disable Wi-Fi Sense
Write-Host "Disabling Wi-Fi Sense..."
If (!(Test-Path "HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting")) {
New-Item -Path "HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" -Force | Out-Null
}
Set-ItemProperty -Path "HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" -Name "Value" -Type DWord -Value 0
Set-ItemProperty -Path "HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots" -Name "Value" -Type DWord -Value 0

# Check if the computer is a laptop or desktop, if it is a desktop disable Wi-Fi Sense
try {
    $computerSystem = Get-WmiObject -Class Win32_ComputerSystem -ErrorAction Stop
    $battery = Get-WmiObject -Class Win32_Battery -ErrorAction Stop

    if ($battery -eq $null) {
        Write-Host "This is a desktop computer."
        
        # Disable Wi-Fi Sense
        Write-Host "Disabling Wi-Fi Sense..."
        $wifiPolicyKeyPath = "HKLM:\Software\Microsoft\PolicyManager\default\WiFi"
        $wifiHotspotReportingPath = Join-Path -Path $wifiPolicyKeyPath -ChildPath "AllowWiFiHotSpotReporting"
        $wifiAutoConnectPath = Join-Path -Path $wifiPolicyKeyPath -ChildPath "AllowAutoConnectToWiFiSenseHotspots"

        if (!(Test-Path $wifiHotspotReportingPath)) {
            New-Item -Path $wifiHotspotReportingPath -Force | Out-Null
        }

        if (!(Test-Path $wifiAutoConnectPath)) {
            New-Item -Path $wifiAutoConnectPath -Force | Out-Null
        }

        Set-ItemProperty -Path $wifiHotspotReportingPath -Name "Value" -Type DWord -Value 0
        Set-ItemProperty -Path $wifiAutoConnectPath -Name "Value" -Type DWord -Value 0

        Write-Host "Wi-Fi Sense has been successfully disabled on this desktop computer."
    } else {
        Write-Host "This is a laptop computer. WiFi Sense has Not been disabled"
    }
} catch {
    Write-Host "An error occurred: $_"
}

# Enable SmartScreen Filter and Web Contect Evaluation
try {
    # Enable SmartScreen Filter
    Write-Host "Enabling SmartScreen Filter..."
    Set-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer" -Name "SmartScreenEnabled" -Type String -Value "Prompt"

    # Enable Web Content Evaluation
    Write-Host "Enabling Web Content Evaluation..."
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\AppHost" -Name "EnableWebContentEvaluation" -Type DWord -Value 1

    Write-Host "SmartScreen Filter and Web Content Evaluation have been successfully enabled."
} catch {
    Write-Host "An error occurred: $_"
}

# Disable Bing Search in Start Menu
try {
    Write-Host "Disabling Bing Search in Start Menu..."
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "BingSearchEnabled" -Type DWord -Value 0
    Write-Host "Bing Search in Start Menu has been successfully disabled."
} catch {
    Write-Host "An error occurred: $_"
}

# Disable Location Tracking
try {
    $locationTrackingRegistryPath1 = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}"
    $locationTrackingRegistryPath2 = "HKLM:\System\CurrentControlSet\Services\lfsvc\Service\Configuration"

    Write-Host "Disabling Location Tracking..."

    # Disable Location Tracking in Registry Path 1
    if (Test-Path $locationTrackingRegistryPath1) {
        Set-ItemProperty -Path $locationTrackingRegistryPath1 -Name "SensorPermissionState" -Type DWord -Value 0
        Write-Host "Location Tracking in Registry Path 1 has been disabled."
    } else {
        Write-Host "Location Tracking in Registry Path 1 is not found."
    }

    # Disable Location Tracking in Registry Path 2
    if (Test-Path $locationTrackingRegistryPath2) {
        Set-ItemProperty -Path $locationTrackingRegistryPath2 -Name "Status" -Type DWord -Value 0
        Write-Host "Location Tracking in Registry Path 2 has been disabled."
    } else {
        Write-Host "Location Tracking in Registry Path 2 is not found."
    }

    Write-Host "Location Tracking has been successfully disabled."
} catch {
    Write-Host "An error occurred: $_"
}


# Disable Feedback
Write-Host "Disabling Feedback..."
If (!(Test-Path "HKCU:\Software\Microsoft\Siuf\Rules")) {
New-Item -Path "HKCU:\Software\Microsoft\Siuf\Rules" -Force | Out-Null
}
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Siuf\Rules" -Name "NumberOfSIUFInPeriod" -Type DWord -Value 0
# Disable Feedback
Write-Host "Disabling Feedback..."

$siufRulesPath = "HKCU:\Software\Microsoft\Siuf\Rules"

if (-not (Test-Path $siufRulesPath)) {
    try {
        New-Item -Path $siufRulesPath -Force -ErrorAction Stop | Out-Null
    } catch {
        Write-Host "Error creating registry path: $($_.Exception.Message)"
        exit 1
    }
}

try {
    Set-ItemProperty -Path $siufRulesPath -Name "NumberOfSIUFInPeriod" -Type DWord -Value 0 -ErrorAction Stop
    Write-Host "Feedback disabled successfully."
} catch {
    Write-Host "Error setting registry property: $($_.Exception.Message)"
    exit 1
}

# Disable Advertising ID
Write-Host "Disabling Advertising ID..."

$advertisingInfoPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo"

if (-not (Test-Path $advertisingInfoPath)) {
    try {
        New-Item -Path $advertisingInfoPath -ErrorAction Stop | Out-Null
    } catch {
        Write-Host "Error creating registry path: $($_.Exception.Message)"
        exit 1
    }
}
try {
    Set-ItemProperty -Path $advertisingInfoPath -Name "Enabled" -Type DWord -Value 0 -ErrorAction Stop
    Write-Host "Advertising ID disabled successfully."
} catch {
    Write-Host "Error setting registry property: $($_.Exception.Message)"
    exit 1
}

# Disable Cortana
Write-Host "Disabling Cortana..."

$personalizationPath = "HKCU:\Software\Microsoft\Personalization\Settings"
$inputPersonalizationPath = "HKCU:\Software\Microsoft\InputPersonalization"
$trainedDataStorePath = "HKCU:\Software\Microsoft\InputPersonalization\TrainedDataStore"

try {
    # Disable Cortana in Personalization Settings
    if (-not (Test-Path $personalizationPath)) {
        New-Item -Path $personalizationPath -Force -ErrorAction Stop | Out-Null
    }
    Set-ItemProperty -Path $personalizationPath -Name "AcceptedPrivacyPolicy" -Type DWord -Value 0 -ErrorAction Stop

    # Disable Cortana in Input Personalization
    if (-not (Test-Path $inputPersonalizationPath)) {
        New-Item -Path $inputPersonalizationPath -Force -ErrorAction Stop | Out-Null
    }
    Set-ItemProperty -Path $inputPersonalizationPath -Name "RestrictImplicitTextCollection" -Type DWord -Value 1 -ErrorAction Stop
    Set-ItemProperty -Path $inputPersonalizationPath -Name "RestrictImplicitInkCollection" -Type DWord -Value 1 -ErrorAction Stop

    # Disable Cortana in Trained Data Store
    if (-not (Test-Path $trainedDataStorePath)) {
        New-Item -Path $trainedDataStorePath -Force -ErrorAction Stop | Out-Null
    }
    Set-ItemProperty -Path $trainedDataStorePath -Name "HarvestContacts" -Type DWord -Value 0 -ErrorAction Stop

    Write-Host "Cortana disabled successfully."
} catch {
    Write-Host "Error setting registry properties: $($_.Exception.Message)"
    exit 1
}





# Remove AutoLogger file and restrict directory
Write-Host "Removing AutoLogger file and restricting directory..."
$autoLoggerDir = "$env:PROGRAMDATA\Microsoft\Diagnosis\ETLLogs\AutoLogger"
If (Test-Path "$autoLoggerDir\AutoLogger-Diagtrack-Listener.etl") {
Remove-Item "$autoLoggerDir\AutoLogger-Diagtrack-Listener.etl"
}
icacls $autoLoggerDir /deny SYSTEM:`(OI`)`(CI`)F | Out-Null

# Stop and disable Diagnostics Tracking Service
Get-Service -Name DiagTrack | Set-Service -StartupType Disabled | Stop-Service
Get-Service -Name dmwappushservice | Set-Service -StartupType Disabled | Stop-Service




##########
# Service Tweaks
##########

# Stop Windows 11 from installing
Function Stop11 {
    $TextBoxOutput.Text += "Stopping Windows 11 from installing..."
    # Set the location to the registry
    Set-Location -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows'
    # Create a new Key
    Get-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows' | New-Item -Name 'WindowsUpdate' -Force
    # Create new items with values
    New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name 'TargetReleaseVersion' -PropertyType DWord -Value 1
    New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name 'TargetReleaseVersionInfo' -PropertyType String -Value "21H2"
    # Get out of the Registry
    Pop-Location
}
Stop11


# Remove Password Age Limit (Passwords never expire) #
net accounts /maxpwage:0

# Set to Eastern time zone
Set-TimeZone "Eastern Standard Time"

# Sync time to Internet 
net stop w32time
w32tm /unregister
w32tm /register
net start w32time
w32tm /resync

# Enable Auto Maintenance
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\" -Name "Maintenance" -Type DWord -Value 0

# Enable sharing mapped drives between users
Write-Host "Enabling sharing mapped drives between users..."
Set-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System" -Name "EnableLinkedConnections" -Type DWord -Value 1

# Restrict Windows Update P2P only to local network
Write-Host "Restricting Windows Update P2P only to local network..."
Set-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" -Name "DODownloadMode" -Type DWord -Value 1
If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\DeliveryOptimization")) {
New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\DeliveryOptimization" | Out-Null
}
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\DeliveryOptimization" -Name "SystemSettingsDownloadMode" -Type DWord -Value 3

# Enable Periodic Registry Backup
New-Item -Path "HKLM:SYSTEM\CurrentControlSet\Control\Session Manager\Configuration Manager" -Name "EnablePeriodicBackup" -Type DWord -Value 1
::
# Run the Registry Backup
schtasks /run /tn "\Microsoft\Windows\Registry\RegIdleBackup"

##########
# UI Tweaks
##########

# Hide Task View button on the task bar - Hide 0  Show 1
try {
    Write-Host "Hide Task View button on the task bar"
    Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name 'ShowTaskViewButton' -Type DWord -Value 0
} catch {
    Write-Host "An error occurred while modifying ShowTaskViewButton: $($_.Exception.Message)"
}

# Hide the widgets button on the task bar - Hide 0  Show 1
try {
    Write-Host "Hide widgets button on the task bar"
    Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name 'TaskbarDa' -Type DWord -Value 0
} catch {
    Write-Host "An error occurred while modifying TaskbarDa: $($_.Exception.Message)"
}

# Remove Chat button on task bar
try {
    Write-Host "Remvoe Chat button on the task bar"
    REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowTaskViewButton /t REG_DWORD /d 0 /f
    REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarMn /t REG_DWORD /d 0 /f
} catch {
    Write-Host "An error occurred while modifying registry values: $($_.Exception.Message)"
}

# Set the taskbar to the Left
try {
    Write-Host "Move the taskbar to the left..."
    New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarAl" -Value 0 -Force
} catch {
    Write-Host "An error occurred while moving the taskbar: $($_.Exception.Message)"
}

# Show all tray icons
Write-Host "Showing all tray icons..."
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer" -Name "EnableAutoTray" -Type DWord -Value 0

# Show known file extensions
Write-Host "Showing known file extensions..."
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Type DWord -Value 0

# Change default Explorer view to "Computer"
Write-Host "Changing default Explorer view to `"Computer`"..."
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "LaunchTo" -Type DWord -Value 1

# Remove Music icon from computer namespace
Write-Host "Removing Music icon from computer namespace..."
Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" -Recurse -ErrorAction SilentlyContinue
Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}" -Recurse -ErrorAction SilentlyContinue

# Add Desktop Icons
$registryPath1 = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu"
$registryPath2 = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel"
# Value of 0 = Added to Desktop : 1 = Remove from Desktop
$value = 0
#
$Names = @(
    # This PC
    "{20D04FE0-3AEA-1069-A2D8-08002B30309D}"
    # Contol Panel
    #"{5399E694-6CE5-4D6C-8FCE-1D8870FDCBA0}"
    # Network
    "{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}"
    # Recycle Bin
    "{645FF040-5081-101B-9F08-00AA002F954E}"
    # Users Files
    "{59031a47-3f72-44a7-89c5-5595fe6b30ee}"
)
#
foreach ($Name in $Names) {
    IF(!(Test-Path $registryPath1))   {
        New-Item -Path $registryPath1 -Force | Out-Null
        New-ItemProperty -Path $registryPath1 -Name $name -PropertyType DWORD -Value $value -Force | Out-Null
    }
    ELSE   {
        New-ItemProperty -Path $registryPath1 -Name $name -PropertyType DWORD -Value $value -Force | Out-Null
    }
    Pop-Location
    #
    IF(!(Test-Path $registryPath2))   {
        New-Item -Path $registryPath2 -Force | Out-Null
        New-ItemProperty -Path $registryPath2 -Name $name -PropertyType DWORD -Value $value -Force | Out-Null
    }
    ELSE   {
        New-ItemProperty -Path $registryPath2 -Name $name -PropertyType DWORD -Value $value -Force | Out-Null
    }
    Pop-Location
}

# Show File Extensions in File Explorer
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Type DWord -Value 0

# Stop the Shareing Wizard
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "UseSharingWizard" -Type DWord -Value 0

##########
# Remove unwanted applications
##########

# Remove News and Interest
New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Feeds" -Name "ShellFeedsTaskbarViewMode" -Type DWord -Value 2
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" -Name "EnableFeeds" -Type DWord -Value 0
#Remove News and Interest Using Powershell
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Feeds" -Name "ShellFeedsTaskbarViewMode" -Value 2
 


# Disable OneDrive
Write-Host "Disabling OneDrive..."
If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive")) {
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive" | Out-Null
}
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive" -Name "DisableFileSyncNGSC" -Type DWord -Value 1

# Set Photo Viewer as default for bmp, gif, jpg and png
Write-Host "Setting Photo Viewer as default for bmp, gif, jpg, png and tif..."
If (!(Test-Path "HKCR:")) {
New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT | Out-Null
}
ForEach ($type in @("Paint.Picture", "giffile", "jpegfile", "pngfile")) {
New-Item -Path $("HKCR:\$type\shell\open") -Force | Out-Null
New-Item -Path $("HKCR:\$type\shell\open\command") | Out-Null
Set-ItemProperty -Path $("HKCR:\$type\shell\open") -Name "MuiVerb" -Type ExpandString -Value "@%ProgramFiles%\Windows Photo Viewer\photoviewer.dll,-3043"
Set-ItemProperty -Path $("HKCR:\$type\shell\open\command") -Name "(Default)" -Type ExpandString -Value "%SystemRoot%\System32\rundll32.exe `"%ProgramFiles%\Windows Photo Viewer\PhotoViewer.dll`", ImageView_Fullscreen %1"
}

# Show Photo Viewer in "Open with..."
Write-Host "Showing Photo Viewer in `"Open with...`""
If (!(Test-Path "HKCR:")) {
New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT | Out-Null
}
New-Item -Path "HKCR:\Applications\photoviewer.dll\shell\open\command" -Force | Out-Null
New-Item -Path "HKCR:\Applications\photoviewer.dll\shell\open\DropTarget" -Force | Out-Null
Set-ItemProperty -Path "HKCR:\Applications\photoviewer.dll\shell\open" -Name "MuiVerb" -Type String -Value "@photoviewer.dll,-3043"
Set-ItemProperty -Path "HKCR:\Applications\photoviewer.dll\shell\open\command" -Name "(Default)" -Type ExpandString -Value "%SystemRoot%\System32\rundll32.exe `"%ProgramFiles%\Windows Photo Viewer\PhotoViewer.dll`", ImageView_Fullscreen %1"
Set-ItemProperty -Path "HKCR:\Applications\photoviewer.dll\shell\open\DropTarget" -Name "Clsid" -Type String -Value "{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}"

# This script disables unwanted Windows services. If you do not want to disable
# certain services comment out the corresponding lines below.
$services = @(
    "diagnosticshub.standardcollector.service" # Microsoft (R) Diagnostics Hub Standard Collector Service
    "DiagTrack"                                # Diagnostics Tracking Service
    "dmwappushservice"                         # WAP Push Message Routing Service (see known issues)
    "lfsvc"                                    # Geolocation Service
    "MapsBroker"                               # Downloaded Maps Manager
    "NetTcpPortSharing"                        # Net.Tcp Port Sharing Service
    # "RemoteAccess"                           # Routing and Remote Access
    # "RemoteRegistry"                         # Remote Registry
    # "SharedAccess"                           # Internet Connection Sharing (ICS)
    "TrkWks"                                   # Distributed Link Tracking Client
    # "WbioSrvc"                               # Windows Biometric Service (required for Fingerprint reader / facial detection)
    #"WlanSvc"                                 # WLAN AutoConfig
    "WMPNetworkSvc"                            # Windows Media Player Network Sharing Service
    #"wscsvc"                                  # Windows Security Center Service
    #"WSearch"                                 # Windows Search
    "XblAuthManager"                           # Xbox Live Auth Manager
    "XblGameSave"                              # Xbox Live Game Save Service
    "XboxNetApiSvc"                            # Xbox Live Networking Service
    "ndu"                                      # Windows Network Data Usage Monitor
    # Services which cannot be disabled
    #"WdNisSvc"
)

foreach ($service in $services) {
    Write-Output "Trying to disable $service"
    Get-Service -Name $service | Set-Service -StartupType Disabled
}

#   Description:
# This script optimizes Windows updates by disabling automatic download and
# seeding updates to other computers.
Import-Module -DisableNameChecking $PSScriptRoot\..\lib\New-FolderForced.psm1
Write-Output "Disable seeding of updates to other computers via Group Policies"
New-FolderForced -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization"
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" "DODownloadMode" 0


# This script removes unwanted Apps that come with Windows. If you  do not want
# to remove certain Apps comment out the corresponding lines below.
Import-Module -DisableNameChecking $PSScriptRoot\..\lib\take-own.psm1
Import-Module -DisableNameChecking $PSScriptRoot\..\lib\New-FolderForced.psm1

Write-Output "Elevating privileges for this process"
do {} until (Elevate-Privileges SeTakeOwnershipPrivilege)

Write-Output "Uninstalling default apps"
$apps = @(
    # default Windows 10 apps
    "Microsoft.3DBuilder"
    "Microsoft.Advertising.Xaml"
    "Microsoft.Appconnector"
    "Microsoft.BingFinance"
    "Microsoft.BingNews"
    "Microsoft.BingSports"
    "Microsoft.BingTranslator"
    "Microsoft.BingWeather"
    #"Microsoft.FreshPaint"
    "Microsoft.GamingServices"
    "Microsoft.Microsoft3DViewer"
    "Microsoft.WindowsFeedbackHub"
    "Microsoft.MicrosoftOfficeHub"
    "Microsoft.MixedReality.Portal"
    "Microsoft.MicrosoftPowerBIForWindows"
    "Microsoft.MicrosoftSolitaireCollection"
    #"Microsoft.MicrosoftStickyNotes"
    "Microsoft.MinecraftUWP"
    "Microsoft.NetworkSpeedTest"
    "Microsoft.Office.OneNote"
    "Microsoft.People"
    "Microsoft.Print3D"
    "Microsoft.SkypeApp"
    "Microsoft.Wallet"
    # "Microsoft.Windows.Photos"
    # "Microsoft.WindowsAlarms"
    # "Microsoft.WindowsCalculator"
    # "Microsoft.WindowsCamera"
    "microsoft.windowscommunicationsapps"
    "Microsoft.WindowsMaps"
    "Microsoft.WindowsPhone"
    "Microsoft.WindowsSoundRecorder"
    #"Microsoft.WindowsStore"   # can't be re-installed
    "Microsoft.Xbox.TCUI"
    "Microsoft.XboxApp"
    "Microsoft.XboxGameOverlay"
    "Microsoft.XboxGamingOverlay"
    "Microsoft.XboxSpeechToTextOverlay"
    "Microsoft.YourPhone"
    "Microsoft.ZuneMusic"
    "Microsoft.ZuneVideo"
    "Microsoft.Windows.CloudExperienceHost"
    "Microsoft.Windows.ContentDeliveryManager"
    "Microsoft.Windows.PeopleExperienceHost"
    "Microsoft.XboxGameCallableUI"

    # Threshold 2 apps
    "Microsoft.CommsPhone"
    "Microsoft.ConnectivityStore"
    "Microsoft.GetHelp"
    "Microsoft.Getstarted"
    "Microsoft.Messaging"
    "Microsoft.Office.Sway"
    "Microsoft.OneConnect"
    "Microsoft.WindowsFeedbackHub"

    # Creators Update apps
    "Microsoft.Microsoft3DViewer"
    #"Microsoft.MSPaint"

    #Redstone apps
    "Microsoft.BingFoodAndDrink"
    "Microsoft.BingHealthAndFitness"
    "Microsoft.BingTravel"
    "Microsoft.WindowsReadingList"

    # Redstone 5 apps
    "Microsoft.MixedReality.Portal"
    "Microsoft.ScreenSketch"
    "Microsoft.XboxGamingOverlay"
    "Microsoft.YourPhone"

    # non-Microsoft
    "2FE3CB00.PicsArt-PhotoStudio"
    "46928bounde.EclipseManager"
    "4DF9E0F8.Netflix"
    "613EBCEA.PolarrPhotoEditorAcademicEdition"
    "6Wunderkinder.Wunderlist"
    "7EE7776C.LinkedInforWindows"
    "89006A2E.AutodeskSketchBook"
    "9E2F88E3.Twitter"
    "A278AB0D.DisneyMagicKingdoms"
    "A278AB0D.MarchofEmpires"
    "ActiproSoftwareLLC.562882FEEB491" # next one is for the Code Writer from Actipro Software LLC
    "CAF9E577.Plex"  
    "ClearChannelRadioDigital.iHeartRadio"
    "D52A8D61.FarmVille2CountryEscape"
    "D5EA27B7.Duolingo-LearnLanguagesforFree"
    "DB6EA5DB.CyberLinkMediaSuiteEssentials"
    "DolbyLaboratories.DolbyAccess"
    "DolbyLaboratories.DolbyAccess"
    "Drawboard.DrawboardPDF"
    "Facebook.Facebook"
    "Fitbit.FitbitCoach"
    "Flipboard.Flipboard"
    "GAMELOFTSA.Asphalt8Airborne"
    "KeeperSecurityInc.Keeper"
    "NORDCURRENT.COOKINGFEVER"
    "PandoraMediaInc.29680B314EFC2"
    "Playtika.CaesarsSlotsFreeCasino"
    "ShazamEntertainmentLtd.Shazam"
    "SlingTVLLC.SlingTV"
    "SpotifyAB.SpotifyMusic"
    "TheNewYorkTimes.NYTCrossword"
    "ThumbmunkeysLtd.PhototasticCollage"
    "TuneIn.TuneInRadio"
    "WinZipComputing.WinZipUniversal"
    "XINGAG.XING"
    "flaregamesGmbH.RoyalRevolt2"
    "king.com.*"
    "king.com.BubbleWitch3Saga"
    "king.com.CandyCrushSaga"
    "king.com.CandyCrushSodaSaga"

    # apps which cannot be removed using Remove-AppxPackage
    #"Microsoft.BioEnrollment"
    #"Microsoft.MicrosoftEdge"
    #"Microsoft.Windows.Cortana"
    #"Microsoft.WindowsFeedback"
    #"Microsoft.XboxGameCallableUI"
    #"Microsoft.XboxIdentityProvider"
    #"Windows.ContactSupport"

    # apps which other apps depend on
    "Microsoft.Advertising.Xaml"
)

<#
foreach ($app in $apps) {
    Write-Output "Trying to remove $app"

    Get-AppxPackage -Name $app -AllUsers | Remove-AppxPackage -AllUsers

    Get-AppXProvisionedPackage -Online |
        Where-Object DisplayName -EQ $app |
        Remove-AppxProvisionedPackage -Online
}
#>

ForEach ($App in $apps) {
    $PackageFullName = (Get-AppxPackage $App).PackageFullName
    $ProPackageFullName = (Get-AppxProvisionedPackage -online | Where-Object {$_.Displayname -eq $App}).PackageName
    write-host $PackageFullName
    Write-Host $ProPackageFullName
    if ($PackageFullName){
        Write-Host "Removing Package: $App"
        remove-AppxPackage -package $PackageFullName
    }
    else{
        Write-Host "Unable to find package: $App"
    }
    if ($ProPackageFullName) {
        Write-Host "Removing Provisioned Package: $ProPackageFullName"
        Remove-AppxProvisionedPackage -online -packagename $ProPackageFullName
    }
    else{
        Write-Host "Unable to find provisioned package: $App"
    }
 }


# Prevents Apps from re-installing
$cdm = @(
    "ContentDeliveryAllowed"
    "FeatureManagementEnabled"
    "OemPreInstalledAppsEnabled"
    "PreInstalledAppsEnabled"
    "PreInstalledAppsEverEnabled"
    "SilentInstalledAppsEnabled"
    "SubscribedContent-314559Enabled"
    "SubscribedContent-338387Enabled"
    "SubscribedContent-338388Enabled"
    "SubscribedContent-338389Enabled"
    "SubscribedContent-338393Enabled"
    "SubscribedContentEnabled"
    "SystemPaneSuggestionsEnabled"
)

New-FolderForced -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager"
foreach ($key in $cdm) {
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" $key 0
}

New-FolderForced -Path "HKLM:\SOFTWARE\Policies\Microsoft\WindowsStore"
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\WindowsStore" "AutoDownload" 2

# Prevents "Suggested Applications" returning
New-FolderForced -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent"
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" "DisableWindowsConsumerFeatures" 1

#   Description:
# This script will remove and disable OneDrive integration.
Import-Module -DisableNameChecking $PSScriptRoot\..\lib\New-FolderForced.psm1
Import-Module -DisableNameChecking $PSScriptRoot\..\lib\take-own.psm1

Write-Output "Kill OneDrive process"
taskkill.exe /F /IM "OneDrive.exe"
taskkill.exe /F /IM "explorer.exe"

Write-Output "Remove OneDrive"
if (Test-Path "$env:systemroot\System32\OneDriveSetup.exe") {
    & "$env:systemroot\System32\OneDriveSetup.exe" /uninstall
}
if (Test-Path "$env:systemroot\SysWOW64\OneDriveSetup.exe") {
    & "$env:systemroot\SysWOW64\OneDriveSetup.exe" /uninstall
}

Write-Output "Removing OneDrive leftovers"
Remove-Item -Recurse -Force -ErrorAction SilentlyContinue "$env:localappdata\Microsoft\OneDrive"
Remove-Item -Recurse -Force -ErrorAction SilentlyContinue "$env:programdata\Microsoft OneDrive"
Remove-Item -Recurse -Force -ErrorAction SilentlyContinue "$env:systemdrive\OneDriveTemp"
# check if directory is empty before removing:
If ((Get-ChildItem "$env:userprofile\OneDrive" -Recurse | Measure-Object).Count -eq 0) {
    Remove-Item -Recurse -Force -ErrorAction SilentlyContinue "$env:userprofile\OneDrive"
}

Write-Output "Disable OneDrive via Group Policies"
New-FolderForced -Path "HKLM:\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\OneDrive"
Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\OneDrive" "DisableFileSyncNGSC" 1

Write-Output "Remove Onedrive from explorer sidebar"
New-PSDrive -PSProvider "Registry" -Root "HKEY_CLASSES_ROOT" -Name "HKCR"
mkdir -Force "HKCR:\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}"
Set-ItemProperty -Path "HKCR:\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" "System.IsPinnedToNameSpaceTree" 0
mkdir -Force "HKCR:\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}"
Set-ItemProperty -Path "HKCR:\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" "System.IsPinnedToNameSpaceTree" 0
Remove-PSDrive "HKCR"

# This is from the Infinity Addons 
# **** Disabled too many problems ****
#Block60

# Thank you Matthew Israelsson
Write-Output "Removing run hook for new users"
reg load "hku\Default" "C:\Users\Default\NTUSER.DAT"
reg delete "HKEY_USERS\Default\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "OneDriveSetup" /f
reg unload "hku\Default"

Write-Output "Removing startmenu entry"
Remove-Item -Force -ErrorAction SilentlyContinue "$env:userprofile\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\OneDrive.lnk"

Write-Output "Removing scheduled task"
Get-ScheduledTask -TaskPath '\' -TaskName 'OneDrive*' -ea SilentlyContinue | Unregister-ScheduledTask -Confirm:$false

Write-Output "Restarting explorer"
Start-Process "explorer.exe"

Write-Output "Waiting for explorer to complete loading"
Start-Sleep 10

Write-Output "Removing additional OneDrive leftovers"
foreach ($item in (Get-ChildItem "$env:WinDir\WinSxS\*onedrive*")) {
    Takeown-Folder $item.FullName
    Remove-Item -Recurse -Force $item.FullName
}


# This script removes all Start Menu Tiles from the .default user #
Set-Content -Path 'C:\Users\Default\AppData\Local\Microsoft\Windows\Shell\DefaultLayouts.xml' -Value '<LayoutModificationTemplate xmlns:defaultlayout="http://schemas.microsoft.com/Start/2014/FullDefaultLayout" xmlns:start="http://schemas.microsoft.com/Start/2014/StartLayout" Version="1" xmlns="http://schemas.microsoft.com/Start/2014/LayoutModification">'
Add-Content -Path 'C:\Users\Default\AppData\Local\Microsoft\Windows\Shell\DefaultLayouts.xml' -value '  <LayoutOptions StartTileGroupCellWidth="6" />'
Add-Content -Path 'C:\Users\Default\AppData\Local\Microsoft\Windows\Shell\DefaultLayouts.xml' -value '  <DefaultLayoutOverride>'
Add-Content -Path 'C:\Users\Default\AppData\Local\Microsoft\Windows\Shell\DefaultLayouts.xml' -value '    <StartLayoutCollection>'
Add-Content -Path 'C:\Users\Default\AppData\Local\Microsoft\Windows\Shell\DefaultLayouts.xml' -value '      <defaultlayout:StartLayout GroupCellWidth="6" />'
Add-Content -Path 'C:\Users\Default\AppData\Local\Microsoft\Windows\Shell\DefaultLayouts.xml' -value '    </StartLayoutCollection>'
Add-Content -Path 'C:\Users\Default\AppData\Local\Microsoft\Windows\Shell\DefaultLayouts.xml' -value '  </DefaultLayoutOverride>'
Add-Content -Path 'C:\Users\Default\AppData\Local\Microsoft\Windows\Shell\DefaultLayouts.xml' -value '    <CustomTaskbarLayoutCollection>'
Add-Content -Path 'C:\Users\Default\AppData\Local\Microsoft\Windows\Shell\DefaultLayouts.xml' -value '      <defaultlayout:TaskbarLayout>'
Add-Content -Path 'C:\Users\Default\AppData\Local\Microsoft\Windows\Shell\DefaultLayouts.xml' -value '        <taskbar:TaskbarPinList>'
Add-Content -Path 'C:\Users\Default\AppData\Local\Microsoft\Windows\Shell\DefaultLayouts.xml' -value '          <taskbar:UWA AppUserModelID="Microsoft.MicrosoftEdge_8wekyb3d8bbwe!MicrosoftEdge" />'
Add-Content -Path 'C:\Users\Default\AppData\Local\Microsoft\Windows\Shell\DefaultLayouts.xml' -value '          <taskbar:DesktopApp DesktopApplicationLinkPath="%APPDATA%\Microsoft\Windows\Start Menu\Programs\System Tools\File Explorer.lnk" />'
Add-Content -Path 'C:\Users\Default\AppData\Local\Microsoft\Windows\Shell\DefaultLayouts.xml' -value '        </taskbar:TaskbarPinList>'
Add-Content -Path 'C:\Users\Default\AppData\Local\Microsoft\Windows\Shell\DefaultLayouts.xml' -value '      </defaultlayout:TaskbarLayout>'
Add-Content -Path 'C:\Users\Default\AppData\Local\Microsoft\Windows\Shell\DefaultLayouts.xml' -value '    </CustomTaskbarLayoutCollection>'
Add-Content -Path 'C:\Users\Default\AppData\Local\Microsoft\Windows\Shell\DefaultLayouts.xml' -value '</LayoutModificationTemplate>'

$START_MENU_LAYOUT = @"
<LayoutModificationTemplate xmlns:defaultlayout="http://schemas.microsoft.com/Start/2014/FullDefaultLayout" xmlns:start="http://schemas.microsoft.com/Start/2014/StartLayout" Version="1" xmlns:taskbar="http://schemas.microsoft.com/Start/2014/TaskbarLayout" xmlns="http://schemas.microsoft.com/Start/2014/LayoutModification">
    <LayoutOptions StartTileGroupCellWidth="6" />
    <DefaultLayoutOverride>
        <StartLayoutCollection>
            <defaultlayout:StartLayout GroupCellWidth="6" />
        </StartLayoutCollection>
    </DefaultLayoutOverride>
</LayoutModificationTemplate>
"@

$layoutFile="C:\Windows\StartMenuLayout.xml"

#Delete layout file if it already exists
If(Test-Path $layoutFile)
{
    Remove-Item $layoutFile
}

#Creates the blank layout file
$START_MENU_LAYOUT | Out-File $layoutFile -Encoding ASCII

$regAliases = @("HKLM", "HKCU")

#Assign the start layout and force it to apply with "LockedStartLayout" at both the machine and user level
foreach ($regAlias in $regAliases){
    $basePath = $regAlias + ":\SOFTWARE\Policies\Microsoft\Windows"
    $keyPath = $basePath + "\Explorer" 
    IF(!(Test-Path -Path $keyPath)) { 
        New-Item -Path $basePath -Name "Explorer"
    }
    Set-ItemProperty -Path $keyPath -Name "LockedStartLayout" -Value 1
    Set-ItemProperty -Path $keyPath -Name "StartLayoutFile" -Value $layoutFile
}

#Restart Explorer, open the start menu (necessary to load the new layout), and give it a few seconds to process
Stop-Process -name explorer
Start-Sleep -s 5
$wshell = New-Object -ComObject wscript.shell; $wshell.SendKeys('^{ESCAPE}')
Start-Sleep -s 5

#Enable the ability to pin items again by disabling "LockedStartLayout"
foreach ($regAlias in $regAliases){
    $basePath = $regAlias + ":\SOFTWARE\Policies\Microsoft\Windows"
    $keyPath = $basePath + "\Explorer" 
    Set-ItemProperty -Path $keyPath -Name "LockedStartLayout" -Value 0
}

#Restart Explorer and delete the layout file
Stop-Process -name explorer

# Uncomment the next line to make clean start menu default for all new users
Import-StartLayout -LayoutPath $layoutFile -MountPath $env:SystemDrive\

Remove-Item $layoutFile

# Prevents SYSPREP from freezing at "Getting Ready" on first boot                          #
# NOTE, DMWAPPUSHSERVICE is a Keyboard and Ink telemetry service, and potential keylogger. #
# It is recommended to disable this service in new builds, but SYSPREP will freeze/fail    #
# if the service is not running. If SYSPREP will be used, add a FirstBootCommand to your   #
# build to disable the service.                                                            #

reg delete "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\dmwappushservice" /v "DelayedAutoStart" /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\dmwappushservice" /v "DelayedAutoStart" /t REG_DWORD /d "1"
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\dmwappushservice" /v "Start" /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\dmwappushservice" /v "Start" /t REG_DWORD /d "2"
# Add the line below to FirstBootCommand in answer file #
# reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\RunOnce" /v "disabledmwappushservice" /t REG_SZ /d "sc config dmwappushservice start= disabled"

# Disable Privacy Settings Experience #
# Also disables all settings in Privacy Experience #
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\OOBE" /v "DisablePrivacyExperience" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\OOBE" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\OOBE" /v "DisablePrivacyExperience" /t REG_DWORD /d "1" /f
reg delete "HKEY_USERS\.DEFAULT\Software\Microsoft\Speech_OneCore\Settings\OnlineSpeechPrivacy" /v "HasAccepted" /f
reg add "HKEY_USERS\.DEFAULT\Software\Microsoft\Speech_OneCore" /f
reg add "HKEY_USERS\.DEFAULT\Software\Microsoft\Speech_OneCore\Settings" /f
reg add "HKEY_USERS\.DEFAULT\Software\Microsoft\Speech_OneCore\Settings\OnlineSpeechPrivacy" /v "HasAccepted" /t REG_DWORD /d "0" /f
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Speech_OneCore\Settings\OnlineSpeechPrivacy" /v "HasAccepted" /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Speech_OneCore" /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Speech_OneCore\Settings" /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Speech_OneCore\Settings\OnlineSpeechPrivacy" /v "HasAccepted" /t REG_DWORD /d "0" /f
reg delete "HKEY_USERS\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" /v "Value" /f
reg add "HKEY_USERS\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager" /f
reg add "HKEY_USERS\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore" /f
reg add "HKEY_USERS\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" /v "Value" /t REG_SZ /d "Deny" /f
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" /v "Value" /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager" /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore" /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" /v "Value" /t REG_SZ /d "Deny" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Settings\FindMyDevice" /v "LocationSyncEnabled" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Settings\FindMyDevice" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Settings\FindMyDevice" /v "LocationSyncEnabled" /t REG_DWORD /d "0" /f
reg delete "HKEY_USERS\.DEFAULT\SOFTWARE\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack" /v "ShowedToastAtLevel" /f
reg add "HKEY_USERS\.DEFAULT\SOFTWARE\Microsoft\Windows\CurrentVersion\Diagnostics" /f
reg add "HKEY_USERS\.DEFAULT\SOFTWARE\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack" /f
reg add "HKEY_USERS\.DEFAULT\SOFTWARE\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack" /v "ShowedToastAtLevel" /t REG_DWORD /d "1" /f
reg delete "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack" /v "ShowedToastAtLevel" /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Diagnostics" /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack" /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack" /v "ShowedToastAtLevel" /t REG_DWORD /d "1" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d "1" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "MaxTelemetryAllowed" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "MaxTelemetryAllowed" /t REG_DWORD /d "1" /f
reg delete "HKEY_USERS\.DEFAULT\Software\Microsoft\Input\TIPC" /v "Enabled" /f
reg add "HKEY_USERS\.DEFAULT\Software\Microsoft\Input" /f
reg add "HKEY_USERS\.DEFAULT\Software\Microsoft\Input\TIPC" /f
reg add "HKEY_USERS\.DEFAULT\Software\Microsoft\Input\TIPC" /v "Enabled" /t REG_DWORD /d "0" /f
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Input\TIPC" /v "Enabled" /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Input" /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Input\TIPC" /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Input\TIPC" /v "Enabled" /t REG_DWORD /d "0" /f
reg delete "HKEY_USERS\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Privacy" /v "TailoredExperiencesWithDiagnosticDataEnabled" /f
reg add "HKEY_USERS\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Privacy" /f
reg add "HKEY_USERS\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Privacy" /v "TailoredExperiencesWithDiagnosticDataEnabled" /t REG_DWORD /d "0" /f
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Privacy" /v "TailoredExperiencesWithDiagnosticDataEnabled" /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Privacy" /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Privacy" /v "TailoredExperiencesWithDiagnosticDataEnabled" /t REG_DWORD /d "0" /f
reg delete "HKEY_USERS\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /f
reg add "HKEY_USERS\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /f
reg add "HKEY_USERS\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d "0" /f
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d "0" /f

##########
# Network
##########

# Windows Auto-Tuning
netsh int tcp set global autotuninglevel=restricted
    # Disabled           No scale factor available Set the TCP receive window at its default value.  Good for small networks
    # Highly Restricted  0x2 (scale factor of 2)   Set the TCP receive window to grow beyond its default value, but do so very conservatively.
    # Restricted         0x4 (scale factor of 4)   Set the TCP receive window to grow beyond its default value, but limit such growth in some scenarios.  Good for large networks
    # Normal (default)   0x8 (scale factor of 8)   Set the TCP receive window to grow to accommodate almost all scenarios.
    # Experimental       0xE (scale factor of 14)  Set the TCP receive window to grow to accommodate extreme scenarios.

# Disable IPV6 on Ethernet 
Disable-NetAdapterBinding -Name Ethernet -ComponentID ms_tcpip6

# Set Networks to Private
Get-NetConnectionProfile | Where-Object { $_.NetworkCategory -match "Public" } | Set-NetConnectionProfile -NetworkCategory Private

# Enbale File Sharing 
netsh advfirewall firewall set rule group="File and Printer Sharing" new enable=Yes

# Set-NetFirewallRule -DisplayGroup "File And Printer Sharing" -Enabled True -Profile Any
Set-NetFirewallRule -DisplayGroup "File And Printer Sharing" -Enabled False -Profile Public
Set-NetFirewallRule -DisplayGroup "File And Printer Sharing" -Enabled True -Profile Private

# Disable Multicasting
REG ADD "HKLM\Software\Policies\Microsoft\Windows NT\DNSClient" /V "EnableMulticast" /D "0" /T REG_DWORD /F

# Network Power Settings
# Disable power management for the network adapter
try {
    Disable-NetAdapterPowerManagement -Name Ethernet
} catch {
    Write-Host "An error occurred while disabling power management: $($_.Exception.Message)"
}

# Set individual advanced properties for the network adapter
$advancedProperties = @(
    "Energy-Efficient Ethernet",
    "Flow Control",
    "Receive Side Scaling",
    "Green Ethernet",
    "Power Saving Mode",
    "ARP Offload",
    "NS Offload",
    "TCP Checksum Offload (IPv4)",
    "UDP Checksum Offload (IPv4)",
    "Interrupt Moderation",
    "Jumbo Frame",
    "Jumbo Packet",
    "Packet Priority & VLAN",
    "Enable PME"
)

foreach ($property in $advancedProperties) {
    try {
        Set-NetAdapterAdvancedProperty -Name Ethernet -DisplayName $property -DisplayValue "Disabled"
    } catch {
        Write-Host "An error occurred while setting advanced property '$property': $($_.Exception.Message)"
    }
}


##########
# Restart
##########

Write-Host
Write-Host "Press any key to restart your system..." -ForegroundColor Black -BackgroundColor White
$key = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
Write-Host "Restarting..."
Restart-Computer
