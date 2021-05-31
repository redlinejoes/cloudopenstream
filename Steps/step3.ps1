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

Write-Host "This step can install Steam and Playnite" -ForegroundColor Red
Write-Host ""

$InstallSteam = (Read-Host "Would you like to install Steam? (y/n)").ToLower() -eq "y"

if($InstallSteam) {
    GetFile "https://cdn.akamai.steamstatic.com/client/installer/SteamSetup.exe" "$WorkDir\SteamSetup.exe" "Steam"
    Write-Host "Installing Steam..."
    Start-Process -FilePath "$WorkDir\SteamSetup.exe" -ArgumentList "-s" -NoNewWindow -Wait -Passthru
}
else {
    Write-Host "Skipping Steam..."
}


$InstallPlaynite = (Read-Host "Would you like to install Playnite?(y/n)").ToLower() -eq "y"

if($InstallPlaynite) {
    GetFile "https://github.com/JosefNemec/Playnite/releases/download/8.11/Playnite811.exe" "$WorkDir\Playnite.exe" "Playnite"
    Write-Host "Installing Playnite..."
    Start-Process -FilePath "$WorkDir\Playnite.exe" -ArgumentList "-s" -NoNewWindow -Wait -Passthru
}
else {
    Write-Host "Skipping Playnite..."
}
