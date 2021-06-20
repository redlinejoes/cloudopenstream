$WorkDir = "$PSScriptRoot\..\Bin"

Function GetFile([string]$Url, [string]$Path, [string]$Name) {
    try {
        if(![System.IO.File]::Exists($Path)) {
	        Write-Host "Downloading `"$Name`"..."
	        Start-BitsTransfer $Url $Path
        }
    } catch {
        throw "`"$Name`" download failed."
    }
}

Import-Module BitsTransfer

Write-Host "Choose yes or no to installing these essential applications..." -ForegroundColor Red
Write-Host ""

$InstallSteam = (Read-Host "Would you like to download and install Steam? (y/n)").ToLower() -eq "y"

if($InstallSteam) {
    Write-Host ""
    GetFile "https://cdn.akamai.steamstatic.com/client/installer/SteamSetup.exe" "$WorkDir\SteamSetup.exe" "Steam"
    Write-Host "Installing Steam..."
    Start-Process -FilePath "$WorkDir\SteamSetup.exe" -ArgumentList "-s" -NoNewWindow -Wait -Passthru
}
else {
    Write-Host ""
    Write-Host "Skipping Steam..."
}


$InstallPlaynite = (Read-Host "Would you like to download and install Playnite? (y/n)").ToLower() -eq "y"

if($InstallPlaynite) {
    Write-Host ""
    GetFile "https://github.com/JosefNemec/Playnite/releases/download/8.11/Playnite811.exe" "$WorkDir\Playnite.exe" "Playnite"
    Write-Host "Installing Playnite..."
    Start-Process -FilePath "$WorkDir\Playnite.exe" -ArgumentList "-s" -NoNewWindow -Wait -Passthru
}
else {
    Write-Host ""
    Write-Host "Skipping Playnite..."
}

$Install7Zip = (Read-Host "Would you like to download and install 7Zip? (y/n)").ToLower() -eq "y"

if($Install7Zip) {
    Write-Host ""
    GetFile "https://www.7-zip.org/a/7z1900-x64.exe" "$WorkDir\7zip.exe" "7Zip"
    Write-Host "Installing 7Zip..."
    Start-Process -FilePath "$WorkDir\7Zip.exe" -ArgumentList "-s" -NoNewWindow -Wait -Passthru
}
else {
    Write-Host ""
    Write-Host "Skipping 7Zip..."
}

$Afterburner = (Read-Host "Do you want to install MSI Afterburner? (y/n)").ToLower() -eq "y"

if($Afterburner) { 
Write-Host ""
GetFile "https://cloudopenstream.s3.us-west-2.amazonaws.com/MSIAfterburnerSetup.zip" "$WorkDir\afterburner.zip" "MSI Afterburner" 
Write-Host "Installing Afterburner..."
Expand-Archive -Path "$WorkDir\afterburner.zip" -DestinationPath "$WorkDir\afterburner"
Start-Process -FilePath "$WorkDir\afterburner\MSIAfterburnerSetup464Beta3.exe" -ArgumentList "-i","-h" -NoNewWindow -Wait 
}
