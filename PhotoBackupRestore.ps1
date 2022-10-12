<# This form was created using POSHGUI.com  a free online gui designer for PowerShell
.NAME
    Untitled
#>
$explorerprocesses = @(Get-WmiObject -Query "Select * FROM Win32_Process WHERE Name='explorer.exe'" -ErrorAction SilentlyContinue)
If ($explorerprocesses.Count -eq 0)
{
    "No explorer process found / Nobody interactively logged on"
}
Else
{
    ForEach ($i in $explorerprocesses)
    {
        $Username = $i.GetOwner().User
        $Domain = $i.GetOwner().Domain
       #Write-Host "$Domain\$Username logged on since: $($i.ConvertToDateTime($i.CreationDate))"
    }
}
# Functions
function RunTheCopy ($InFrom,$ToPath) {
    $RoboOptions = "/E", "/XA:SH", "/R:5", "/W:15", "/MT:32", "/LOG:$($ToPath)\BackupLog.txt"
    $Destination = "$ToPath\$($InFrom.substring($TextBoxSourcePC.Text.Length+3))"
    #$LoadingAnimation = @(".....","0....",".0...","..0..","...0.","....0",".....")
    #$AnimationCount = 0
    #$TextBoxOutput.Text += "From=$InFrom To=$Destination"
    RoboCopy $InFrom $Destination $RoboOptions 
}

function RunTheOtherCopy ($InFrom,$ToPath) {
    $RoboOptions = "/E", "/XA:SH", "/R:5", "/W:15", "/MT:32", "/LOG:$($ToPath)\BackupLog.txt"
    $Destination = "$ToPath\$($InFrom.substring(3))"
    #$LoadingAnimation = @(".....","0....",".0...","..0..","...0.","....0",".....")
    #$AnimationCount = 0
    #$TextBoxOutput.Text += "From=$InFrom To=$Destination"
    RoboCopy $InFrom $Destination $RoboOptions 
}

function RunXCopy ($InFrom,$InType,$ToPath) {
    $XOptions = "/S", "/C", "/Y", "/D"
    $Destination = "$ToPath\$($InFrom.substring($TextBoxSourcePC.Text.Length+3))"
    XCopy $InFrom $Destination $XOptions 
}

function RunXOtherCopy ($InFrom,$InType,$ToPath) {
    $XOptions = "/S", "/C", "/Y", "/D"
    $Destination = "$ToPath\$($InFrom.substring(3))"
    XCopy $InFrom $Destination $XOptions 
}

function PhotoAllC () {
    If ($CheckBoxPhotoC.Checked -eq $true) {
            $CheckBoxPhotoUser.checked        = $false
            $CheckBoxPhotoPictures.checked    = $false
            $CheckBoxPhotoOther.checked       = $false

            $CheckBoxPhotoUser.Enabled        = $false
            $CheckBoxPhotoPictures.Enabled    = $false
            $CheckBoxPhotoOther.Enabled       = $false
            $TextBoxOtherPhoto.Enabled        = $false
    }
    If ($CheckBoxPhotoC.Checked -eq $false) {
            $CheckBoxPhotoUser.checked        = $false
            $CheckBoxPhotoPictures.checked    = $true
            $CheckBoxPhotoOther.checked       = $false

            $CheckBoxPhotoUser.Enabled        = $true
            $CheckBoxPhotoPictures.Enabled    = $true
            $CheckBoxPhotoOther.Enabled       = $true
            $TextBoxOtherPhoto.Enabled        = $true
    }
}

function OneUserBackup () {
    If ($CheckBoxLoggedInUser.checked -eq $true ){
            $CheckBoxContacts.checked         = $false
            $CheckBoxDesktop.checked          = $false
            $CheckBoxDocuments.checked        = $false
            $CheckBoxDownloads.checked        = $false
            $CheckBoxFireFoxBookmarks.checked = $false
            $CheckBoxChrome.checked           = $false
            $CheckBoxIEBookmarks.checked      = $false
            $CheckBoxMusic.checked            = $false
            $CheckBoxPictures.checked         = $false
            $CheckBoxVideos.checked           = $false
            $CheckBoxAllUsers.Checked         = $false

            $CheckBoxContacts.Enabled         = $false
            $CheckBoxDesktop.Enabled          = $false
            $CheckBoxDocuments.Enabled        = $false
            $CheckBoxDownloads.Enabled        = $false
            $CheckBoxFireFoxBookmarks.Enabled = $false
            $CheckBoxChrome.Enabled           = $false
            $CheckBoxIEBookmarks.Enabled      = $false
            $CheckBoxMusic.Enabled            = $false
            $CheckBoxPictures.Enabled         = $false
            $CheckBoxVideos.Enabled           = $false
            $CheckBoxAllUsers.Enabled         = $false

    }
    If ($CheckBoxLoggedInUser.Checked -eq $false ) {
            $CheckBoxContacts.Enabled         = $true
            $CheckBoxDesktop.Enabled          = $true
            $CheckBoxDocuments.Enabled        = $true
            $CheckBoxDownloads.Enabled        = $true
            $CheckBoxFireFoxBookmarks.Enabled = $true
            $CheckBoxChrome.Enabled           = $true
            $CheckBoxIEBookmarks.Enabled      = $true
            $CheckBoxMusic.Enabled            = $true
            $CheckBoxPictures.Enabled         = $true
            $CheckBoxVideos.Enabled           = $true
            $CheckBoxAllUsers.Enabled         = $true

            $CheckBoxContacts.checked         = $true
            $CheckBoxDesktop.checked          = $true
            $CheckBoxDocuments.checked        = $true
            $CheckBoxDownloads.checked        = $false
            $CheckBoxFireFoxBookmarks.checked = $false
            $CheckBoxChrome.checked           = $false
            $CheckBoxIEBookmarks.checked      = $true
            $CheckBoxMusic.checked            = $true
            $CheckBoxPictures.checked         = $true
            $CheckBoxVideos.checked           = $true
            $CheckBoxAllUsers.checked         = $false
    }
}

function AllUserBackup () {
    If ($CheckBoxAllUsers.checked -eq $true ){
            $CheckBoxContacts.checked         = $false
            $CheckBoxDesktop.checked          = $false
            $CheckBoxDocuments.checked        = $false
            $CheckBoxDownloads.checked        = $false
            $CheckBoxFireFoxBookmarks.checked = $false
            $CheckBoxChrome.checked           = $false
            $CheckBoxIEBookmarks.checked      = $false
            $CheckBoxMusic.checked            = $false
            $CheckBoxPictures.checked         = $false
            $CheckBoxVideos.checked           = $false
            $CheckBoxLoggedInUser.Checked     = $false

            $CheckBoxContacts.Enabled         = $false
            $CheckBoxDesktop.Enabled          = $false
            $CheckBoxDocuments.Enabled        = $false
            $CheckBoxDownloads.Enabled        = $false
            $CheckBoxFireFoxBookmarks.Enabled = $false
            $CheckBoxChrome.Enabled           = $false
            $CheckBoxIEBookmarks.Enabled      = $false
            $CheckBoxMusic.Enabled            = $false
            $CheckBoxPictures.Enabled         = $false
            $CheckBoxVideos.Enabled           = $false
            $CheckBoxLoggedInUser.Enabled     = $false

    }
    If ($CheckBoxAllUsers.Checked -eq $false ) {
            $CheckBoxContacts.Enabled         = $true
            $CheckBoxDesktop.Enabled          = $true
            $CheckBoxDocuments.Enabled        = $true
            $CheckBoxDownloads.Enabled        = $true
            $CheckBoxFireFoxBookmarks.Enabled = $true
            $CheckBoxChrome.Enabled           = $true
            $CheckBoxIEBookmarks.Enabled      = $true
            $CheckBoxMusic.Enabled            = $true
            $CheckBoxPictures.Enabled         = $true
            $CheckBoxVideos.Enabled           = $true
            $CheckBoxLoggedInUser.Enabled     = $true

            $CheckBoxContacts.checked         = $true
            $CheckBoxDesktop.checked          = $true
            $CheckBoxDocuments.checked        = $true
            $CheckBoxDownloads.checked        = $false
            $CheckBoxFireFoxBookmarks.checked = $false
            $CheckBoxChrome.checked           = $false
            $CheckBoxIEBookmarks.checked      = $true
            $CheckBoxMusic.checked            = $true
            $CheckBoxPictures.checked         = $true
            $CheckBoxVideos.checked           = $true
            $CheckBoxLoggedInUser.checked     = $false
    }
}

function RestoreMenu () {
            $CheckBoxContacts.Visible         = $false
            $CheckBoxDesktop.Visible          = $false
            $CheckBoxDocuments.Visible        = $false
            $CheckBoxDownloads.Visible        = $false
            $CheckBoxFireFoxBookmarks.Visible = $false
            $CheckBoxChrome.Visible           = $false
            $CheckBoxIEBookmarks.Visible      = $false
            $CheckBoxMusic.Visible            = $false
            $CheckBoxPictures.Visible         = $false
            $CheckBoxVideos.Visible           = $false
            $CheckBoxLoggedInUser.Visible     = $false
            $LabelBackupTo.Visible            = $false
            $TextBoxBackupTo.Visible          = $false
            $CheckBoxOther1.Visible           = $false
            $TextBoxOther1.Visible            = $false
            $CheckBoxOther2.Visible           = $false
            $TextBoxOther2.Visible            = $false
            $CheckBoxOther3.Visible           = $false
            $TextBoxOther3.Visible            = $false
            $CheckBoxLoggedInUser.Visible     = $false
            $CheckBoxAllUsers.Visible         = $false
            $LabelRestoreFrom.Visible         = $true
            $TextBoxFrom.Visible              = $true
            $LabelRestoreTo.Visible           = $true
            $TextBoxRestoreTo.Visible         = $true
            $LabelSourcePC.Visible            = $false
            $TextBoxSourcePC.Visible          = $false
            $LabelUserID.Visible              = $false
            $TextBoxUserID.Visible            = $false
            $CheckBoxAI.Visible               = $false
            $CheckBoxEPS.Visible              = $false
            $CheckBoxGIF.Visible              = $false
            $CheckBoxINDD.Visible             = $false
            $CheckBoxJPG.Visible              = $false
            $CheckBoxJPEG.Visible             = $false
            $CheckBoxPDF.Visible              = $false
            $CheckBoxPNG.Visible              = $false
            $CheckBoxPSD.Visible              = $false
            $CheckBoxRAW.Visible              = $false
            $CheckBoxTIFF.Visible             = $flase
            $CheckBoxPhotoC.Visible           = $false
            $CheckBoxPhotoUser.Visible        = $false
            $CheckBoxPhotoPictures.Visible    = $false
            $CheckBoxPhotoOther.Visible       = $false
            $TextBoxOtherPhoto.Visible        = $false


            $CheckBoxContacts.Enabled         = $false
            $CheckBoxDesktop.Enabled          = $false
            $CheckBoxDocuments.Enabled        = $false
            $CheckBoxDownloads.Enabled        = $false
            $CheckBoxFireFoxBookmarks.Enabled = $false
            $CheckBoxChrome.Enabled           = $false
            $CheckBoxIEBookmarks.Enabled      = $false
            $CheckBoxMusic.Enabled            = $false
            $CheckBoxPictures.Enabled         = $false
            $CheckBoxVideos.Enabled           = $false
            $CheckBoxLoggedInUser.Enabled     = $false
            $LabelBackupTo.Enabled            = $false
            $TextBoxBackupTo.Enabled          = $false
            $CheckBoxOther1.Enabled           = $false
            $TextBoxOther1.Enabled            = $false
            $CheckBoxOther2.Enabled           = $false
            $TextBoxOther2.Enabled            = $false
            $CheckBoxOther3.Enabled           = $false
            $TextBoxOther3.Enabled            = $false
            $CheckBoxLoggedInUser.Enabled     = $false
            $CheckBoxAllUsers.Enabled         = $false
            $LabelRestoreFrom.Enabled         = $true
            $TextBoxFrom.Enabled              = $true
            $LabelRestoreTo.Enabled           = $true
            $TextBoxRestoreTo.Enabled         = $true
            $LabelSourcePC.Enabled            = $false
            $TextBoxSourcePC.Enabled          = $false
            $LabelUserID.Enabled              = $false
            $TextBoxUserID.Enabled            = $false
            $CheckBoxAI.Enabled               = $false
            $CheckBoxEPS.Enabled              = $false
            $CheckBoxGIF.Enabled              = $false
            $CheckBoxINDD.Enabled             = $false
            $CheckBoxJPG.Enabled              = $false
            $CheckBoxJPEG.Enabled             = $false
            $CheckBoxPDF.Enabled              = $false
            $CheckBoxPNG.Enabled              = $false
            $CheckBoxPSD.Enabled              = $false
            $CheckBoxRAW.Enabled              = $false
            $CheckBoxTIFF.Enabled             = $false
            $CheckBoxPhotoC.Enabled           = $false
            $CheckBoxPhotoUser.Enabled        = $false
            $CheckBoxPhotoPictures.Enabled    = $false
            $CheckBoxPhotoOther.Enabled       = $false
            $TextBoxOtherPhoto.Enabled        = $false
            $CheckBoxPhotoPictures.Enabled    = $false

}

function BackupMenu () {
            $CheckBoxContacts.Visible         = $true
            $CheckBoxDesktop.Visible          = $true
            $CheckBoxDocuments.Visible        = $true
            $CheckBoxDownloads.Visible        = $true
            $CheckBoxFireFoxBookmarks.Visible = $true
            $CheckBoxChrome.Visible           = $true
            $CheckBoxIEBookmarks.Visible      = $true
            $CheckBoxMusic.Visible            = $true
            $CheckBoxPictures.Visible         = $true
            $CheckBoxVideos.Visible           = $true
            $CheckBoxLoggedInUser.Visible     = $true
            $LabelBackupTo.Visible            = $true
            $TextBoxBackupTo.Visible          = $true
            $CheckBoxOther1.Visible           = $true
            $TextBoxOther1.Visible            = $true
            $CheckBoxOther2.Visible           = $true
            $TextBoxOther2.Visible            = $true
            $CheckBoxOther3.Visible           = $true
            $TextBoxOther3.Visible            = $true
            $CheckBoxLoggedInUser.Visible     = $true
            $CheckBoxAllUsers.Visible         = $true
            $LabelRestoreFrom.Visible         = $false
            $TextBoxFrom.Visible              = $false
            $LabelRestoreTo.Visible           = $false
            $TextBoxRestoreTo.Visible         = $false
            $LabelSourcePC.Visible            = $true
            $TextBoxSourcePC.Visible          = $true
            $LabelUserID.Visible              = $true
            $TextBoxUserID.Visible            = $true
            $CheckBoxAI.Visible               = $false
            $CheckBoxEPS.Visible              = $false
            $CheckBoxGIF.Visible              = $false
            $CheckBoxINDD.Visible             = $false
            $CheckBoxJPG.Visible              = $false
            $CheckBoxJPEG.Visible             = $false
            $CheckBoxPDF.Visible              = $false
            $CheckBoxPNG.Visible              = $false
            $CheckBoxPSD.Visible              = $false
            $CheckBoxRAW.Visible              = $false
            $CheckBoxTIFF.Visible             = $false
            $CheckBoxPhotoC.Visible           = $false
            $CheckBoxPhotoUser.Visible        = $false
            $CheckBoxPhotoPictures.Visible    = $false
            $CheckBoxPhotoOther.Visible       = $false
            $TextBoxOtherPhoto.Visible        = $false
            $CheckBoxOther1.Visible           = $true
            $TextBoxOther1.Visible            = $true
            $CheckBoxOther2.Visible           = $true
            $TextBoxOther2.Visible            = $true
            $CheckBoxOther3.Visible           = $true
            $TextBoxOther3.Visible            = $true
            $CheckBoxLoggedInUser.Visible     = $true
            $CheckBoxAllUsers.Visible         = $true

            $CheckBoxContacts.Enabled         = $true
            $CheckBoxDesktop.Enabled          = $true
            $CheckBoxDocuments.Enabled        = $true
            $CheckBoxDownloads.Enabled        = $true
            $CheckBoxFireFoxBookmarks.Enabled = $true
            $CheckBoxChrome.Enabled           = $true
            $CheckBoxIEBookmarks.Enabled      = $true
            $CheckBoxMusic.Enabled            = $true
            $CheckBoxPictures.Enabled         = $true
            $CheckBoxVideos.Enabled           = $true
            $CheckBoxLoggedInUser.Enabled     = $true
            $LabelBackupTo.Enabled            = $true
            $TextBoxBackupTo.Enabled          = $true
            $CheckBoxOther1.Enabled           = $true
            $TextBoxOther1.Enabled            = $true
            $CheckBoxOther2.Enabled           = $true
            $TextBoxOther2.Enabled            = $true
            $CheckBoxOther3.Enabled           = $true
            $TextBoxOther3.Enabled            = $true
            $CheckBoxLoggedInUser.Enabled     = $true
            $CheckBoxAllUsers.Enabled         = $true
            $LabelRestoreFrom.Enabled         = $false
            $TextBoxFrom.Enabled              = $false
            $LabelRestoreTo.Enabled           = $false
            $TextBoxRestoreTo.Enabled         = $false
            $LabelSourcePC.Enabled            = $true
            $TextBoxSourcePC.Enabled          = $true
            $LabelUserID.Enabled              = $true
            $TextBoxUserID.Enabled            = $true
            $CheckBoxAI.Enabled               = $false
            $CheckBoxEPS.Enabled              = $false
            $CheckBoxGIF.Enabled              = $false
            $CheckBoxINDD.Enabled             = $false
            $CheckBoxJPG.Enabled              = $false
            $CheckBoxJPEG.Enabled             = $false
            $CheckBoxPDF.Enabled              = $false
            $CheckBoxPNG.Enabled              = $false
            $CheckBoxPSD.Enabled              = $false
            $CheckBoxRAW.Enabled              = $false
            $CheckBoxTIFF.Enabled             = $false
            $CheckBoxPhotoC.Enabled           = $false
            $CheckBoxPhotoUser.Enabled        = $false
            $CheckBoxPhotoPictures.Enabled    = $false
            $CheckBoxPhotoOther.Enabled       = $false
            $TextBoxOtherPhoto.Enabled        = $false
            $CheckBoxOther1.Enabled           = $true
            $TextBoxOther1.Enabled            = $true
            $CheckBoxOther2.Enabled           = $true
            $TextBoxOther2.Enabled            = $true
            $CheckBoxOther3.Enabled           = $true
            $TextBoxOther3.Enabled            = $true
            $CheckBoxLoggedInUser.Enabled     = $true
            $CheckBoxAllUsers.Enabled         = $true
            $CheckBoxLoggedInUser.Enabled     = $true
            $CheckBoxAllUsers.Enabled         = $true
}

function PhotMenu (){
            $CheckBoxContacts.Visible         = $false
            $CheckBoxDesktop.Visible          = $false
            $CheckBoxDocuments.Visible        = $false
            $CheckBoxDownloads.Visible        = $false
            $CheckBoxFireFoxBookmarks.Visible = $false
            $CheckBoxChrome.Visible           = $false
            $CheckBoxIEBookmarks.Visible      = $false
            $CheckBoxMusic.Visible            = $false
            $CheckBoxPictures.Visible         = $false
            $CheckBoxVideos.Visible           = $false
            $CheckBoxLoggedInUser.Visible     = $false
            $LabelBackupTo.Visible            = $true
            $TextBoxBackupTo.Visible          = $true
            $CheckBoxOther1.Visible           = $true
            $TextBoxOther1.Visible            = $true
            $CheckBoxOther2.Visible           = $true
            $TextBoxOther2.Visible            = $true
            $CheckBoxOther3.Visible           = $true
            $TextBoxOther3.Visible            = $true
            $CheckBoxLoggedInUser.Visible     = $true
            $CheckBoxAllUsers.Visible         = $true
            $LabelRestoreFrom.Visible         = $false
            $TextBoxFrom.Visible              = $false
            $LabelRestoreTo.Visible           = $false
            $TextBoxRestoreTo.Visible         = $false
            $LabelSourcePC.Visible            = $true
            $TextBoxSourcePC.Visible          = $true
            $LabelUserID.Visible              = $true
            $TextBoxUserID.Visible            = $true
            $CheckBoxAI.Visible               = $true
            $CheckBoxEPS.Visible              = $true
            $CheckBoxGIF.Visible              = $true
            $CheckBoxINDD.Visible             = $true
            $CheckBoxJPG.Visible              = $true
            $CheckBoxJPEG.Visible             = $true
            $CheckBoxPDF.Visible              = $true
            $CheckBoxPNG.Visible              = $true
            $CheckBoxPSD.Visible              = $true
            $CheckBoxRAW.Visible              = $true
            $CheckBoxTIFF.Visible             = $true
            $CheckBoxPhotoC.Visible           = $true
            $CheckBoxPhotoUser.Visible        = $true
            $CheckBoxPhotoPictures.Visible    = $true
            $CheckBoxPhotoOther.Visible       = $true
            $TextBoxOtherPhoto.Visible        = $true
            $CheckBoxOther1.Visible           = $false
            $TextBoxOther1.Visible            = $false
            $CheckBoxOther2.Visible           = $false
            $TextBoxOther2.Visible            = $false
            $CheckBoxOther3.Visible           = $false
            $TextBoxOther3.Visible            = $false
            $CheckBoxLoggedInUser.Visible     = $false
            $CheckBoxAllUsers.Visible         = $false

            $CheckBoxContacts.Enabled         = $false
            $CheckBoxDesktop.Enabled          = $false
            $CheckBoxDocuments.Enabled        = $false
            $CheckBoxDownloads.Enabled        = $false
            $CheckBoxFireFoxBookmarks.Enabled = $false
            $CheckBoxChrome.Enabled           = $false
            $CheckBoxIEBookmarks.Enabled      = $false
            $CheckBoxMusic.Enabled            = $false
            $CheckBoxPictures.Enabled         = $false
            $CheckBoxVideos.Enabled           = $false
            $CheckBoxLoggedInUser.Enabled     = $false
            $LabelBackupTo.Enabled            = $true
            $TextBoxBackupTo.Enabled          = $true
            $CheckBoxOther1.Enabled           = $true
            $TextBoxOther1.Enabled            = $true
            $CheckBoxOther2.Enabled           = $true
            $TextBoxOther2.Enabled            = $true
            $CheckBoxOther3.Enabled           = $true
            $TextBoxOther3.Enabled            = $true
            $CheckBoxLoggedInUser.Enabled     = $true
            $CheckBoxAllUsers.Enabled         = $true
            $LabelRestoreFrom.Enabled         = $false
            $TextBoxFrom.Enabled              = $false
            $LabelRestoreTo.Enabled           = $false
            $TextBoxRestoreTo.Enabled         = $false
            $LabelSourcePC.Enabled            = $true
            $TextBoxSourcePC.Enabled          = $true
            $LabelUserID.Enabled              = $true
            $TextBoxUserID.Enabled            = $true
            $CheckBoxAI.Enabled               = $true
            $CheckBoxEPS.Enabled              = $true
            $CheckBoxGIF.Enabled              = $true
            $CheckBoxINDD.Enabled             = $true
            $CheckBoxJPG.Enabled              = $true
            $CheckBoxJPEG.Enabled             = $true
            $CheckBoxPDF.Enabled              = $true
            $CheckBoxPNG.Enabled              = $true
            $CheckBoxPSD.Enabled              = $true
            $CheckBoxRAW.Enabled              = $true
            $CheckBoxTIFF.Enabled             = $true
            $CheckBoxPhotoC.Enabled           = $true
            $CheckBoxPhotoUser.Enabled        = $true
            $CheckBoxPhotoPictures.Enabled    = $true
            $CheckBoxPhotoOther.Enabled       = $true
            $TextBoxOtherPhoto.Enabled        = $true
            $CheckBoxOther1.Enabled           = $false
            $TextBoxOther1.Enabled            = $false
            $CheckBoxOther2.Enabled           = $false
            $TextBoxOther2.Enabled            = $false
            $CheckBoxOther3.Enabled           = $false
            $TextBoxOther3.Enabled            = $false
            $CheckBoxLoggedInUser.Enabled     = $false
            $CheckBoxAllUsers.Enabled         = $false
}

function StartBackup (){

If ($RadioButtonBackup.Checked -eq $true) {
    $FromPC   = [RegEx]::Escape("\$($TextBoxSourcePC.Text)")+'\C$'
    $FromUser = $("\Users\$($TextBoxUserID.Text)")
    $FromPath = $("$FromPC$FromUser")
    $ToPath   = $("$($TextBoxBackupTo.Text)")
    If(!(test-path $FromPC)) {
        $TimeNow = Get-Date
        $TimeNow = $TimeNow.ToUniversalTime().ToString("HH:mm:ss")
        $TextBoxOutput.Text = "$($TimeNow) Path $($FromPC) Is Not Valid`r`n" 
        Return 
    }
    If(!(test-path "$FromPC$FromUser")) {
        $TimeNow = Get-Date
        $TimeNow = $TimeNow.ToUniversalTime().ToString("HH:mm:ss")
        $TextBoxOutput.Text = "$($TimeNow) From Path $("$FromPC$FromUser") Is Not Valid`r`n" 
        Return 
    }
    If(!(test-path $ToPath)) {
        $TimeNow = Get-Date
        $TimeNow = $TimeNow.ToUniversalTime().ToString("HH:mm:ss")
            New-Item -ItemType Directory -Force -Path $ToPath
            If(!(test-path $ToPath)) {
               $TextBoxOutput.Text = "$($TimeNow) To Path $($ToPath) Is Not Valid`r`n" 
               Return 
            }
        }
    $TimeNow = Get-Date
    $TimeNow = $TimeNow.ToUniversalTime().ToString("HH:mm:ss")
    $TextBoxOutput.Text = "$("$TimeNow") Starting backup From: $("$FromPath") To: $($ToPath) PLEASE WAIT!`r`n"
    $Output = "$("$TimeNow") User: $("$Username") Starting backup From: $("$FromPath") To: $($ToPath)"

    If ($CheckBoxLoggedInUser.checked -eq $true) {
        $TimeNow = Get-Date
        $TimeNow = $TimeNow.ToUniversalTime().ToString("HH:mm:ss")
        $UPath = $FromPath
        If(!(test-path $UPath)) {
            $TextBoxOutput.Text += "$($TimeNow) Path $($UPath) Is Not Valid`r`n" 
        }
        Else {
            $TextBoxOutput.Text += "$($TimeNow) Backup Started \Users\$Username`r`n"
            RunTheCopy ($UPath) ($ToPath)
        }
    }
    If ($CheckBoxAllUsers.checked -eq $true) {
        $TimeNow = Get-Date
        $TimeNow = $TimeNow.ToUniversalTime().ToString("HH:mm:ss")
        $ALLUPath = "$FromPC"
        If(!(test-path $ALLUPath)) {
            $TextBoxOutput.Text += "$($TimeNow) Path $($ALLUPath) Is Not Valid`r`n" 
        }
        Else {
            $TextBoxOutput.Text += "$($TimeNow) Backup Started C:\`r`n"
            RunTheCopy ($ALLUPath) ($ToPath)
        }
    }

    If ($CheckBoxContacts.checked -eq $true) {
        $TimeNow = Get-Date
        $TimeNow = $TimeNow.ToUniversalTime().ToString("HH:mm:ss")
        $ContactsPath = "$("$FromPath\Contacts")"
        If(!(test-path $ContactsPath)) {
            $TextBoxOutput.Text += "$($TimeNow) Path $($ContactsPath) Is Not Valid`r`n" 
        }
        Else {
            $TextBoxOutput.Text += "$($TimeNow) Backup Started for Contacts`r`n"
            RunTheCopy ($ContactsPath) ($ToPath)
        }
    }
    If ($CheckBoxDesktop.checked -eq $true) {
        $TimeNow = Get-Date
        $TimeNow = $TimeNow.ToUniversalTime().ToString("HH:mm:ss")
        $DesktopPath = "$("$FromPath\Desktop")"
        If(!(test-path $DesktopPath)) {
            $TextBoxOutput.Text += "$($TimeNow) Path $($DesktopPath) Is Not Valid`r`n" 
        }
        Else {
            $TextBoxOutput.Text += "$($TimeNow) Backup Started for Desktop`r`n"
            RunTheCopy ($DesktopPath) ($ToPath)
        }
    }
    If ($CheckBoxDocuments.checked -eq $true) {
        $TimeNow = Get-Date
        $TimeNow = $TimeNow.ToUniversalTime().ToString("HH:mm:ss")
        $DocumentsPath = "$("$FromPath\Documents")"
        If(!(test-path $DocumentsPath)) {
            $TextBoxOutput.Text += "$($TimeNow) Path $($DocumentsPath) Is Not Valid`r`n" 
        }
        Else {
            $TextBoxOutput.Text += "$($TimeNow) Backup Started for Documents`r`n"
            RunTheCopy ($DocumentsPath) ($ToPath)
        }
    }
    If ($CheckBoxDownloads.checked -eq $true) {
        $TimeNow = Get-Date
        $TimeNow = $TimeNow.ToUniversalTime().ToString("HH:mm:ss")
        $DownloadsPath = "$("$FromPath\Downloads")"
        If(!(test-path $DownloadsPath)) {
            $TextBoxOutput.Text += "$($TimeNow) Path $($DownloadsPath) Is Not Valid`r`n" 
        }
        Else {
            $TextBoxOutput.Text += "$($TimeNow) Backup Started for Downloads`r`n"
            RunTheCopy ($DownloadsPath) ($ToPath)
        }
    }
    If ($CheckBoxFireFoxBookmarks.checked -eq $true) {
        $TimeNow = Get-Date
        $TimeNow = $TimeNow.ToUniversalTime().ToString("HH:mm:ss")
        $FireFoxPath = "$("$FromPath\AppData\Local\Mozilla\Firefox")"
        If(!(test-path $FireFoxPath)) {
            $TextBoxOutput.Text += "$($TimeNow) Path $($FireFoxPath) Is Not Valid`r`n" 
        }
        Else {
            $TextBoxOutput.Text += "$($TimeNow) Backup Started for FireFox Bookmarks`r`n"
            RunTheCopy ($FireFoxPath) ($ToPath)
        }
    }
    If ($CheckBoxChrome.checked -eq $true) {
        $TimeNow = Get-Date
        $TimeNow = $TimeNow.ToUniversalTime().ToString("HH:mm:ss")
        $ChromePath = "$("$FromPath\AppData\Local\Google\Chrome\User Data")"
        If(!(test-path $ChromePath)) {
            $TextBoxOutput.Text += "$($TimeNow) Path $($ChromePath) Is Not Valid`r`n" 
        }
        Else {
            $TextBoxOutput.Text += "$($TimeNow) Backup Started for Chrome Bookmarks`r`n"
            RunTheCopy ($ChromePath) ($ToPath)
        }
    }
    If ($CheckBoxIEBookmarks.checked -eq $true) {
        $TimeNow = Get-Date
        $TimeNow = $TimeNow.ToUniversalTime().ToString("HH:mm:ss")
        $FavoritesPath = "$("$FromPath\Favorites")"
        If(!(test-path $FavoritesPath)) {
            $TextBoxOutput.Text += "$($TimeNow) Path $($FavoritesPath) Is Not Valid`r`n" 
        }
        Else {
            $TextBoxOutput.Text += "$($TimeNow) Backup Started for Favorites`r`n"
            RunTheCopy ($FavoritesPath) ($ToPath)
        }
        $LinksPath = "$("$FromPath\Links")"
        If(!(test-path $LinksPath)) {
            $TextBoxOutput.Text += "$($TimeNow) Path $($LinksPath) Is Not Valid`r`n" 
        }
        Else {
            $TextBoxOutput.Text += "$($TimeNow) Backup Started for Links`r`n"
            RunTheCopy ($LinksPath) ($ToPath)
        }
    }
    If ($CheckBoxMusic.checked -eq $true) {
        $TimeNow = Get-Date
        $TimeNow = $TimeNow.ToUniversalTime().ToString("HH:mm:ss")
        $MusicPath = "$("$FromPath\Music")"
        If(!(test-path $MusicPath)) {
            $TextBoxOutput.Text += "$($TimeNow) Path $($MusicPath) Is Not Valid`r`n" 
        }
        Else {
            $TextBoxOutput.Text += "$($TimeNow) Backup Started for Music`r`n"
            RunTheCopy ($MusicPath) ($ToPath)
        }
    }
    If ($CheckBoxPictures.checked -eq $true) {
        $TimeNow = Get-Date
        $TimeNow = $TimeNow.ToUniversalTime().ToString("HH:mm:ss")
        $PicturesPath = "$("$FromPath\Pictures")"
        If(!(test-path $PicturesPath)) {
            $TextBoxOutput.Text += "$($TimeNow) Path $($PicturesPath) Is Not Valid`r`n" 
        }
        Else {
            $TextBoxOutput.Text += "$($TimeNow) Backup Started for Pictures`r`n"
            RunTheCopy ($PicturesPath) ($ToPath)
        }
    }
    If ($CheckBoxVideos.checked -eq $true) {
        $TimeNow = Get-Date
        $TimeNow = $TimeNow.ToUniversalTime().ToString("HH:mm:ss")
        $VideosPath = "$("$FromPath\Videos")"
        If(!(test-path $VideosPath)) {
            $TextBoxOutput.Text += "$($TimeNow) Path $($VideosPath) Is Not Valid`r`n" 
        }
        Else {
            $TextBoxOutput.Text += "$($TimeNow) Backup Started for Videos`r`n"
            RunTheCopy ($VideosPath) ($ToPath)
        }
    }
    If ($CheckBoxOther1.checked -eq $true) {
        $TimeNow = Get-Date
        $TimeNow = $TimeNow.ToUniversalTime().ToString("HH:mm:ss")
        $Other1Path = $("$($TextBoxOther1.Text)")
        If(!(test-path $Other1Path)) {
            $TextBoxOutput.Text += "$($TimeNow) Path $($Other1Path) Is Not Valid`r`n" 
        }
        Else {
            $TextBoxOutput.Text += "$($TimeNow) Backup Started for $($TextBoxOther1.text)`r`n"
            RunTheOtherCopy ($Other1Path) ($ToPath)
        }
    }
    If ($CheckBoxOther2.checked -eq $true) {
        $TimeNow = Get-Date
        $TimeNow = $TimeNow.ToUniversalTime().ToString("HH:mm:ss")
        $Other2Path = $("$($TextBoxOther2.Text)")
        If(!(test-path $Other2Path)) {
            $TextBoxOutput.Text += "$($TimeNow) Path $($Other2Path) Is Not Valid`r`n" 
        }
        Else {
            $TextBoxOutput.Text += "$($TimeNow) Backup Started for $($TextBoxOther2.text)`r`n"
            RunTheOtherCopy ($Other2Path) ($ToPath)
        }
    }
    If ($CheckBoxOther3.checked -eq $true) {
    $TimeNow = Get-Date
        $TimeNow = $TimeNow.ToUniversalTime().ToString("HH:mm:ss")
        $Other3Path = $("$($TextBoxOther3.Text)")
        If(!(test-path $Other3Path)) {
            $TextBoxOutput.Text += "$($TimeNow) Path $($Other3Path) Is Not Valid`r`n" 
        }
        Else {
            $TextBoxOutput.Text += "$($TimeNow) Backup Started for $($TextBoxOther3.text)`r`n"
            RunTheOtherCopy ($Other3Path) ($ToPath)
        }
    }
    $TextBoxOutput.Text += "Done"
}
If ($RadioButtonRestore.Checked -eq $true) {
    $RestoreFromPath = $($TextBoxFrom.text)
    $RestoreToPath   = $($TextBoxRestoreTo.text)
    $RoboOptions = "/E", "/XA:SH", "/R:5", "/W:15", "/MT:32", "/LOG:$($RestoreToPath)\RestoreLog.txt"
    If(!(test-path $RestoreFromPath)) {
        $TextBoxOutput.Text = "$($TimeNow) Path $($RestoreFromPath) Is Not Valid`r`n" 
        Return 
    }
    If (!(test-path $RestoreToPath)) {
         New-Item -ItemType Directory -Force -Path $RestoreToPath
         If (!(test-path $RestoreToPath)) {
            $TextBoxOutput.Text = "$($TimeNow) Path $($RestoreToPath) Is Not Valid`r`n" 
            Return 
         }
     }
    $TimeNow = Get-Date
    $TimeNow = $TimeNow.ToUniversalTime().ToString("HH:mm:ss")
    $TextBoxOutput.Text = "$($TimeNow) Starting Restore From: $("$RestoreFromPath") To: $($RestoreToPat) PLEASE WAIT!`r`n"
    #$LoadingAnimation = @(".....","0....",".0...","..0..","...0.","....0",".....")
    #$AnimationCount = 0
    RoboCopy $RestoreFromPath $RestoreToPath $RoboOptions 
    $TimeNow = Get-Date
    $TimeNow = $TimeNow.ToUniversalTime().ToString("HH:mm:ss")
    $TextBoxOutput.Text += "$($TimeNow) Done`r`n"
}
If ($RadioButtonPhoto.Checked -eq $true) {
    $FromPC   = [RegEx]::Escape("\$($TextBoxSourcePC.Text)")+'\C$'
    $FromUser = $("\Users\$($TextBoxUserID.Text)")
    $FromPath = $("$FromPC$FromUser")
    $ToPath   = $("$($TextBoxBackupTo.Text)")
    If(!(test-path $FromPC)) {
        $TimeNow = Get-Date
        $TimeNow = $TimeNow.ToUniversalTime().ToString("HH:mm:ss")
        $TextBoxOutput.Text = "$($TimeNow) Path $($FromPC) Is Not Valid`r`n" 
        Return 
    }
    If(!(test-path "$FromPC$FromUser")) {
        $TimeNow = Get-Date
        $TimeNow = $TimeNow.ToUniversalTime().ToString("HH:mm:ss")
        $TextBoxOutput.Text = "$($TimeNow) From Path $("$FromPC$FromUser") Is Not Valid`r`n" 
        Return 
    }
    If(!(test-path $ToPath)) {
        $TimeNow = Get-Date
        $TimeNow = $TimeNow.ToUniversalTime().ToString("HH:mm:ss")
            New-Item -ItemType Directory -Force -Path $ToPath
            If(!(test-path $ToPath)) {
               $TextBoxOutput.Text = "$($TimeNow) To Path $($ToPath) Is Not Valid`r`n" 
               Return 
            }
        }
    $TimeNow = Get-Date
    $TimeNow = $TimeNow.ToUniversalTime().ToString("HH:mm:ss")
    $TextBoxOutput.Text = "$("$TimeNow") Starting backup From: $("$FromPath") To: $($ToPath) PLEASE WAIT!`r`n"
    $Output = "$("$TimeNow") User: $("$Username") Starting backup From: $("$FromPath") To: $($ToPath)"
 
}
}

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$FormBackupTool                  = New-Object system.Windows.Forms.Form
$FormBackupTool.ClientSize       = '680,720'
$FormBackupTool.text             = "`"As Is`" Backup Tool"
$FormBackupTool.TopMost          = $false

$LabelSourcePC                   = New-Object system.Windows.Forms.Label
$LabelSourcePC.text              = "Source PC"
$LabelSourcePC.AutoSize          = $true
$LabelSourcePC.width             = 25
$LabelSourcePC.height            = 10
$LabelSourcePC.location          = New-Object System.Drawing.Point(10,10)
$LabelSourcePC.Font              = 'Microsoft Sans Serif,10'

$TextBoxSourcePC                 = New-Object system.Windows.Forms.TextBox
$TextBoxSourcePC.multiline       = $false
$TextBoxSourcePC.text            = "$env:COMPUTERNAME"
$TextBoxSourcePC.width           = 160
$TextBoxSourcePC.height          = 20
$TextBoxSourcePC.location        = New-Object System.Drawing.Point(110,10)
$TextBoxSourcePC.Font            = 'Microsoft Sans Serif,10'

$LabelUserID                     = New-Object system.Windows.Forms.Label
$LabelUserID.text                = "User ID"
$LabelUserID.AutoSize            = $true
$LabelUserID.width               = 25
$LabelUserID.height              = 10
$LabelUserID.location            = New-Object System.Drawing.Point(300,10)
$LabelUserID.Font                = 'Microsoft Sans Serif,10'

$TextBoxUserID                   = New-Object system.Windows.Forms.TextBox
$TextBoxUserID.multiline         = $false
$TextBoxUserID.text              = "$Username"
$TextBoxUserID.width             = 100
$TextBoxUserID.height            = 20
$TextBoxUserID.location          = New-Object System.Drawing.Point(380,10)
$TextBoxUserID.Font              = 'Microsoft Sans Serif,10'

$LabelBackupTo                   = New-Object system.Windows.Forms.Label
$LabelBackupTo.text              = "Backup To:"
$LabelBackupTo.AutoSize          = $true
$LabelBackupTo.width             = 25
$LabelBackupTo.height            = 10
$LabelBackupTo.location          = New-Object System.Drawing.Point(10,35)
$LabelBackupTo.Font              = 'Microsoft Sans Serif,10'

$TextBoxBackupTo                 = New-Object system.Windows.Forms.TextBox
$TextBoxBackupTo.multiline       = $false
$TextBoxBackupTo.text            = "F:\Backup\$env:COMPUTERNAME"
$TextBoxBackupTo.width           = 550
$TextBoxBackupTo.height          = 20
$TextBoxBackupTo.location        = New-Object System.Drawing.Point(110,35)
$TextBoxBackupTo.Font            = 'Microsoft Sans Serif,10'

$CheckBoxAI                      = New-Object system.Windows.Forms.CheckBox
$CheckBoxAI.text                 = ".AI"
$CheckBoxAI.AutoSize             = $false
$CheckBoxAI.width                = 95
$CheckBoxAI.height               = 20
$CheckBoxAI.location             = New-Object System.Drawing.Point(10,70)
$CheckBoxAI.Font                 = 'Microsoft Sans Serif,10'
$CheckBoxAI.checked              = $true
$CheckBoxAI.Visible              = $false
$CheckBoxAI.Enabled              = $false

$CheckBoxEPS                     = New-Object system.Windows.Forms.CheckBox
$CheckBoxEPS.text                = ".EPS"
$CheckBoxEPS.AutoSize            = $false
$CheckBoxEPS.width               = 95
$CheckBoxEPS.height              = 20
$CheckBoxEPS.location            = New-Object System.Drawing.Point(10,90)
$CheckBoxEPS.Font                = 'Microsoft Sans Serif,10'
$CheckBoxEPS.checked             = $true
$CheckBoxEPS.Visible             = $false
$CheckBoxEPS.Enabled             = $false

$CheckBoxGIF                     = New-Object system.Windows.Forms.CheckBox
$CheckBoxGIF.text                = ".GIF"
$CheckBoxGIF.AutoSize            = $false
$CheckBoxGIF.width               = 95
$CheckBoxGIF.height              = 20
$CheckBoxGIF.location            = New-Object System.Drawing.Point(10,110)
$CheckBoxGIF.Font                = 'Microsoft Sans Serif,10'
$CheckBoxGIF.checked             = $true
$CheckBoxGIF.Visible             = $false
$CheckBoxGIF.Enabled             = $false

$CheckBoxINDD                    = New-Object system.Windows.Forms.CheckBox
$CheckBoxINDD.text               = ".INDD"
$CheckBoxINDD.AutoSize           = $false
$CheckBoxINDD.width              = 95
$CheckBoxINDD.height             = 20
$CheckBoxINDD.location           = New-Object System.Drawing.Point(10,130)
$CheckBoxINDD.Font               = 'Microsoft Sans Serif,10'
$CheckBoxINDD.checked            = $true
$CheckBoxINDD.Visible            = $false
$CheckBoxINDD.Enabled            = $false

$CheckBoxJPG                     = New-Object system.Windows.Forms.CheckBox
$CheckBoxJPG.text                = ".JPG"
$CheckBoxJPG.AutoSize            = $false
$CheckBoxJPG.width               = 95
$CheckBoxJPG.height              = 20
$CheckBoxJPG.location            = New-Object System.Drawing.Point(10,150)
$CheckBoxJPG.Font                = 'Microsoft Sans Serif,10'
$CheckBoxJPG.checked             = $true
$CheckBoxJPG.Visible             = $false
$CheckBoxJPG.Enabled             = $false

$CheckBoxJPEG                    = New-Object system.Windows.Forms.CheckBox
$CheckBoxJPEG.text               = ".JPEG"
$CheckBoxJPEG.AutoSize           = $false
$CheckBoxJPEG.width              = 95
$CheckBoxJPEG.height             = 20
$CheckBoxJPEG.location           = New-Object System.Drawing.Point(10,170)
$CheckBoxJPEG.Font               = 'Microsoft Sans Serif,10'
$CheckBoxJPEG.checked            = $true
$CheckBoxJPEG.Visible            = $false
$CheckBoxJPEG.Enabled            = $false

$CheckBoxPDF                     = New-Object system.Windows.Forms.CheckBox
$CheckBoxPDF.text                = ".PDF"
$CheckBoxPDF.AutoSize            = $false
$CheckBoxPDF.width               = 95
$CheckBoxPDF.height              = 20
$CheckBoxPDF.location            = New-Object System.Drawing.Point(10,190)
$CheckBoxPDF.Font                = 'Microsoft Sans Serif,10'
$CheckBoxPDF.checked             = $true
$CheckBoxPDF.Visible             = $false
$CheckBoxPDF.Enabled             = $false

$CheckBoxPNG                     = New-Object system.Windows.Forms.CheckBox
$CheckBoxPNG.text                = ".PNG"
$CheckBoxPNG.AutoSize            = $false
$CheckBoxPNG.width               = 95
$CheckBoxPNG.height              = 20
$CheckBoxPNG.location            = New-Object System.Drawing.Point(10,210)
$CheckBoxPNG.Font                = 'Microsoft Sans Serif,10'
$CheckBoxPNG.checked             = $true
$CheckBoxPNG.Visible             = $false
$CheckBoxPNG.Enabled             = $false

$CheckBoxPSD                     = New-Object system.Windows.Forms.CheckBox
$CheckBoxPSD.text                = ".PSD"
$CheckBoxPSD.AutoSize            = $false
$CheckBoxPSD.width               = 95
$CheckBoxPSD.height              = 20
$CheckBoxPSD.location            = New-Object System.Drawing.Point(10,230)
$CheckBoxPSD.Font                = 'Microsoft Sans Serif,10'
$CheckBoxPSD.checked             = $true
$CheckBoxPSD.Visible             = $false
$CheckBoxPSD.Enabled             = $false

$CheckBoxRAW                     = New-Object system.Windows.Forms.CheckBox
$CheckBoxRAW.text                = ".RAW"
$CheckBoxRAW.AutoSize            = $false
$CheckBoxRAW.width               = 95
$CheckBoxRAW.height              = 20
$CheckBoxRAW.location            = New-Object System.Drawing.Point(10,250)
$CheckBoxRAW.Font                = 'Microsoft Sans Serif,10'
$CheckBoxRAW.checked             = $true
$CheckBoxRAW.Visible             = $false
$CheckBoxRAW.Enabled             = $false

$CheckBoxTIFF                    = New-Object system.Windows.Forms.CheckBox
$CheckBoxTIFF.text               = ".TIFF"
$CheckBoxTIFF.AutoSize           = $false
$CheckBoxTIFF.width              = 95
$CheckBoxTIFF.height             = 20
$CheckBoxTIFF.location           = New-Object System.Drawing.Point(10,270)
$CheckBoxTIFF.Font               = 'Microsoft Sans Serif,10'
$CheckBoxTIFF.checked            = $true
$CheckBoxTIFF.Visible            = $false
$CheckBoxTIFF.Enabled            = $false

$CheckBoxContacts                = New-Object system.Windows.Forms.CheckBox
$CheckBoxContacts.text           = "Contacts (C:\Users\$Username\Contacts)"
$CheckBoxContacts.AutoSize       = $false
$CheckBoxContacts.width          = 400
$CheckBoxContacts.height         = 20
$CheckBoxContacts.location       = New-Object System.Drawing.Point(10,90)
$CheckBoxContacts.Font           = 'Microsoft Sans Serif,10'
$CheckBoxContacts.checked        = $true

$CheckBoxDesktop                 = New-Object system.Windows.Forms.CheckBox
$CheckBoxDesktop.text            = "Desktop (C:\Users\$Username\Desktop)"
$CheckBoxDesktop.AutoSize        = $false
$CheckBoxDesktop.width           = 400
$CheckBoxDesktop.height          = 20
$CheckBoxDesktop.location        = New-Object System.Drawing.Point(10,110)
$CheckBoxDesktop.Font            = 'Microsoft Sans Serif,10'
$CheckBoxDesktop.checked         = $true

$CheckBoxDocuments               = New-Object system.Windows.Forms.CheckBox
$CheckBoxDocuments.text          = "Documents (C:\Users\$Username\Documents)"
$CheckBoxDocuments.AutoSize      = $false
$CheckBoxDocuments.width         = 400
$CheckBoxDocuments.height        = 20
$CheckBoxDocuments.location      = New-Object System.Drawing.Point(10,130)
$CheckBoxDocuments.Font          = 'Microsoft Sans Serif,10'
$CheckBoxDocuments.checked       = $true

$CheckBoxDownloads               = New-Object system.Windows.Forms.CheckBox
$CheckBoxDownloads.text          = "Downloads (C:\Users\$Username\Downloads)"
$CheckBoxDownloads.AutoSize      = $false
$CheckBoxDownloads.width         = 400
$CheckBoxDownloads.height        = 20
$CheckBoxDownloads.location      = New-Object System.Drawing.Point(10,150)
$CheckBoxDownloads.Font          = 'Microsoft Sans Serif,10'
$CheckBoxDownloads.checked       = $true

$CheckBoxFireFoxBookmarks        = New-Object system.Windows.Forms.CheckBox
$CheckBoxFireFoxBookmarks.text   = "FireFox Bookmarks (C:\Users\$Username\AppData\Local\Mozilla\Firefox)"
$CheckBoxFireFoxBookmarks.AutoSize  = $false
$CheckBoxFireFoxBookmarks.width  = 600
$CheckBoxFireFoxBookmarks.height  = 20
$CheckBoxFireFoxBookmarks.location  = New-Object System.Drawing.Point(10,170)
$CheckBoxFireFoxBookmarks.Font   = 'Microsoft Sans Serif,10'
$CheckBoxFireFoxBookmarks.checked  = $false

$CheckBoxChrome                  = New-Object system.Windows.Forms.CheckBox
$CheckBoxChrome.text             = "Chrome ($env:localappdata\Google\Chrome\User Data)"
$CheckBoxChrome.AutoSize         = $flase
$CheckBoxChrome.width            = 650
$CheckBoxChrome.Height           = 20
$CheckBoxChrome.Location         = New-Object system.Drawing.Point (10,190)
$CheckBoxChrome.Font             = 'Microsoft Sans Serif,10'
$CheckBoxChrome.checked          = $false

$CheckBoxIEBookmarks             = New-Object system.Windows.Forms.CheckBox
$CheckBoxIEBookmarks.text        = "IE Bookmarks / Favorites / Links (C:\Users\$Username\Favoites... \Links)"
$CheckBoxIEBookmarks.AutoSize    = $false
$CheckBoxIEBookmarks.width       = 600
$CheckBoxIEBookmarks.height      = 20
$CheckBoxIEBookmarks.location    = New-Object System.Drawing.Point(10,210)
$CheckBoxIEBookmarks.Font        = 'Microsoft Sans Serif,10'
$CheckBoxIEBookmarks.checked     = $true

$CheckBoxMusic                   = New-Object system.Windows.Forms.CheckBox
$CheckBoxMusic.text              = "Music (C:\Users\$Username\Music)"
$CheckBoxMusic.AutoSize          = $false
$CheckBoxMusic.width             = 400
$CheckBoxMusic.height            = 20
$CheckBoxMusic.location          = New-Object System.Drawing.Point(10,230)
$CheckBoxMusic.Font              = 'Microsoft Sans Serif,10'
$CheckBoxMusic.checked           = $true

$CheckBoxPictures                = New-Object system.Windows.Forms.CheckBox
$CheckBoxPictures.text           = "Pictures (C:\Users\$Username\Pictures)"
$CheckBoxPictures.AutoSize       = $false
$CheckBoxPictures.width          = 400
$CheckBoxPictures.height         = 20
$CheckBoxPictures.location       = New-Object System.Drawing.Point(10,250)
$CheckBoxPictures.Font           = 'Microsoft Sans Serif,10'
$CheckBoxPictures.checked        = $true

$CheckBoxVideos                  = New-Object system.Windows.Forms.CheckBox
$CheckBoxVideos.text             = "Videos (C:\Users\$Username\Videos)"
$CheckBoxVideos.AutoSize         = $false
$CheckBoxVideos.width            = 400
$CheckBoxVideos.height           = 20
$CheckBoxVideos.location         = New-Object System.Drawing.Point(10,270)
$CheckBoxVideos.Font             = 'Microsoft Sans Serif,10'
$CheckBoxVideos.checked          = $true

$CheckBoxPhotoC                  = New-Object system.Windows.Forms.CheckBox
$CheckBoxPhotoC.text             = "Search all of (C:\)"
$CheckBoxPhotoC.AutoSize         = $false
$CheckBoxPhotoC.width            = 400
$CheckBoxPhotoC.height           = 20
$CheckBoxPhotoC.location         = New-Object System.Drawing.Point(10,310)
$CheckBoxPhotoC.Font             = 'Microsoft Sans Serif,10'
$CheckBoxPhotoC.checked          = $false
$CheckBoxPhotoC.Visible          = $false
$CheckBoxPhotoC.Enabled          = $false

$CheckBoxPhotoUser                = New-Object system.Windows.Forms.CheckBox
$CheckBoxPhotoUser.text           = "User Account (C:\Users\$Username)"
$CheckBoxPhotoUser.AutoSize       = $false
$CheckBoxPhotoUser.width          = 400
$CheckBoxPhotoUser.height         = 20
$CheckBoxPhotoUser.location       = New-Object System.Drawing.Point(10,330)
$CheckBoxPhotoUser.Font           = 'Microsoft Sans Serif,10'
$CheckBoxPhotoUser.checked        = $false
$CheckBoxPhotoUser.Visible        = $false
$CheckBoxPhotoUser.Enabled        = $false

$CheckBoxPhotoPictures                = New-Object system.Windows.Forms.CheckBox
$CheckBoxPhotoPictures.text           = "Defalult Pictures folder (C:\Users\$Username\Pictures)"
$CheckBoxPhotoPictures.AutoSize       = $false
$CheckBoxPhotoPictures.width          = 400
$CheckBoxPhotoPictures.height         = 20
$CheckBoxPhotoPictures.location       = New-Object System.Drawing.Point(10,350)
$CheckBoxPhotoPictures.Font           = 'Microsoft Sans Serif,10'
$CheckBoxPhotoPictures.checked        = $true
$CheckBoxPhotoPictures.Visible        = $false
$CheckBoxPhotoPictures.Enabled        = $false

$CheckBoxPhotoOther                = New-Object system.Windows.Forms.CheckBox
$CheckBoxPhotoOther.text           = "Search under this folder"
$CheckBoxPhotoOther.AutoSize       = $false
$CheckBoxPhotoOther.width          = 200
$CheckBoxPhotoOther.height         = 20
$CheckBoxPhotoOther.location       = New-Object System.Drawing.Point(10,370)
$CheckBoxPhotoOther.Font           = 'Microsoft Sans Serif,10'
$CheckBoxPhotoOther.checked        = $false
$CheckBoxPhotoOther.Visible        = $false
$CheckBoxPhotoOther.Enabled        = $false

$TextBoxOtherPhoto                   = New-Object system.Windows.Forms.TextBox
$TextBoxOtherPhoto.multiline         = $false
$TextBoxOtherPhoto.text              = "C:\MyStuff"
$TextBoxOtherPhoto.width             = 300
$TextBoxOtherPhoto.height            = 20
$TextBoxOtherPhoto.location          = New-Object System.Drawing.Point(220,370)
$TextBoxOtherPhoto.Font              = 'Microsoft Sans Serif,10'
$TextBoxOtherPhoto.Visible           = $false
$TextBoxOtherPhoto.Enabled           = $false

$CheckBoxOther1                  = New-Object system.Windows.Forms.CheckBox
$CheckBoxOther1.text             = "Other #1"
$CheckBoxOther1.AutoSize         = $false
$CheckBoxOther1.width            = 95
$CheckBoxOther1.height           = 20
$CheckBoxOther1.location         = New-Object System.Drawing.Point(10,310)
$CheckBoxOther1.Font             = 'Microsoft Sans Serif,10'
$CheckBoxOther1.checked          = $false

$TextBoxOther1                   = New-Object system.Windows.Forms.TextBox
$TextBoxOther1.multiline         = $false
$TextBoxOther1.text              = "C:\MyStuff"
$TextBoxOther1.width             = 500
$TextBoxOther1.height            = 20
$TextBoxOther1.location          = New-Object System.Drawing.Point(120,310)
$TextBoxOther1.Font              = 'Microsoft Sans Serif,10'

$CheckBoxOther2                  = New-Object system.Windows.Forms.CheckBox
$CheckBoxOther2.text             = "Other #2"
$CheckBoxOther2.AutoSize         = $false
$CheckBoxOther2.width            = 95
$CheckBoxOther2.height           = 20
$CheckBoxOther2.location         = New-Object System.Drawing.Point(10,330)
$CheckBoxOther2.Font             = 'Microsoft Sans Serif,10'
$CheckBoxOther2.checked          = $false

$TextBoxOther2                   = New-Object system.Windows.Forms.TextBox
$TextBoxOther2.multiline         = $false
$TextBoxOther2.text              = "C:\Data"
$TextBoxOther2.width             = 500
$TextBoxOther2.height            = 20
$TextBoxOther2.location          = New-Object System.Drawing.Point(120,330)
$TextBoxOther2.Font              = 'Microsoft Sans Serif,10'

$CheckBoxOther3                  = New-Object system.Windows.Forms.CheckBox
$CheckBoxOther3.text             = "Other #3"
$CheckBoxOther3.AutoSize         = $false
$CheckBoxOther3.width            = 95
$CheckBoxOther3.height           = 20
$CheckBoxOther3.location         = New-Object System.Drawing.Point(10,350)
$CheckBoxOther3.Font             = 'Microsoft Sans Serif,10'
$CheckBoxOther3.checked          = $false

$TextBoxOther3                   = New-Object system.Windows.Forms.TextBox
$TextBoxOther3.multiline         = $false
$TextBoxOther3.text              = "C:\Temp"
$TextBoxOther3.width             = 500
$TextBoxOther3.height            = 20
$TextBoxOther3.location          = New-Object System.Drawing.Point(120,350)
$TextBoxOther3.Font              = 'Microsoft Sans Serif,10'

$CheckBoxLoggedInUser            = New-Object system.Windows.Forms.CheckBox
$CheckBoxLoggedInUser.text       = "C:\USERS\$Username (Warning - This is a lot)"
$CheckBoxLoggedInUser.AutoSize   = $false
$CheckBoxLoggedInUser.width      = 400
$CheckBoxLoggedInUser.height     = 20
$CheckBoxLoggedInUser.location   = New-Object System.Drawing.Point(10,375)
$CheckBoxLoggedInUser.Font       = 'Microsoft Sans Serif,10'
$CheckBoxLoggedInUser.checked    = $false
$CheckBoxLoggedInUser.ForeColor  = "#d0021b"

$CheckBoxAllUsers                = New-Object system.Windows.Forms.CheckBox
$CheckBoxAllUsers.text           = "C:\ (Warning - This is More)"
$CheckBoxAllUsers.AutoSize       = $false
$CheckBoxAllUsers.width          = 400
$CheckBoxAllUsers.height         = 20
$CheckBoxAllUsers.location       = New-Object System.Drawing.Point(10,395)
$CheckBoxAllUsers.Font           = 'Microsoft Sans Serif,10'
$CheckBoxAllUsers.checked        = $false
$CheckBoxAllUsers.ForeColor      = "#d0021b"

$ButtonStart                     = New-Object system.Windows.Forms.Button
$ButtonStart.BackColor           = "#417505"
$ButtonStart.text                = "Start"
$ButtonStart.width               = 116
$ButtonStart.height              = 30
$ButtonStart.location            = New-Object System.Drawing.Point(10,425)
$ButtonStart.Font                = 'Microsoft Sans Serif,12,style=Bold'

$RadioButtonBackup               = New-Object system.Windows.Forms.RadioButton
$RadioButtonBackup.text          = "Backup"
$RadioButtonBackup.AutoSize      = $true
$RadioButtonBackup.width         = 104
$RadioButtonBackup.height        = 20
$RadioButtonBackup.location      = New-Object System.Drawing.Point(200,425)
$RadioButtonBackup.Font          = 'Microsoft Sans Serif,10'
$RadioButtonBackup.Checked       = $true

$RadioButtonRestore              = New-Object system.Windows.Forms.RadioButton
$RadioButtonRestore.text         = "Restore"
$RadioButtonRestore.AutoSize     = $true
$RadioButtonRestore.width        = 104
$RadioButtonRestore.height       = 20
$RadioButtonRestore.location     = New-Object System.Drawing.Point(300,425)
$RadioButtonRestore.Font         = 'Microsoft Sans Serif,10'
$RadioButtonRestore.Checked      = $false

$RadioButtonPhoto              = New-Object system.Windows.Forms.RadioButton
$RadioButtonPhoto.text         = "Photo Only Backup"
$RadioButtonPhoto.AutoSize     = $true
$RadioButtonPhoto.width        = 104
$RadioButtonPhoto.height       = 20
$RadioButtonPhoto.location     = New-Object System.Drawing.Point(400,425)
$RadioButtonPhoto.Font         = 'Microsoft Sans Serif,10'
$RadioButtonPhoto.Checked      = $false

$TextBoxOutput                   = New-Object system.Windows.Forms.TextBox
$TextBoxOutput.multiline         = $true
$TextBoxOutput.width             = 641
$TextBoxOutput.height            = 240
$TextBoxOutput.location          = New-Object System.Drawing.Point(10,465)
$TextBoxOutput.Font              = 'Microsoft Sans Serif,10'
$TextBoxOutput.ScrollBars        ='Vertical'

$LabelAsIs                       = New-Object system.Windows.Forms.Label
$LabelAsIs.text                  = "This software is not supported, if it doesn't work, don`'t use it."
$LabelAsIs.AutoSize              = $true
$LabelAsIs.width                 = 25
$LabelAsIs.height                = 10
$LabelAsIs.location              = New-Object System.Drawing.Point(26,680)
$LabelAsIs.Font                  = 'Microsoft Sans Serif,10'

$LabelRestoreFrom                = New-Object system.Windows.Forms.Label
$LabelRestoreFrom.text           = "Copy From"
$LabelRestoreFrom.AutoSize       = $true
$LabelRestoreFrom.width          = 25
$LabelRestoreFrom.height         = 10
$LabelRestoreFrom.location       = New-Object System.Drawing.Point(20,30)
$LabelRestoreFrom.Font           = 'Microsoft Sans Serif,10'
$LabelRestoreFrom.Visible        = $false
$LabelRestoreFrom.Enabled        = $false

$TextBoxFrom                     = New-Object system.Windows.Forms.TextBox
$TextBoxFrom.multiline           = $false
$TextBoxFrom.text                = "Z:\Backup\$env:COMPUTERNAME"
$TextBoxFrom.width               = 284
$TextBoxFrom.height              = 20
$TextBoxFrom.location            = New-Object System.Drawing.Point(120,30)
$TextBoxFrom.Font                = 'Microsoft Sans Serif,10'
$TextBoxFrom.Visible             = $false
$TextBoxFrom.Enabled             = $false

$LabelRestoreTo                  = New-Object system.Windows.Forms.Label
$LabelRestoreTo.text             = "Copy To"
$LabelRestoreTo.AutoSize         = $true
$LabelRestoreTo.width            = 25
$LabelRestoreTo.height           = 10
$LabelRestoreTo.location         = New-Object System.Drawing.Point(20,60)
$LabelRestoreTo.Font             = 'Microsoft Sans Serif,10'
$LabelRestoreTo.Visible          = $false
$LabelRestoreTo.Enabled          = $false

$TextBoxRestoreTo                = New-Object system.Windows.Forms.TextBox
$TextBoxRestoreTo.multiline      = $false
$TextBoxRestoreTo.text           = "C:\"
$TextBoxRestoreTo.width          = 283
$TextBoxRestoreTo.height         = 20
$TextBoxRestoreTo.location       = New-Object System.Drawing.Point(120,60)
$TextBoxRestoreTo.Font           = 'Microsoft Sans Serif,10'
$TextBoxRestoreTo.Visible        = $false
$TextBoxRestoreTo.Enabled        = $false

$FormBackupTool.controls.AddRange(@($CheckBoxPhotoC,$CheckBoxPhotoUser,$CheckBoxPhotoOther,$TextBoxOtherPhoto,$CheckBoxPhotoPictures,$LabelSourcePC,$TextBoxSourcePC,$LabelUserID,$TextBoxUserID,$LabelBackupTo,$TextBoxBackupTo,$CheckBoxContacts,$CheckBoxDesktop,$CheckBoxDocuments,$CheckBoxDownloads,$CheckBoxFireFoxBookmarks,$CheckBoxChrome,$CheckBoxIEBookmarks,$CheckBoxMusic,$CheckBoxPictures,$CheckBoxVideos,$CheckBoxOther1,$TextBoxOther1,$CheckBoxOther2,$TextBoxOther2,$CheckBoxOther3,$TextBoxOther3,$CheckBoxLoggedInUser,$CheckBoxAllUsers,$ButtonStart,$RadioButtonBackup,$RadioButtonRestore,$RadioButtonPhoto,$TextBoxOutput,$LabelAsIs,$LabelRestoreFrom,$TextBoxFrom,$LabelRestoreTo,$TextBoxRestoreTo,$CheckBoxAI,$CheckBoxEPS,$CheckBoxGIF,$CheckBoxINDD,$CheckBoxJPG,$CheckBoxJPEG,$CheckBoxPDF,$CheckBoxPNG,$CheckBoxPSD,$CheckBoxRAW,$CheckBoxTIFF))

$ButtonStart.Add_Click({StartBackup})
$CheckBoxAllUsers.Add_CheckStateChanged({AllUserBackup})
$CheckBoxLoggedInUser.Add_CheckStateChanged({OneUserBackup})
$CheckBoxPhotoC.Add_CheckStateChanged({PhotoAllC})
$RadioButtonBackup.Add_Click({BackupMenu})
$RadioButtonRestore.Add_Click({RestoreMenu})
$RadioButtonPhoto.Add_Click({PhotMenu})


#Write your logic code here

[void]$FormBackupTool.ShowDialog()
