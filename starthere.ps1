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

Write-HostCenter 'Cloudopenstream'
Write-HostCenter 'Starting up...'
Write-Host ""

if(!$RebootSkip) {
    Write-Host "Your machine will restart at least once during this setup." -ForegroundColor Red
    Write-Host ""
    Write-Host "Step 1 - Installing requirements" -ForegroundColor Yellow
} else {
if(Get-ScheduledTask | Where-Object {$_.TaskName -like "Continue" }) {
  Unregister-ScheduledTask -TaskName "Continue" -Confirm:$false
}
Write-Host "The script will now continue from where it left off."
}
	
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
