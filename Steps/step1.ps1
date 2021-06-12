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

$Video = (Read-Host "This script will also install the Parsec GPU Updater tool, unless you already have drivers, please type y (y/n)").ToLower() -eq "y"

if($Video) {
  $Shell = New-Object -comObject WScript.Shell
  $Shortcut = $Shell.CreateShortcut("$Home\Desktop\Continue.lnk")
  $Shortcut.TargetPath = "powershell.exe"
  $Shortcut.Arguments = "-Command `"Set-ExecutionPolicy Unrestricted; & '$PSScriptRoot\..\starthere.ps1'`" -RebootSkip"
  $Shortcut.Save()
  GetFile "https://raw.githubusercontent.com/parsec-cloud/Cloud-GPU-Updater/master/GPUUpdaterTool.ps1" "$PSScriptRoot\GPUUpdaterTool.ps1" "Cloud GPU Updater" 
  & $PSScriptRoot\GPUUpdaterTool.ps1 
}

$Audio = (Read-Host "You need audio drivers, do you want VBCable? (y/n)").ToLower() -eq "y"

if($Audio) { 
GetFile "https://download.vb-audio.com/Download_CABLE/VBCABLE_Driver_Pack43.zip" "$WorkDir\vbcable.zip" "VBCABLE" 
Write-Host "Installing VBCABLE..."
Expand-Archive -Path "$WorkDir\vbcable.zip" -DestinationPath "$WorkDir\vbcable"
Start-Process -FilePath "$WorkDir\vbcable\VBCABLE_Setup_x64.exe" -ArgumentList "-i","-h" -NoNewWindow -Wait 
}

$Razer = (Read-Host "Do you want to install Razer Surround? (y/n)").ToLower() -eq "y"

if($Razer) {
GetFile "https://cloudopenstream.s3.us-west-2.amazonaws.com/RazerSurroundInstaller2.0.29.20.zip" "$WorkDir\razer.zip" "Razer Surround"
Write-Host Installing "Razer Surround"
Expand-Archive -Path "$WorkDir\razer.zip" -DestinationPath "$WorkDir\razer"
Start-Process -FilePath "$WorkDir\razer\RazerSurroundInstaller2.0.29.20\$TEMP\RazerSurroundInstaller\RzUpdateManager.exe" -ArgumentList "-i","-h" -NoNewWindow -Wait 
}

GetFile "https://cloudopenstream.s3-us-west-2.amazonaws.com/installer_05_28.exe" "$WorkDir\openstream.exe" "Open-stream" 
Write-Host "Installing Open-stream..."
Start-Process -FilePath "$WorkDir\openstream.exe"

GetFile "https://download.microsoft.com/download/9/3/F/93FCF1E7-E6A4-478B-96E7-D4B285925B00/vc_redist.x86.exe" "$WorkDir\redist.exe" "Visual C++ Redist (2010)"
Write-Host "Installing Visual Studio Redist"
$ExitCode = (Start-Process -FilePath "$WorkDir\redist.exe" -ArgumentList "/install","/quiet","/norestart" -NoNewWindow -Wait -Passthru).ExitCode
if($ExitCode -eq 0) { Write-Host "Installed." -ForegroundColor Green }
elseif($ExitCode -eq 1638) { Write-Host "Newer version already installed." -ForegroundColor Green }
else { 
    throw "Installation failed (Error: $ExitCode)."
}

GetFile "http://download.mozilla.org/?product=firefox-stub&os=win&lang=en-US" "$WorkDir\firefox.exe" "Firefox" 
Write-Host "Installing Firefox, make it your default browser!"
$ExitCode = (Start-Process -FilePath "$WorkDir\firefox.exe" -ArgumentList "-s" -NoNewWindow -Wait -Passthru).ExitCode
if($ExitCode -eq 0) { Write-Host "Installed." -ForegroundColor Green }
else { 
    throw "Installation failed (Error: $ExitCode)."
}
