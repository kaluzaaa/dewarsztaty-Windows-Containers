Write-Output "[$(Get-Date -Format "yyyy-MM-dd HH:mm:ss" )] ========== Start =========="
$url = "https://lkdevtestlab01.blob.core.windows.net/artifact/vs2015.3.com_enu.iso"
$output = "D:\vs2015.3.com_enu.iso"
Write-Output "[$(Get-Date -Format "yyyy-MM-dd HH:mm:ss" )] Start file download"
$wc = New-Object System.Net.WebClient
$wc.DownloadFile($url, $output)
Write-Output "[$(Get-Date -Format "yyyy-MM-dd HH:mm:ss" )] End file download"
Write-Output "[$(Get-Date -Format "yyyy-MM-dd HH:mm:ss" )] Mount iso"
$mountResult =  Mount-DiskImage D:\vs2015.3.com_enu.iso -PassThru
$DriveLetter = ($mountResult | Get-Volume).DriveLetter
Write-Output "[$(Get-Date -Format "yyyy-MM-dd HH:mm:ss" )] Start install"
$cmd = Start-Process "${DriveLetter}:\vs_community.exe" -ArgumentList /q,/Norestart,"/AdminFile ${DriveLetter}:\AdminDeployment.xml"