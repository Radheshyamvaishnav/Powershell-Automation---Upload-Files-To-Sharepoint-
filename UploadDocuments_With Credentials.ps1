
# This Powershell script is to uplaod the files to a sharepoint document library REMOTELY with user Credentails
function UploadDocuments($destination, $File,$userID, $securePasssword)
{
try {
# Since we’re doing this remotely, we need to authenticate
$credentials = New-Object System.Management.Automation.PSCredential ($userID, $securePasssword)

# Upload the file
$webclient = New-Object System.Net.WebClient
$webclient.Credentials = $credentials
$webclient.UploadFile($destination + "/" + $File.Name, "PUT", $File.FullName)
}
catch {
Write-Host "Error:: $($_.Exception.Message)" -foregroundcolor red -BackgroundColor Yellow
}

}
# Set the variables
$destination = "<<Document Library URL >>"
$fileDirectory = "C:\Krishna\PowerShell Scripts\PS Testing\T\*.*"
$userName = Read-Host "Enter User-ID (domain\userID):: "
$securePasssword = Read-Host "Please enter the password for user $($userName) :: " -AsSecureString
#Reading through the folder
foreach($fileName in Get-ChildItem $fileDirectory)
{
UploadDocuments -destination $destination -File $fileName -userID $userName -securePasssword $securePasssword
Write-Host "Uploaded File=" $fileName.Name
}
Write-Host "Script executed Successfully"



#Note
#1. $File.Name is the name of the file to be created as in document library
#2. $File.FullName is the path of the file from where it needs to be uploaded from
#3. $securePasssword is used to read password
#4. $userID is used to read password
#
#To Run this script
#Save the above script as “UploadDocuments_With Credentials.ps1”
#Open PowerShell Command let as administrator
#Navigate to the folder where you save the PS1 script
#Execute the script by typing “.\UploadDocuments_With Credentials.ps1”