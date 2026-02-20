# This guide assumes you already have the OS installed, and access to an ADDS

# Ensure LCM User is created inside your AD

Install-Module AsHciADArtifactsPreCreationTool -Repository PSGallery -Force
$password = ConvertTo-SecureString '<Password>' -AsPlainText -Force
$user = "<LCMUser>"
$credential = New-Object System.Management.Automation.PSCredential ($user, $password)
New-HciAdObjectsPreCreation -AzureStackLCMUserCredential $credential -AsHciOUName "OU=<OU>,DC=<DC>,DC=<DC>"

#Enable RDP inside the OS, and install network drivers

Get-Volume
cd D:\
./SetupBD.exe # / The file your driver installer is

# Ensure the driver shows the correct manufacturer, and not Microsoft

Get-NetAdapter | fl *driver*

# Set you management addresses to static and setup DNS

$NewPassword = ConvertTo-SecureString "<SecurePassword>" -AsPlainText -Force
Set-LocalUser -Name "Administrator" -Password $NewPassword

Rename-Computer -NewName "<NodeName>"

# Restart the host

# Cleanup the disks on the host

$ServerList = "<NodeName>"
 
Invoke-Command ($ServerList) {
Update-StorageProviderCache
Get-StoragePool | ? IsPrimordial -eq $false | Set-StoragePool -IsReadOnly:$false -ErrorAction SilentlyContinue
      Get-StoragePool | ? IsPrimordial -eq $false | Get-VirtualDisk | Remove-VirtualDisk -Confirm:$false -ErrorAction SilentlyContinue
      Get-StoragePool | ? IsPrimordial -eq $false | Remove-StoragePool -Confirm:$false -ErrorAction SilentlyContinue
      Get-PhysicalDisk | Reset-PhysicalDisk -ErrorAction SilentlyContinue
      Get-Disk | ? Number -ne $null | ? IsBoot -ne $true | ? IsSystem -ne $true | ? PartitionStyle -ne RAW | ? BusType -ne USB | % {
$_ | Set-Disk -isoffline:$false
           $_ | Set-Disk -isreadonly:$false
$_ | Clear-Disk -RemoveData -RemoveOEM -Confirm:$false
           $_ | Set-Disk -isreadonly:$true
           $_ | Set-Disk -isoffline:$true
      }
      Get-Disk | Where-Object-Object Number -Ne $Null | Where-Object IsBoot -Ne $True | Where-Object IsSystem -Ne $True | Where-Object PartitionStyle -Eq RAW | Group -NoElement -Property FriendlyName
} | Sort -Property PsComputerName, Count

# Register the host with Azure

$Tenant = "<Tenant>"
$Subscription = "<Subscription>"
$RG = "<ResourceGroup>"
$Region = "<Region>"

Invoke-AzStackHciArcInitialization -TenantId $Tenant -SubscriptionID $Subscription -ResourceGroup $RG -Region $Region -Cloud "AzureCloud"
