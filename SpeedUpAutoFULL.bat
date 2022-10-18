@echo off
CLS


mode con:cols=56 lines=9


::Check_Permissions
net session >nul 2>&1
if %errorLevel% == 0 (
    Echo ********************************************************
    Echo *****     Administrative permissions confirmed     *****
) else (
    Color 4F
    Echo ********************************************************
    Echo *****   Failure: Current permissions inadequate    *****
    Echo *****     You need Administrative permissions      *****
    Echo *****         for this to work properly            *****
    Echo ********************************************************
    Echo.
    Pause
    Color 7 
    )


mode con:cols=56 lines=220



:: Start 
Set SYear=%date:~10,4%
Set SMonth=%date:~4,2%
Set SDay=%date:~7,2%
Set StartTime=%Time:~0,5%
Echo.
Echo ********************************************************
Echo *****    .....This will take 2 to 6 hours.....     *****
Echo *****                                              *****
Echo ***** Enable and Create Restore Point              *****
Echo ***** Delete Temp Files                            *****
Echo ***** Start Disk Cleanup                           *****
Echo ***** Check Windows System Files, 4 checks         *****
Echo ***** Start Windows Updates                        *****
Echo ***** Start System Maintenance                     *****
Echo ***** Adjust visuals effects for best performance  *****
Echo ***** Disable Schduled Tasks                       *****
Echo ***** Set Power Scheme to High                     *****
Echo ***** Disable Telemetry and Location Tracking      *****
Echo ***** Clear any print jobs and restart the spooler *****
Echo ***** Disable Multicasting                         *****
Echo ***** Flush DNS and reset IP Stack                 *****
Echo ***** Sync time to the Internet                    *****
Echo ***** Create Restore Point                         *****
Echo ***** Schedule the Restore Point every 19 days     *****
Echo ***** Last cleanup and Reboot                      *****
Echo *****                                              *****
Echo ***** Start Time %SDay%-%SMonth%-%SYear%  %StartTime%
Echo ***** Start Time %SDay%-%SMonth%-%SYear%  %StartTime% >C:\Windows\Temp\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 
Echo ********************************************************
Echo ****               Log file located at             *****
Echo %temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt
ping -n 10 127.0.0.1 >nul: 2>nul:


:: Create Restore Point
Set TTime=%Time:~0,5%
Echo ***** Enable and Create Restore Point              *****
Echo ***** Enable and Create Restore Point              ***** >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 
Echo ***** 5 Minutes                                    *****
Echo ***** Time %TTime%
Echo ********************************************************
:: Enable system restore
Reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore" /v DisableSR /t REG_DWORD /d 1 /f
ping -n 10 127.0.0.1 >nul: 2>nul:
:: Create a Restore Point
Wmic.exe /Namespace:\\root\default Path SystemRestore Call CreateRestorePoint "Before Running Speed Up Process", 100, 12 >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 240 127.0.0.1 >nul: 2>nul:


:: Deleting Temp Files
Set TTime=%Time:~0,5%
Echo ********************************************************
Echo ***** Deleting Temp Files                          *****
Echo ***** Deleting Temp Files                          ***** >>C:\Windows\Temp\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 
Echo ***** 5 Minutes                                    *****
Echo ***** Time %TTime%
Echo ********************************************************
ping -n 2 127.0.0.1 >nul: 2>nul:
del /s /f /q %USERPROFILE%\appdata\local\temp\*.* >>C:\Windows\Temp\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>NUL
ping -n 2 127.0.0.1 >nul: 2>nul:
copy C:\Windows\Temp\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt %temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt >NUL 2>>NUL
ping -n 2 127.0.0.1 >nul: 2>nul:
del /s /f /q %userprofile%\Recent\*.* >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 2 127.0.0.1 >nul: 2>nul:
del /s /f /q C:\Windows\Prefetch\*.* >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 2 127.0.0.1 >nul: 2>nul:
del /s /f /q C:\Windows\Temp\*.* >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 2 127.0.0.1 >nul: 2>nul:
del /s /f /q %USERPROFILE%\appdata\local\Microsoft\Windows\INetCache\*.* >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 2 127.0.0.1 >nul: 2>nul:
del /s /f /q C:\Windows\Logs\CBS\*.* >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 2 127.0.0.1 >nul: 2>nul:
:: Clear Temporary Internet File
RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 8 >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 2 127.0.0.1 >nul: 2>nul:
:: Clear Cookies: 
RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 2 >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 2 127.0.0.1 >nul: 2>nul:


:: Start Disk Cleanup
Set TTime=%Time:~0,5%
Echo ***** Start Disk Cleanup                           *****
Echo ***** Start Disk Cleanup                           ***** >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 
Echo ***** 5 Minutes                                    *****
Echo ***** Time %TTime%
Echo ********************************************************
c:\windows\SYSTEM32\cleanmgr /d C /verylowdisk  >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 10 127.0.0.1 >nul: 2>nul:


:: Check Windows System Files
Set TTime=%Time:~0,5%
Echo ***** Check Windows System Files, 4 checks         *****
Echo ***** Check Windows System Files, 4 checks         ***** >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 
Echo ***** 2 Hours                                      *****
Echo ***** Time %TTime%
Echo *****                                              *****
DISM /Online /Cleanup-Image /CheckHealth >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
Set TTime=%Time:~0,5%
Echo ***** Check #1 Done %TTime%                        *****
ping -n 10 127.0.0.1 >nul: 2>nul:
DISM /Online /Cleanup-Image /ScanHealth >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
Set TTime=%Time:~0,5%
Echo ***** Check #2 Done %TTime%                        *****
ping -n 10 127.0.0.1 >nul: 2>nul:
DISM /Online /Cleanup-Image /RestoreHealth >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
Set TTime=%Time:~0,5%
Echo ***** Check #3 Done %TTime%                        *****
ping -n 10 127.0.0.1 >nul: 2>nul:
sfc /scannow >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
Set TTime=%Time:~0,5%
Echo ***** Check #4 Done %TTime%                        *****
Echo ********************************************************
ping -n 10 127.0.0.1 >nul: 2>nul:


:: Start Scans, downloads, and installs the Windows updates
Set TTime=%Time:~0,5%
Echo ***** Starting Windows Updates                     *****
Echo ***** Starting Windows Updates                     ***** >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 
Echo ***** 10 Minutes, then will run in the background  *****
Echo ***** Time %TTime%
Echo ********************************************************
UsoClient ScanInstallWait >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 600 127.0.0.1 >nul: 2>nul:


:: Start System Maintenance Silent
Set TTime=%Time:~0,5%
Echo ***** Starting System Maintenance                  *****
Echo ***** Starting System Maintenance                  ***** >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 
Echo ***** 10 Minutes, then will run in the background  *****
Echo ***** Time %TTime%
Echo ********************************************************
ping -n 2 127.0.0.1 >nul: 2>nul:
:: Enable Auto Maintenance
REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" /V "MaintenanceDisabled" /T REG_DWORD /D "0" /f >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 2 127.0.0.1 >nul: 2>nul:
:: Start Maintenance
MSchedExe.exe Start >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 600 127.0.0.1 >nul: 2>nul:


:: Adjust visuals effects for best performance
Set TTime=%Time:~0,5%
Echo ***** Adjust visuals effects for best performance  *****
Echo ***** Adjust visuals effects for best performance  ***** >>C:\Windows\Temp\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 
Echo ***** 2 Minutes                                    *****
Echo ***** Time %TTime%
Echo ********************************************************
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /V "VisualFXSetting" /T REG_DWORD /D "2" /f
ping -n 120 127.0.0.1 >nul: 2>nul:


:: Disable Schduled Tasks
Set TTime=%Time:~0,5%
Echo ***** Disable Schduled Tasks                       *****
Echo ***** Disable Schduled Tasks                       ***** >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 
Echo ***** 5 Minutes                                    *****
Echo ***** Time %TTime%
Echo ********************************************************
ping -n 10 127.0.0.1 >nul: 2>nul:
schtasks /Change /TN "Microsoft\Windows\Application Experience\AitAgent" /disable >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 10 127.0.0.1 >nul: 2>nul:
schtasks /Change /TN "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /disable >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 10 127.0.0.1 >nul: 2>nul:
schtasks /Change /TN "Microsoft\Windows\Autochk\Proxy" /disable >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 10 127.0.0.1 >nul: 2>nul:
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\BthSQM" /disable >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 10 127.0.0.1 >nul: 2>nul:
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /disable >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 10 127.0.0.1 >nul: 2>nul:
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" /disable >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 10 127.0.0.1 >nul: 2>nul:
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Uploader" /disable >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 10 127.0.0.1 >nul: 2>nul:
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /disable >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 10 127.0.0.1 >nul: 2>nul:
schtasks /Change /TN "Microsoft\Windows\Shell\FamilySafetyMonitor" /disable >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 10 127.0.0.1 >nul: 2>nul:
schtasks /Change /TN "Microsoft\Windows\Shell\FamilySafetyRefresh" /disable >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 10 127.0.0.1 >nul: 2>nul:
schtasks /Change /TN "Microsoft\Windows\Shell\FamilySafetyUpload" /disable >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 10 127.0.0.1 >nul: 2>nul:
schtasks /Change /TN "\Microsoft\Windows\Shell\FamilySafetyMonitor" /disable >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 10 127.0.0.1 >nul: 2>nul:
schtasks /Change /TN "\Microsoft\Windows\Shell\FamilySafetyMonitorToastTask" /disable >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 10 127.0.0.1 >nul: 2>nul:
schtasks /Change /TN "\Microsoft\Windows\Shell\FamilySafetyRefreshTask" /disable >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 10 127.0.0.1 >nul: 2>nul:
schtasks /Change /TN "\Microsoft\Windows\Maps\MapsUpdateTask" /disable >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 10 127.0.0.1 >nul: 2>nul:
schtasks /Change /TN "\Microsoft\Windows\Maps\MapsToastTask" /disable >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 10 127.0.0.1 >nul: 2>nul:
schtasks /Change /TN "Microsoft\XblGameSave\XblGameSaveTask" /disable >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 10 127.0.0.1 >nul: 2>nul:
schtasks /Change /TN "Microsoft\XblGameSave\XblGameSaveTaskLogon" /disable >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 120 127.0.0.1 >nul: 2>nul:


:: Set Power Scheme to High
Set TTime=%Time:~0,5%
Echo ***** Set Power Scheme to High                     *****
Echo ***** Set Power Scheme to High                     ***** >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 
Echo ***** 2 Minute                                     *****
Echo ***** Time %TTime%
Echo ********************************************************
ping -n 10 127.0.0.1 >nul: 2>nul:
powercfg.exe -x -monitor-timeout-ac 120 >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 10 127.0.0.1 >nul: 2>nul:
powercfg.exe -x -monitor-timeout-dc 120 >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 10 127.0.0.1 >nul: 2>nul:
powercfg.exe -x -disk-timeout-ac 0 >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 10 127.0.0.1 >nul: 2>nul:
powercfg.exe -x -disk-timeout-dc 0 >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 10 127.0.0.1 >nul: 2>nul:
powercfg.exe -x -standby-timeout-ac 0 >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 10 127.0.0.1 >nul: 2>nul:
powercfg.exe -x -standby-timeout-dc 0 >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 10 127.0.0.1 >nul: 2>nul:
powercfg.exe -x -hibernate-timeout-ac 0 >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 10 127.0.0.1 >nul: 2>nul:
powercfg.exe -x -hibernate-timeout-dc 0 >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 10 127.0.0.1 >nul: 2>nul:
powercfg /SETDCVALUEINDEX SCHEME_CURRENT 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 0 >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 30 127.0.0.1 >nul: 2>nul:


:: Disable Telemetry and Location Tracking
Set TTime=%Time:~0,5%
Echo ***** Disable Telemetry and Location Tracking      *****
Echo ***** Disable Telemetry and Location Tracking      ***** >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 
Echo ***** 1 Minute                                     *****
Echo ***** Time %TTime%
Echo ********************************************************
ping -n 10 127.0.0.1 >nul: 2>nul:
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /V AllowTelemetry /T REG_DWORD /D 0 /F >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 10 127.0.0.1 >nul: 2>nul:
REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" /V SensorPermissionState /T REG_DWORD /D 0 /F  >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 10 127.0.0.1 >nul: 2>nul:
REG ADD "HKLM\System\CurrentControlSet\Services\lfsvc\Service\Configuration" /V Status /T REG_DWORD /D 0 /F  >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 30 127.0.0.1 >nul: 2>nul:


:: Clear any print jobs and restart the spooler
Set TTime=%Time:~0,5%
Echo ***** Clear any print jobs and restart the spooler *****
Echo ***** Clear any print jobs and restart the spooler ***** >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 
Echo ***** 2 Minutes                                    *****
Echo ***** Time %TTime%
Echo ********************************************************
:$reference https://www.dostips.com/  >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
:$reference https://support.microsoft.com/kb/946737  >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
net stop spooler /y >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 10 127.0.0.1 >nul: 2>nul:
del "%systemroot%\system32\spool\printers\*.shd" >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 10 127.0.0.1 >nul: 2>nul:
del "%systemroot%\system32\spool\printers\*.spl" >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 10 127.0.0.1 >nul: 2>nul:
net start spooler >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 100 127.0.0.1 >nul: 2>nul:


:: Disable Multicasting
Set TTime=%Time:~0,5%
Echo ***** Disable Multicasting                         *****
Echo ***** Disable Multicasting                         ***** >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 
Echo ***** 1 Minutes                                    *****
Echo ***** Time %TTime%
Echo ********************************************************
Reg add "HKLM\Software\Policies\Microsoft\Windows NT\DNSClient" /v "EnableMulticast" /t REG_DWORD /d 0
ping -n 30 127.0.0.1 >nul: 2>nul:


::  Flush DNS and reset IP Stack
Set TTime=%Time:~0,5%
Echo ***** Flush DNS and reset IP Stack                 *****
Echo ***** Flush DNS and reset IP Stack                 ***** >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 
Echo ***** 5 Minutes                                    *****
Echo ***** Time %TTime%
Echo ********************************************************
ipconfig /flushdns >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 15 127.0.0.1 >nul: 2>nul:
netsh winsock reset >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 15 127.0.0.1 >nul: 2>nul:
:: netsh int ip reset >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
:: ping -n 15 127.0.0.1 >nul: 2>nul:
:: ipconfig /release >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
:: ping -n 15 127.0.0.1 >nul: 2>nul:
:: ipconfig /renew >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 240 127.0.0.1 >nul: 2>nul:


:: Sync time to the Internet
Set TTime=%Time:~0,5%
Echo ***** Sync time to the Internet                    *****
Echo ***** Sync time to the Internet                    ***** >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 
Echo ***** 2 Minutes                                    *****
Echo ***** Time %TTime%
Echo ********************************************************
Set-TimeZone "Eastern Standard Time" >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 10 127.0.0.1 >nul: 2>nul:
net stop w32time >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 10 127.0.0.1 >nul: 2>nul:
w32tm /unregister >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 10 127.0.0.1 >nul: 2>nul:
w32tm /config /syncfromflags:manual /manualpeerlist:"0.pool.ntp.org 1.pool.ntp.org 2.pool.ntp.org 3.pool.ntp.org" >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 10 127.0.0.1 >nul: 2>nul:
w32tm /config /update >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 10 127.0.0.1 >nul: 2>nul:
w32tm /register >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 10 127.0.0.1 >nul: 2>nul:
net start w32time >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 10 127.0.0.1 >nul: 2>nul:
w32tm /resync /rediscover >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 60 127.0.0.1 >nul: 2>nul:


:: Create Restore Point
Set TTime=%Time:~0,5%
Echo ***** Create Restore Point                         *****
Echo ***** Create Restore Point                         ***** >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 
Echo ***** 10 Minutes                                   *****
Echo ***** Time %TTime%
Echo ********************************************************
Wmic.exe /Namespace:\\root\default Path SystemRestore Call CreateRestorePoint "Finished Running Speed Up Process", 100, 12 >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 600 127.0.0.1 >nul: 2>nul:


:: Schedule the Restore Point to run every 19 days
Set TTime=%Time:~0,5%
Echo ***** Schedule the Restore Point every 19 days     *****
Echo ***** Schedule the Restore Point every 19 days     ***** >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 
Echo ***** 1 Minutes                                    *****
Echo ***** Time %TTime%
Echo ********************************************************
schtasks /create /tn RestorePoint /tr "powershell.exe Checkpoint-Computer -Description RestorePoint" /sc daily /mo 18 /sd 12/31/2021 /st 22:00 >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt
ping -n 60 127.0.0.1 >nul: 2>nul:


:: start notepad "%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt"

:: Done
Set TYear=%date:~10,4%
Set TMonth=%date:~4,2%
Set TDay=%date:~7,2%
Set StopTime=%Time:~0,5%
Echo.
Echo ********************************************************
Echo ***** Doing the last cleanup and rebooting         *****
Echo ***** Doing the last cleanup and rebooting         ***** >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 
Echo ***** Thank you                                    *****
Echo ***** Start Time %SDay%-%SMonth%-%SYear%  %StartTime% >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 
Echo ***** Stop Time  %TDay%-%TMonth%-%TYear%  %StopTime%  >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 
Echo ***** Start Time %SDay%-%SMonth%-%SYear%  %StartTime%
Echo ***** Stop Time  %TDay%-%TMonth%-%TYear%  %StopTime%
Echo ********************************************************
ping -n 120 127.0.0.1 >nul: 2>nul
shutdown /r /f /c "Speedup Process Completed"  >>%temp%\SpeedUpAuto%SDay%-%SMonth%-%SYear%.txt 2>>%temp%\SpeedUpAutoErrors%SDay%-%SMonth%-%SYear%.txt