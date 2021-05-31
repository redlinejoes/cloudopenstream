Start-Transcript -Path "$PSScriptRoot\Log.txt"
function Check-IsElevated {
    $id = [System.Security.Principal.WindowsIdentity]::GetCurrent()
    $p = New-Object System.Security.Principal.WindowsPrincipal($id)
    if ($p.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator))
   { Write-Output $true }      
    else
   { Write-Output $false }   
 }

if (Check-IsElevated) {
Write-Host "Thank you for being an Administrator, the script will proceed" }
 else {
   Write-Host "This script wasn't executed as an Administrator, make sure to use the built-in Administrator user" 
   Stop-Transcript
   Pause
}

function Write-HostCenter { param($Message) Write-Host ("{0}{1}" -f (' ' * (([Math]::Max(0, $Host.UI.RawUI.BufferSize.Width / 3) - [Math]::Floor($Message.Length / 3)))), $Message) }

Clear-Host
Write-HostCenter 'CloudOpenstream'
Write-HostCenter 'A PowerShell script that automatically prepares a cloud Windows Server for use on Moonlight using free, open-source software.'
Write-HostCenter 'A project by Rion, who is not a developer'
Write-Host ""


    Write-Host "Your machine will restart at least once during this setup." -ForegroundColor Red
    Write-Host ""
    Write-Host "Step 1 - Installing requirements" -ForegroundColor Yellow
    & $PSScriptRoot\Steps\step1.ps1 -Main
	
    Write-Host ""
    Write-Host "Step 2 - Applying fixes" -ForegroundColor Yellow
    & $PSScriptRoot\Steps\step2.ps1

    Write-Host ""
    Write-Host "Step 3 - Installing Game Clients" -ForegroundColor Yellow
    & $PSScriptRoot\Steps\step3.ps1

    Write-Host "Finished, if following a guide, continue along." -ForegroundColor Green

    $restart = (Read-Host "Would you like to restart now? (y/n)").ToLower();
    if($restart -eq "y") {
    Restart-Computer -Force 
}
