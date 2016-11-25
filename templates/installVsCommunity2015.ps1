$url = "https://lkdwhsrc.blob.core.windows.net/artifact-repository/vs2015.3.com_enu.iso"
$output = "D:\vs2015.3.com_enu.iso"
$wc = New-Object System.Net.WebClient
$wc.DownloadFile($url, $output)
$mountResult =  Mount-DiskImage D:\vs2015.3.com_enu.iso -PassThru
$DriveLetter = ($mountResult | Get-Volume).DriveLetter
Start-Process "${DriveLetter}:\vs_community.exe" -Wait -ArgumentList /Passive,/Norestart