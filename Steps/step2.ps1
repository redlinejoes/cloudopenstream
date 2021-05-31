$osType = Get-CimInstance -ClassName Win32_OperatingSystem

if($osType.ProductType -eq 3) {
    Write-Host "Installing Wireless Networking..."
    Install-WindowsFeature -Name Wireless-Networking | Out-Null
}

Write-Host ""
if($osType.ProductType -eq 3) {
    Write-Host "Installing Quality Windows Audio/Video Expirence"
    Install-WindowsFeature -Name QWAVE | Out-Null
}   

Write-Host ""
if($osType.ProductType -eq 3) {
    Write-Host "Adding a Openstream rules to the Windows Firewall..."
    New-NetFirewallRule -DisplayName "Moonlight TCP" -Direction inbound -LocalPort 47984,47989,48010 -Protocol TCP -Action Allow | Out-Null
    New-NetFirewallRule -DisplayName "Moonlight UDP" -Direction inbound -LocalPort 47998,47999,48000,48010 -Protocol UDP -Action Allow | Out-Null
}

    Write-Host ""
    if($osType.ProductType -eq 3) {
        Write-Host "Applying Audio service fix for Windows Server..."
        New-ItemProperty "hklm:\SYSTEM\CurrentControlSet\Control" -Name "ServicesPipeTimeout" -Value 600000 -PropertyType "DWord" | Out-Null
        Set-Service -Name Audiosrv -StartupType Automatic | Out-Null }

Write-Host ""
if($osType.ProductType -eq 3) {
    Write-Host "Configuring Autologin..."
    $RegPath = "hklm:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"
    Set-ItemProperty $RegPath "AutoAdminLogon" -Value "1" -type String | Out-Null
    $Password = Read-Host -Prompt 'Please input your password'
    Set-ItemProperty $RegPath "DefaultPassword" -Value "$Password" -type String | Out-Null
    Set-ItemProperty $RegPath "DefaultUsername" -Value "Administrator" -type String | Out-Null
}

Write-Host "Turning on mouse acceleration..."
Set-Itemproperty -Path 'HKCU:\Control Panel\Mouse' -Name MouseSpeed -Value 1 | Out-Null