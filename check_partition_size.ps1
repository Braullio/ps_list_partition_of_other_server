$Computername = Read-Host "Insert IP of server: "
Function Get-Diskinfo{
param($fileName,$devId,$volName,$frSpace,$totSpace)
$totSpace=[math]::Round(($totSpace/1073741824),2)
$frSpace=[Math]::Round(($frSpace/1073741824),2)
$usedSpace = $totSpace - $frspace
$usedSpace=[Math]::Round($usedSpace,2)
$freePercent = ($frspace/$totSpace)*100
$freePercent = [Math]::Round($freePercent,0)
$warning = 22
$critical = 22
 
if ($freePercent -gt $warning){
Write-Host "$devid - $volName - $totSpace - $usedSpace - $frSpace - $freePercent %" -ForegroundColor Green
}
elseif ($freePercent -le $critical -and $devid -eq "C:"){
Write-Host "$devid - $volName - $totSpace - $usedSpace - $frSpace - $freePercent %" -ForegroundColor Red
}
else{
Write-Host "$devid - $volName - $totSpace - $usedSpace - $frSpace - $freePercent %" -ForegroundColor Yellow
}
}
$dp = (Get-WmiObject win32_logicaldisk -ComputerName $Computername | Where-Object {$_.drivetype -eq 3})
foreach ($item in $dp){
Write-Host "$($item.DeviceID) $($item.VolumeName) $($item.FreeSpace) $($item.Size)"
Get-Diskinfo $_ $item.DeviceID $item.VolumeName $item.FreeSpace $item.Size
}
