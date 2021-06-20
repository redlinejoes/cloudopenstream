Param([Parameter(Mandatory=$false)] [Switch]$RebootSkip)

Start-Transcript -Path "$PSScriptRoot\Log.txt"
function Elevated {
    $id = [System.Security.Principal.WindowsIdentity]::GetCurrent()
    $p = New-Object System.Security.Principal.WindowsPrincipal($id)
    if ($p.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator))
   { Write-Output $true }      
    else
   { Write-Output $false }   
 }

 if (-not(Elevated))
 { throw "Please run this script as an administrator" 
   Stop-Transcript
   Pause
}

function Write-HostCenter { param($Message) Write-Host ("{0}{1}" -f (' ' * (([Math]::Max(0, $Host.UI.RawUI.BufferSize.Width / 2) - [Math]::Floor($Message.Length / 2)))), $Message) }

Clear-Host

Write-HostCenter 'The Cloud Open-stream Script'
Write-HostCenter 'Starting up...'
Write-Host ""

if(!$RebootSkip) {
    Write-Host "Your machine will restart at least once during this setup." -ForegroundColor Red
    Write-Host ""
    Write-Host "Step 1 - Installing requirements" -ForegroundColor Yellow
    & $PSScriptRoot\Steps\step1.ps1 -Main
} else {
if(Get-ScheduledTask | Where-Object {$_.TaskName -like "Continue" }) {
  Unregister-ScheduledTask -TaskName "Continue" -Confirm:$false
}
Write-Host "Welcome back, let's continue with step two."
}
	
    Write-Host ""
    Write-Host "Step 2 - Applying fixes" -ForegroundColor Yellow
    & $PSScriptRoot\Steps\step2.ps1

    Write-Host ""
    Write-Host "Step 3 - Installing applications" -ForegroundColor Yellow
    & $PSScriptRoot\Steps\step3.ps1
    
    Write-Host "Cleaning up temp folder..."
    $path = [Environment]::GetFolderPath("Desktop")	
    Remove-Item -Path $path\ChromeTemp -force -Recurse
    	
	Write-Host ""
	$ip = (Invoke-WebRequest ifconfig.me/ip).Content
	Write-Host "Using the official AWS guide? Skip the steps below" -ForegroundColor Yellow  
	Write-Host "Finished! Now you need to head to your desktop and start Open-stream" -ForegroundColor Green
	Write-Host "Grab your favorite device and install Moonlight on it" -ForegroundColor Green  
	Write-Host "Your IP address is $ip" -ForegroundColor Red
	Write-Host "Type in the IP address inside of Moonlight" -ForegroundColor Green
	Write-Host "Come back to the RDP session and enter the code inside of Open-stream" -ForegroundColor Green
	
    $restart = (Read-Host "Thanks for using the script, would you like to restart now? (y/n)").ToLower();
    if($restart -eq "y") {
    Restart-Computer -Force 
}
