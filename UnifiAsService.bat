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
    Goto End
    )

cd "%UserProfile%\Ubiquiti UniFi\"
java -jar lib\ace.jar installsvc
java -jar lib\ace.jar startsvc

:End