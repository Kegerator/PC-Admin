# This script creates a backup of the original hosts file (excluding lines not starting with "#") 
# in a file called "OldHost"
# It then adds a new line to the hosts file and saves the changes.
# Enter the new line inside the " " below
# Example:
#     $NewLine = "192.168.1.201 SERVER03"

$NewLine = " "

$file = "C:\Windows\System32\drivers\etc\hosts"
$hostfile = Get-Content $file
$linesToCopy = $hostfile | Where-Object { $_ -notmatch '^#' }  # Select lines that don't start with "#"
$linesToCopy | Out-File -FilePath "C:\Windows\System32\drivers\etc\OldHost" -Append  # Copy lines to OldHost file
$hostfile = $hostfile | Where-Object { $_ -match '^#' }  # Remove lines that don't start with "#"
$hostfile += $NewLine
Set-Content -Path $file -Value $hostfile -Force