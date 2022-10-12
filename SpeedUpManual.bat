@Echo off
CLS


::Check_Permissions
net session >nul 2>&1
if %errorLevel% == 0 (
    Echo.
    Echo Success: Administrative permissions confirmed.
) else (
    Echo.
    Color 4F
    Echo Failure: Current permissions inadequate.
    Echo.
    Echo You need Administrative permissions for this to work properly.
    Echo.
    Pause
    Color 7 
    )


:: Start Date and Time
Set Year=%date:~10,4%
Set Month=%date:~4,2%
Set Day=%date:~7,2%
Set StartTime=%Time:~0,5%
Echo.
Echo Starting: %Day%-%Month%-%Year%  %StartTime%
Echo.


:Q1
SET /P QQ01= Delete Temp Files?  Y N or X?
If %QQ01%==y goto Q1Y
if %QQ01%==Y goto Q1Y
if %QQ01%==n goto Q2
if %QQ01%==N goto Q2
if %QQ01%==x goto End
if %QQ01%==X goto End
goto Q1
::
::
:Q1Y
Color 71
::
::
:Q1a
CLS
Echo.
SET /P ZZa= Do you want to EDIT or DELETE or SKIP %userprofile%\Recent\ ?   E D S ?
If %ZZa%==e goto Q1aL
If %ZZa%==E goto Q1aL
If %ZZa%==d goto Q1aY
If %ZZa%==D goto Q1aY
If %ZZa%==s goto Q1b
If %ZZa%==S goto Q1b
Goto Q1a
:Q1aL
Explorer "%userprofile%\Recent"
Goto Q1b
:Q1aY
del /s /f /q %userprofile%\Recent\*.*
::
::
:Q1b
CLS
Echo.
SET /P ZZb= Do you want to EDIT or DELETE or SKIP C:\Windows\Prefetch\ ?   E D S ?
If %ZZb%==e goto Q1bL
If %ZZb%==E goto Q1bL
If %ZZb%==d goto Q1bY
If %ZZb%==D goto Q1bY
If %ZZb%==s goto Q1c
If %ZZb%==S goto Q1c
Goto Q1b
:Q1bL
explorer "C:\Windows\Prefetch"
Goto Q1c
:Q1bY
del /s /f /q C:\Windows\Prefetch\*.*
::
::
:Q1c
CLS
Echo.
SET /P ZZc= Do you want to EDIT or DELETE or SKIP C:\Windows\Temp ?   E D S ?
If %ZZc%==e goto Q1cL
If %ZZc%==E goto Q1cL
If %ZZc%==d goto Q1cY
If %ZZc%==D goto Q1cY
If %ZZc%==s goto Q1d
If %ZZc%==S goto Q1d
Goto Q1c
:Q1cL
explorer "C:\Windows\Temp"
Goto Q1d
:Q1cY
del /s /f /q C:\Windows\Temp\*.*
::
::
:Q1d
CLS
Echo.
SET /P ZZd= Do you want to EDIT or DELETE or SKIP %USERPROFILE%\appdata\local\temp ?   E D S ?
If %ZZd%==e goto Q1dL
If %ZZd%==E goto Q1dL
If %ZZd%==d goto Q1dY
If %ZZd%==D goto Q1dY
If %ZZd%==s goto Q1e
If %ZZd%==S goto Q1e
Goto Q1d
:Q1dL
explorer "%USERPROFILE%\appdata\local\temp"
Goto Q1e
:Q1dY
del /s /f /q %USERPROFILE%\appdata\local\temp\*.*
::
::
:Q1e
CLS
Echo.
SET /P ZZe= Do you want to EDIT or DELETE or SKIP %USERPROFILE%\appdata\local\Microsoft\Windows\INetCache ?   E D S ?
If %ZZe%==e goto Q1eL
If %ZZe%==E goto Q1eL
If %ZZe%==d goto Q1eY
If %ZZe%==D goto Q1eY
If %ZZe%==s goto Q1f
If %ZZe%==S goto Q1f
Goto Q1e
:Q1eL
explorer "%USERPROFILE%\appdata\local\Microsoft\Windows\INetCache"
Goto Q1f
:Q1eY
del /s /f /q %USERPROFILE%\appdata\local\Microsoft\Windows\INetCache\*.*
::
::
:Q1f
CLS
Echo.
SET /P ZZf= Do you want to EDIT or DELETE or SKIP C:\Windows\Logs\CBS ?   E D S ?
If %ZZf%==e goto Q1fL
If %ZZf%==E goto Q1fL
If %ZZf%==d goto Q1fY
If %ZZf%==D goto Q1fY
If %ZZf%==s goto Q1g
If %ZZf%==S goto Q1g
Goto Q1f
:Q1fL
explorer "C:\Windows\Logs\CBS"
Goto Q1g
:Q1fY
del /s /f /q C:\Windows\Logs\CBS\*.*
::
::
:Q1g
Color 07
Cls
Echo.


:Q2
Echo.
SET /P QQ02= Start System Maintenance? Y N or X?
If %QQ02%==y goto Q2Y
if %QQ02%==Y goto Q2Y
if %QQ02%==n goto Q3
if %QQ02%==N goto Q3
if %QQ02%==x goto End
if %QQ02%==X goto End
goto Q2
:Q2Y
MSchedExe.exe Start


:Q3
Echo.
SET /P QQ03= Check Start Up Programs?  Y N or X?
If %QQ03%==y goto Q3Y
if %QQ03%==Y goto Q3Y
if %QQ03%==n goto Q4
if %QQ03%==N goto Q4
if %QQ03%==x goto End
if %QQ03%==X goto End
goto Q3
:Q3Y
Color 71
Cls
Echo
Echo Pay close attention to the 'Startup Impact' values for each program e.g. 'High'
Echo.
Echo 2 other file explorer windows are open with programs that auto start.
Echo.
taskmgr /7 /startup
explorer "C:\Users\%username%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"
explorer "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp"
Pause
Color 07


:Q4
Echo.
SET /P QQ04= Disable Indexing? Y N or X?
If %QQ04%==y goto Q4Y
if %QQ04%==Y goto Q4Y
if %QQ04%==n goto Q5
if %QQ04%==N goto Q5
if %QQ04%==x goto End
if %QQ04%==X goto End
goto Q4
:Q4Y
sc config WSearch start= disabled


:Q5
Echo.
SET /P QQ05= Disable Visual Effects? and Recovery Protection?  Y N or X?
If %QQ05%==y goto Q5Y
if %QQ05%==Y goto Q5Y
if %QQ05%==n goto Q6
if %QQ05%==N goto Q6
if %QQ05%==x goto End
if %QQ05%==X goto End
goto Q5
:Q5Y
Cls
Color 71
Echo.
Echo.
Echo.
Echo Select "Advanced"
Echo Preformance "Settings"
Echo "Adjust for best performance"
Echo "OK"
Echo.
Echo Startup and Recovery "Settings"
Echo Check "Time to display list of operating systems" 20 seconds
Echo "OK"
Echo.
:: Echo Select "System Protection"
:: Echo Click  "Windows C:"
:: Echo Select "Configure"
:: Echo Turn ON system protection
:: Echo Set "Disk Sapce Usage" to 20 GB
:: Echo "OK"
Echo "OK"
Echo.
Sysdm.cpl
Pause
Color 07


:Q6
Echo.
SET /P QQ06= Disable Transparncy?  Y N or X?
If %QQ06%==y goto Q6Y
if %QQ06%==Y goto Q6Y
if %QQ06%==n goto Q7
if %QQ06%==N goto Q7
if %QQ06%==x goto End
if %QQ06%==X goto End
goto Q6
:Q6Y
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /V "EnableTransparency /T REG_DWORD /D 0 /F


:Q7
Echo.
SET /P QQ07= Flush DNS?  Y N or X?
If %QQ07%==y goto Q7Y
if %QQ07%==Y goto Q7Y
if %QQ07%==n goto Q8
if %QQ07%==N goto Q8
if %QQ07%==x goto End
if %QQ07%==X goto End
goto Q7
:Q7Y
ipconfig /flushdns


:Q8
Echo.
::Click the Windows menu and type 'Disk Cleanup' in the search bar to get started. The utility will offer you a choice of files to remove. Simply mark the check box next to each option. Click 'Clean up system Files' to begin. Disk Cleanup will calculate the amount of space you will save.
SET /P QQ08= Run Disk Cleanup?  Y N or X?
If %QQ08%==y goto Q8Y
if %QQ08%==Y goto Q8Y
if %QQ08%==n goto Q9
if %QQ08%==N goto Q9
if %QQ08%==x goto End
if %QQ08%==X goto End
goto Q8
:Q8Y
c:\windows\SYSTEM32\cleanmgr /d C /lowdisk


:Q9
Echo.
SET /P QQ09= Uninstall Bloatware?  Y N or X?
If %QQ09%==y goto Q9Y
if %QQ09%==Y goto Q9Y
if %QQ09%==n goto Q10
if %QQ09%==N goto Q10
if %QQ09%==x goto End
if %QQ09%==X goto End
goto Q9
:Q9Y
control appwiz.cpl


:Q10
Echo.
SET /P QQ10= Monitor=60min Sleep=Never Standby=Never Hibernate=Never?  Y N or X?
If %QQ10%==y goto Q10Y
if %QQ10%==Y goto Q10Y
if %QQ10%==n goto Q11
if %QQ10%==N goto Q11
if %QQ10%==x goto End
if %QQ10%==X goto End
goto Q10
:Q10Y
powercfg.exe -x -monitor-timeout-ac 60
powercfg.exe -x -monitor-timeout-dc 60
powercfg.exe -x -disk-timeout-ac 0
powercfg.exe -x -disk-timeout-dc 0
powercfg.exe -x -standby-timeout-ac 0
powercfg.exe -x -standby-timeout-dc 0
powercfg.exe -x -hibernate-timeout-ac 0
powercfg.exe -x -hibernate-timeout-dc 0
powercfg /SETDCVALUEINDEX SCHEME_CURRENT 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 0


:Q11
Echo.
SET /P QQ11= Sync time to the Internet?  Y N or X?
If %QQ11%==y goto Q11Y
if %QQ11%==Y goto Q11Y
if %QQ11%==n goto Q12
if %QQ11%==N goto Q12
if %QQ11%==x goto End
if %QQ11%==X goto End
goto Q11
:Q11Y
net stop w32time
w32tm /unregister
w32tm /register
net start w32time
w32tm /resync


:Q12
Echo.
SET /P QQ12= Do you want Remove News and Interests Y N or X?
If %QQ12%==y goto Q12Y
if %QQ12%==Y goto Q12Y
if %QQ12%==n goto Q13
if %QQ12%==N goto Q13
if %QQ12%==x goto End
if %QQ12%==X goto End
goto Q12
:Q12Y
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Feeds" /V ShellFeedsTaskbarViewMode /T REG_DWORD /D 2 /F
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" /V EnableFeeds /T REG_DWORD /D 0 /F


:Q13
Echo.
SET /P QQ13= Disabl Telemetry Y N or X?
If %QQ13%==y goto Q13Y
if %QQ13%==Y goto Q13Y
if %QQ13%==n goto Q14
if %QQ13%==N goto Q14
if %QQ13%==x goto End
if %QQ13%==X goto End
goto Q13
:Q13Y
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /V AllowTelemetry /T REG_DWORD /D 0 /F


:Q14
Echo.
SET /P QQ14= Disabling Location Tracking Y N or X?
If %QQ14%==y goto Q14Y
if %QQ14%==Y goto Q14Y
if %QQ14%==n goto Q15
if %QQ14%==N goto Q15
if %QQ14%==x goto End
if %QQ14%==X goto End
goto Q14
:Q14Y
REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" /V SensorPermissionState /T REG_DWORD /D 0 /F
REG ADD "HKLM\System\CurrentControlSet\Services\lfsvc\Service\Configuration" /V Status /T REG_DWORD /D 0 /F


:Q15
Echo.
SET /P QQ15= Disable IPV6 on Ethernet? Y N or X?
If %QQ15%==y goto Q15Y
if %QQ15%==Y goto Q15Y
if %QQ15%==n goto Q16
if %QQ15%==N goto Q16
if %QQ15%==x goto End
if %QQ15%==X goto End
goto Q15
:Q15Y
Echo Disable-NetAdapterBinding -Name Ethernet -ComponentID ms_tcpip6 >DisIP6.ps1
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& './DisIP6.ps1'"
ping -n 1 127.0.0.1 >nul: 2>nul:
Del DisIP6.ps1

:Q16
Echo.
SET /P QQ16= Disabl Wi-Fi Sense Y N or X?
If %QQ16%==y goto Q16Y
if %QQ16%==Y goto Q16Y
if %QQ16%==n goto Q17
if %QQ16%==N goto Q17
if %QQ16%==x goto End
if %QQ16%==X goto End
goto Q16
:Q16Y
REG ADD "HKLM\Software\Microsoft\PolicyManager\default\WiFi" /V AllowWiFiHotSpotReporting /T REG_DWORD /D 0 /F
REG ADD "HKLM\Software\Microsoft\PolicyManager\default\WiFi" /V AllowAutoConnectToWiFiSenseHotspots /T REG_DWORD /D 0 /F


:Q17
Echo.
SET /P QQ17= Restrict Windows Update P2P only to local network Y N or X?
If %QQ17%==y goto Q17Y
if %QQ17%==Y goto Q17Y
if %QQ17%==n goto Q18
if %QQ17%==N goto Q18
if %QQ17%==x goto End
if %QQ17%==X goto End
goto Q17
:Q17Y
REG ADD "HKLM\Software\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /V DODownloadMode /T REG_DWORD /D 1 /F
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\DeliveryOptimization" /V SystemSettingsDownloadMode /T REG_DWORD /D 3 /F


:Q18
Echo.
SET /P QQ18= Disable Corana with PowerShell Y N or X?
If %QQ18%==y goto Q18Y
if %QQ18%==Y goto Q18Y
if %QQ18%==n goto Q19
if %QQ18%==N goto Q19
if %QQ18%==x goto End
if %QQ18%==X goto End
goto Q18
:Q18Y
Echo Write-Host "Disabling Cortana..." >%temp%\DisCortana.ps1
Echo If (!(Test-Path "HKCU:\Software\Microsoft\Personalization\Settings")) { >>%temp%\DisCortana.ps1
Echo New-Item -Path "HKCU:\Software\Microsoft\Personalization\Settings" -Force ^| Out-Null >>%temp%\DisCortana.ps1
Echo } >>%temp%\DisCortana.ps1
Echo Set-ItemProperty -Path "HKCU:\Software\Microsoft\Personalization\Settings" -Name "AcceptedPrivacyPolicy" -Type DWord -Value 0 >>%temp%\DisCortana.ps1
Echo If (!(Test-Path "HKCU:\Software\Microsoft\InputPersonalization")) { >>%temp%\DisCortana.ps1
Echo New-Item -Path "HKCU:\Software\Microsoft\InputPersonalization" -Force ^| Out-Null >>%temp%\DisCortana.ps1
Echo } >>%temp%\DisCortana.ps1
Echo Set-ItemProperty -Path "HKCU:\Software\Microsoft\InputPersonalization" -Name "RestrictImplicitTextCollection" -Type DWord -Value 1 >>%temp%\DisCortana.ps1
Echo Set-ItemProperty -Path "HKCU:\Software\Microsoft\InputPersonalization" -Name "RestrictImplicitInkCollection" -Type DWord -Value 1 >>%temp%\DisCortana.ps1
Echo If (!(Test-Path "HKCU:\Software\Microsoft\InputPersonalization\TrainedDataStore")) { >>%temp%\DisCortana.ps1
Echo New-Item -Path "HKCU:\Software\Microsoft\InputPersonalization\TrainedDataStore" -Force ^| Out-Null >>%temp%\DisCortana.ps1
Echo } >>%temp%\DisCortana.ps1
Echo Set-ItemProperty -Path "HKCU:\Software\Microsoft\InputPersonalization\TrainedDataStore" -Name "HarvestContacts" -Type DWord -Value 0 >>%temp%\DisCortana.ps1
::
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& './%temp%\DisCortana.ps1'"
ping -n 2 127.0.0.1 >nul: 2>nul:
Del %temp%\DisCortana.ps1


:Q19
Echo.
SET /P QQ19= Uninstall Default apps with PowerShell  Y N or X?
If %QQ19%==y goto Q19Y
if %QQ19%==Y goto Q19Y
if %QQ19%==n goto Q20
if %QQ19%==N goto Q20
if %QQ19%==x goto End
if %QQ19%==X goto End
goto Q19
:Q19Y
Echo If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) { >%temp%\UnInst.ps1
Echo Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs >>%temp%\UnInst.ps1
Echo Exit >>%temp%\UnInst.ps1
Echo } >>%temp%\UnInst.ps1
Echo Write-Output "Uninstalling default apps" >>%temp%\UnInst.ps1
Echo $apps = @( >>%temp%\UnInst.ps1
Echo     # default Windows 10 apps >>%temp%\UnInst.ps1
Echo     "Microsoft.3DBuilder" >>%temp%\UnInst.ps1
Echo     "Microsoft.Advertising.Xaml" >>%temp%\UnInst.ps1
Echo     #"Microsoft.Appconnector" >>%temp%\UnInst.ps1
Echo     "Microsoft.BingFinance" >>%temp%\UnInst.ps1
Echo     "Microsoft.BingNews" >>%temp%\UnInst.ps1
Echo     "Microsoft.BingSports" >>%temp%\UnInst.ps1
Echo     "Microsoft.BingTranslator" >>%temp%\UnInst.ps1
Echo     "Microsoft.BingWeather" >>%temp%\UnInst.ps1
Echo     #"Microsoft.FreshPaint" >>%temp%\UnInst.ps1
Echo     "Microsoft.GamingServices" >>%temp%\UnInst.ps1
Echo     "Microsoft.Microsoft3DViewer" >>%temp%\UnInst.ps1
Echo     "Microsoft.WindowsFeedbackHub" >>%temp%\UnInst.ps1
Echo     "Microsoft.MicrosoftOfficeHub" >>%temp%\UnInst.ps1
Echo     "Microsoft.MixedReality.Portal" >>%temp%\UnInst.ps1
Echo     "Microsoft.MicrosoftPowerBIForWindows" >>%temp%\UnInst.ps1
Echo     "Microsoft.MicrosoftSolitaireCollection" >>%temp%\UnInst.ps1
Echo     #"Microsoft.MicrosoftStickyNotes" >>%temp%\UnInst.ps1
Echo     "Microsoft.MinecraftUWP" >>%temp%\UnInst.ps1
Echo     "Microsoft.NetworkSpeedTest" >>%temp%\UnInst.ps1
Echo     "Microsoft.Office.OneNote" >>%temp%\UnInst.ps1
Echo     "Microsoft.People" >>%temp%\UnInst.ps1
Echo     "Microsoft.Print3D" >>%temp%\UnInst.ps1
Echo     "Microsoft.SkypeApp" >>%temp%\UnInst.ps1
Echo     "Microsoft.Wallet" >>%temp%\UnInst.ps1
Echo     # "Microsoft.Windows.Photos" >>%temp%\UnInst.ps1
Echo     # "Microsoft.WindowsAlarms" >>%temp%\UnInst.ps1
Echo     # "Microsoft.WindowsCalculator" >>%temp%\UnInst.ps1
Echo     # "Microsoft.WindowsCamera" >>%temp%\UnInst.ps1
Echo     #"microsoft.windowscommunicationsapps" >>%temp%\UnInst.ps1
Echo     "Microsoft.WindowsMaps" >>%temp%\UnInst.ps1
Echo     "Microsoft.WindowsPhone" >>%temp%\UnInst.ps1
Echo     #"Microsoft.WindowsSoundRecorder" >>%temp%\UnInst.ps1
Echo     #"Microsoft.WindowsStore"   # can't be re-installed >>%temp%\UnInst.ps1
Echo     "Microsoft.Xbox.TCUI" >>%temp%\UnInst.ps1
Echo     "Microsoft.XboxApp" >>%temp%\UnInst.ps1
Echo     "Microsoft.XboxGameOverlay" >>%temp%\UnInst.ps1
Echo     "Microsoft.XboxGamingOverlay" >>%temp%\UnInst.ps1
Echo     "Microsoft.XboxSpeechToTextOverlay" >>%temp%\UnInst.ps1
Echo     "Microsoft.YourPhone" >>%temp%\UnInst.ps1
Echo     "Microsoft.ZuneMusic" >>%temp%\UnInst.ps1
Echo     "Microsoft.ZuneVideo" >>%temp%\UnInst.ps1
Echo     "Microsoft.Windows.CloudExperienceHost" >>%temp%\UnInst.ps1
Echo     "Microsoft.Windows.ContentDeliveryManager" >>%temp%\UnInst.ps1
Echo     "Microsoft.Windows.PeopleExperienceHost" >>%temp%\UnInst.ps1
Echo     "Microsoft.XboxGameCallableUI" >>%temp%\UnInst.ps1
Echo.  >>%temp%\UnInst.ps1
Echo     # Threshold 2 apps >>%temp%\UnInst.ps1
Echo     "Microsoft.CommsPhone" >>%temp%\UnInst.ps1
Echo     #"Microsoft.ConnectivityStore" >>%temp%\UnInst.ps1
Echo     #"Microsoft.GetHelp" >>%temp%\UnInst.ps1
Echo     "Microsoft.Getstarted" >>%temp%\UnInst.ps1
Echo     "Microsoft.Messaging" >>%temp%\UnInst.ps1
Echo     "Microsoft.Office.Sway" >>%temp%\UnInst.ps1
Echo     #"Microsoft.OneConnect" >>%temp%\UnInst.ps1
Echo     "Microsoft.WindowsFeedbackHub" >>%temp%\UnInst.ps1
Echo.  >>%temp%\UnInst.ps1
Echo     # Creators Update apps >>%temp%\UnInst.ps1
Echo     "Microsoft.Microsoft3DViewer" >>%temp%\UnInst.ps1
Echo     #"Microsoft.MSPaint" >>%temp%\UnInst.ps1
Echo.  >>%temp%\UnInst.ps1
Echo     #Redstone apps >>%temp%\UnInst.ps1
Echo     "Microsoft.BingFoodAndDrink" >>%temp%\UnInst.ps1
Echo     "Microsoft.BingHealthAndFitness" >>%temp%\UnInst.ps1
Echo     "Microsoft.BingTravel" >>%temp%\UnInst.ps1
Echo     "Microsoft.WindowsReadingList" >>%temp%\UnInst.ps1
Echo.  >>%temp%\UnInst.ps1
Echo     # Redstone 5 apps >>%temp%\UnInst.ps1
Echo     "Microsoft.MixedReality.Portal" >>%temp%\UnInst.ps1
Echo     "Microsoft.ScreenSketch" >>%temp%\UnInst.ps1
Echo     "Microsoft.XboxGamingOverlay" >>%temp%\UnInst.ps1
Echo     "Microsoft.YourPhone" >>%temp%\UnInst.ps1
Echo.  >>%temp%\UnInst.ps1
Echo     # non-Microsoft >>%temp%\UnInst.ps1
Echo     #"2FE3CB00.PicsArt-PhotoStudio" >>%temp%\UnInst.ps1
Echo     #"46928bounde.EclipseManager" >>%temp%\UnInst.ps1
Echo     "4DF9E0F8.Netflix" >>%temp%\UnInst.ps1
Echo     "613EBCEA.PolarrPhotoEditorAcademicEdition" >>%temp%\UnInst.ps1
Echo     "6Wunderkinder.Wunderlist" >>%temp%\UnInst.ps1
Echo     #"7EE7776C.LinkedInforWindows" >>%temp%\UnInst.ps1
Echo     "89006A2E.AutodeskSketchBook" >>%temp%\UnInst.ps1
Echo     "9E2F88E3.Twitter" >>%temp%\UnInst.ps1
Echo     "A278AB0D.DisneyMagicKingdoms" >>%temp%\UnInst.ps1
Echo     "A278AB0D.MarchofEmpires" >>%temp%\UnInst.ps1
Echo     "ActiproSoftwareLLC.562882FEEB491" # next one is for the Code Writer from Actipro Software LLC >>%temp%\UnInst.ps1
Echo     "CAF9E577.Plex"   >>%temp%\UnInst.ps1
Echo     "ClearChannelRadioDigital.iHeartRadio" >>%temp%\UnInst.ps1
Echo     "D52A8D61.FarmVille2CountryEscape" >>%temp%\UnInst.ps1
Echo     #"D5EA27B7.Duolingo-LearnLanguagesforFree" >>%temp%\UnInst.ps1
Echo     "DB6EA5DB.CyberLinkMediaSuiteEssentials" >>%temp%\UnInst.ps1
Echo     #"DolbyLaboratories.DolbyAccess" >>%temp%\UnInst.ps1
Echo     #"DolbyLaboratories.DolbyAccess" >>%temp%\UnInst.ps1
Echo     "Drawboard.DrawboardPDF" >>%temp%\UnInst.ps1
Echo     "Facebook.Facebook" >>%temp%\UnInst.ps1
Echo     "Fitbit.FitbitCoach" >>%temp%\UnInst.ps1
Echo     "Flipboard.Flipboard" >>%temp%\UnInst.ps1
Echo     "GAMELOFTSA.Asphalt8Airborne" >>%temp%\UnInst.ps1
Echo     "KeeperSecurityInc.Keeper" >>%temp%\UnInst.ps1
Echo     "NORDCURRENT.COOKINGFEVER" >>%temp%\UnInst.ps1
Echo     "PandoraMediaInc.29680B314EFC2" >>%temp%\UnInst.ps1
Echo     "Playtika.CaesarsSlotsFreeCasino" >>%temp%\UnInst.ps1
Echo     "ShazamEntertainmentLtd.Shazam" >>%temp%\UnInst.ps1
Echo     "SlingTVLLC.SlingTV" >>%temp%\UnInst.ps1
Echo     "SpotifyAB.SpotifyMusic" >>%temp%\UnInst.ps1
Echo     "TheNewYorkTimes.NYTCrossword" >>%temp%\UnInst.ps1
Echo     "ThumbmunkeysLtd.PhototasticCollage" >>%temp%\UnInst.ps1
Echo     "TuneIn.TuneInRadio" >>%temp%\UnInst.ps1
Echo     "WinZipComputing.WinZipUniversal" >>%temp%\UnInst.ps1
Echo     "XINGAG.XING" >>%temp%\UnInst.ps1
Echo     "flaregamesGmbH.RoyalRevolt2" >>%temp%\UnInst.ps1
Echo     "king.com.*" >>%temp%\UnInst.ps1
Echo     "king.com.BubbleWitch3Saga" >>%temp%\UnInst.ps1
Echo     "king.com.CandyCrushSaga" >>%temp%\UnInst.ps1
Echo     "king.com.CandyCrushSodaSaga" >>%temp%\UnInst.ps1
Echo.  >>%temp%\UnInst.ps1
Echo     # apps which cannot be removed using Remove-AppxPackage >>%temp%\UnInst.ps1
Echo     #"Microsoft.BioEnrollment" >>%temp%\UnInst.ps1
Echo     #"Microsoft.MicrosoftEdge" >>%temp%\UnInst.ps1
Echo     #"Microsoft.Windows.Cortana" >>%temp%\UnInst.ps1
Echo     #"Microsoft.WindowsFeedback" >>%temp%\UnInst.ps1
Echo     #"Microsoft.XboxGameCallableUI" >>%temp%\UnInst.ps1
Echo     #"Microsoft.XboxIdentityProvider" >>%temp%\UnInst.ps1
Echo     #"Windows.ContactSupport" >>%temp%\UnInst.ps1
Echo.  >>%temp%\UnInst.ps1
Echo     # apps which other apps depend on >>%temp%\UnInst.ps1
Echo     "Microsoft.Advertising.Xaml" >>%temp%\UnInst.ps1
Echo ) >>%temp%\UnInst.ps1
Echo.  >>%temp%\UnInst.ps1
Echo foreach ($app in $apps) { >>%temp%\UnInst.ps1
Echo     Write-Output "Trying to remove $app" >>%temp%\UnInst.ps1
Echo.  >>%temp%\UnInst.ps1
Echo     Get-AppxPackage -Name $app -AllUsers ^| Remove-AppxPackage -AllUsers >>%temp%\UnInst.ps1
Echo.  >>%temp%\UnInst.ps1
Echo     Get-AppXProvisionedPackage -Online ^| >>%temp%\UnInst.ps1
Echo         Where-Object DisplayName -EQ $app ^| >>%temp%\UnInst.ps1
Echo         Remove-AppxProvisionedPackage -Online >>%temp%\UnInst.ps1
Echo } >>%temp%\UnInst.ps1
Echo.
::
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& './%temp%\UnInst.ps1'"
ping -n 2 127.0.0.1 >nul: 2>nul:
Del %temp%\UnInst.ps1


:Q20
Echo.
SET /P QQ20= Change Paging File Size, Inital to the same as the physical and Max to double that Y N or X?
If %QQ20%==y goto Q20Y
if %QQ20%==Y goto Q20Y
if %QQ20%==n goto Q21
if %QQ20%==N goto Q21
if %QQ20%==x goto End
if %QQ20%==X goto End
goto Q20
:Q20Y
Echo     # Find the amount of physical memory  >%temp%\Memory.ps1
Echo     $memory = (Get-CimInstance Win32_PhysicalMemory | Measure-Object -Property capacity -Sum).sum /1mb >>%temp%\Memory.ps1
Echo     $maxMem = ($memory * 2) >>%temp%\Memory.ps1
Echo     # Remove Automatic Page File >>%temp%\Memory.ps1
Echo     $pagefile = Get-WmiObject Win32_ComputerSystem -EnableAllPrivileges >>%temp%\Memory.ps1
Echo     $pagefile.AutomaticManagedPagefile = $false >>%temp%\Memory.ps1
Echo     $pagefile.put() | Out-Null >>%temp%\Memory.ps1
Echo     # Set the Inital size to the size of the memory >>%temp%\Memory.ps1
Echo     $pagefileset = Get-WmiObject Win32_pagefilesetting >>%temp%\Memory.ps1
Echo     $pagefileset.InitialSize = $memory >>%temp%\Memory.ps1
Echo     $pagefileset.MaximumSize = $maxMem >>%temp%\Memory.ps1
Echo     $pagefileset.Put() | Out-Null >>%temp%\Memory.ps1
::
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& './%temp%\Memory.ps1'"
ping -n 2 127.0.0.1 >nul: 2>nul:
Del %temp%\Memory.ps1


:Q21
:: ***********************
goto Q26
:: ***********************
Echo.
SET /P QQ21= ******Question***** Y N or X?
If %QQ21%==y goto Q21Y
if %QQ21%==Y goto Q21Y
if %QQ21%==n goto Q22
if %QQ21%==N goto Q22
if %QQ21%==x goto End
if %QQ21%==X goto End
goto Q21
:Q21Y
RUN***RUN***RUN***

:Q22
Echo.
SET /P QQ22= ******Question***** Y N or X?
If %QQ22%==y goto Q22Y
if %QQ22%==Y goto Q22Y
if %QQ22%==n goto Q23
if %QQ22%==N goto Q23
if %QQ22%==x goto End
if %QQ22%==X goto End
goto Q22
:Q22Y
RUN***RUN***RUN***

:Q23
Echo.
SET /P QQ23= ******Question***** Y N or X?
If %QQ23%==y goto Q23Y
if %QQ23%==Y goto Q23Y
if %QQ23%==n goto Q24
if %QQ23%==N goto Q24
if %QQ23%==x goto End
if %QQ23%==X goto End
goto Q23
:Q23Y
RUN***RUN***RUN***

:Q24
Echo.
SET /P QQ24= ******Question***** Y N or X?
If %QQ24%==y goto Q24Y
if %QQ24%==Y goto Q24Y
if %QQ24%==n goto Q25
if %QQ24%==N goto Q25
if %QQ24%==x goto End
if %QQ24%==X goto End
goto Q24
:Q24Y
RUN***RUN***RUN***

:Q25
Echo.
SET /P QQ25= ******Question***** Y N or X?
If %QQ25%==y goto Q25Y
if %QQ25%==Y goto Q25Y
if %QQ25%==n goto Q26
if %QQ25%==N goto Q26
if %QQ25%==x goto End
if %QQ25%==X goto End
goto Q25
:Q25Y
RUN***RUN***RUN***

:Q26
Echo.
SET /P QQ26= Reset the TCPIP stack Y N or X?
If %QQ26%==y goto Q26Y
if %QQ26%==Y goto Q26Y
if %QQ26%==n goto Q27
if %QQ26%==N goto Q27
if %QQ26%==x goto End
if %QQ26%==X goto End
goto Q26
:Q26Y
netsh winsock reset
netsh int ip reset
ipconfig /release
ipconfig /renew
ipconfig /flushdns


:Q27
Echo.
SET /P QQ27= Install Russian Language  Y N or X?
if %QQ27%==y goto Q27Y
if %QQ27%==Y goto Q27Y
if %QQ27%==n goto Q28
if %QQ27%==N goto Q28
if %QQ27%==x goto End
if %QQ27%==X goto End
goto Q27
:Q27Y
Echo $LanguageList = Get-WinUserLanguageList >%temp%\InstRuss.ps1
Echo $LanguageList.Add("ru") >>%temp%\InstRuss.ps1
Echo Set-WinUserLanguageList $LanguageList -Confirm:$False >>%temp%\InstRuss.ps1
::
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& './%temp%\InstRuss.ps1'"
ping -n 2 127.0.0.1 >nul: 2>nul:
Del %temp%\InstRuss.ps1

:Q28
Echo.
SET /P QQ28= Enable System Restore and set to 20 GB Y N or X?
If %QQ28%==y goto Q28Y
if %QQ28%==Y goto Q28Y
if %QQ28%==n goto Q29
if %QQ28%==N goto Q29
if %QQ28%==x goto End
if %QQ28%==X goto End
goto Q28
:Q28Y
Echo Enable-ComputerRestore -Drive "C:\" >"%TEMP%\SysResto.ps1"
Echo vssadmin resize shadowstorage /On=%SystemDrive% /For=%SystemDrive% /Maxsize=20GB >>"%TEMP%\SysResto.ps1"
::
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& './%temp%\SysResto.ps1'"
ping -n 2 127.0.0.1 >nul: 2>nul:
Del "%temp%\SysResto.ps1"


:Q29
Echo.
SET /P QQ29= Add Infinty Help Icon to Desktop? Y N or X?
If %QQ29%==y goto Q29Y
if %QQ29%==Y goto Q29Y
if %QQ29%==n goto Q30
if %QQ29%==N goto Q30
if %QQ29%==x goto End
if %QQ29%==X goto End
goto Q29
:Q29Y
If exist %~d0\Build\Tech\BGinfo.bgi (
xcopy %~d0\Build\Tech\*.* C:\Tech\*.* /D
) Else (
Goto NoHelp
)
set SCRIPT="%TEMP%\%RANDOM%-%RANDOM%-%RANDOM%-%RANDOM%.vbs"
echo Set oWS = WScript.CreateObject("WScript.Shell") > %SCRIPT%
echo sLinkFile = "%USERPROFILE%\Desktop\Help.lnk" >> %SCRIPT%
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo oLink.TargetPath = "C:\Tech\Bginfo.exe" >> %SCRIPT%
echo oLink.Arguments = " BGinfo.bgi /TIMER:0 /Silent /NOLICPROMPT" >> %SCRIPT%
echo oLink.IconLocation = "C:\Tech\INFINITY_logo.ico" >> %SCRIPT%
echo oLink.WorkingDirectory = "C:\Tech" >> %SCRIPT%
echo oLink.Save >> %SCRIPT%
::
cscript /nologo %SCRIPT%
ping -n 2 127.0.0.1 >nul: 2>nul:
del %SCRIPT%
Goto Q30
:NoHelp
Echo.
Echo Could not install Help, missing support files


:Q30
Echo.
SET /P QQ30= Do you want to scan the Windows System Files for Corruption  Y N or X?
If %QQ30%==y goto Q30Y
if %QQ30%==Y goto Q30Y
if %QQ30%==n goto End
if %QQ30%==N goto End
if %QQ30%==x goto End
if %QQ30%==X goto End
goto Q30
:Q30Y
DISM /Online /Cleanup-Image /CheckHealth
DISM /Online /Cleanup-Image /ScanHealth
DISM /Online /Cleanup-Image /RestoreHealth
sfc /scannow


:End
Color 71
Echo.
Echo   Started: %Day%-%Month%-%Year%  %StartTime%
Set Year=%date:~10,4%
Set Month=%date:~4,2%
Set Day=%date:~7,2%
Set EndTime=%Time:~0,5%
Echo Completed: %Day%-%Month%-%Year%  %EndTime%
Echo.
Echo You should restart Windows now.
Echo.
Echo         Thank you!
Echo.
Pause