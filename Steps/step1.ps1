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

GetFile "https://aka.ms/vs/16/release/vc_redist.x64.exe" "$WorkDir\redist.exe" "Visual C++ Redist"
Write-Host "Installing Visual C++ Redist..."
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

$InstallVideo = (Read-Host "This script will also install the Parsec GPU Updater tool, unless you already have drivers, please type y (y/n)").ToLower() -eq "y"

        if($InstallVideo) {
            $Shell = New-Object -comObject WScript.Shell
            $Shortcut = $Shell.CreateShortcut("$Home\Desktop\Continue.lnk")
            $Shortcut.TargetPath = "powershell.exe"
            $Shortcut.Arguments = "-Command `"Set-ExecutionPolicy Unrestricted; & '$PSScriptRoot\..\Setup.ps1'`" -RebootSkip"
            $Shortcut.Save()
            GetFile "https://raw.githubusercontent.com/parsec-cloud/Cloud-GPU-Updater/master/GPUUpdaterTool.ps1" "$PSScriptRoot\GPUUpdaterTool.ps1" "Cloud GPU Updater" 
            & $PSScriptRoot\GPUUpdaterTool.ps1
            Write-Host "In case of a restart, please use the continue shortcut on your desktop" 
}

$InstallAudio = (Read-Host "You need audio drivers, do you want VBCable? (y/n)").ToLower() -eq "y"

if($InstallAudio) { 
GetFile "https://download.vb-audio.com/Download_CABLE/VBCABLE_Driver_Pack43.zip" "$WorkDir\vbcable.zip" "VBCABLE" 
Write-Host "Installing VBCABLE..."
Expand-Archive -Path "$WorkDir\vbcable.zip" -DestinationPath "$WorkDir\vbcable"
Start-Process -FilePath "$WorkDir\vbcable\VBCABLE_Setup_x64.exe" -ArgumentList "-i","-h" -NoNewWindow -Wait }


GetFile "https://cloudopenstream.s3-us-west-2.amazonaws.com/installer_05_28.exe" "$WorkDir\openstream.exe" "Open-stream" 
Write-Host "Installing Open-stream..."
Start-Process -FilePath "$WorkDir\openstream.exe"