Write-Output "[$(Get-Date)] ========== Start =========="
$url = "https://lkdwhsrc.blob.core.windows.net/artifact-repository/vs2015.3.com_enu.iso"
$output = "D:\vs2015.3.com_enu.iso"
Write-Output "[$(Get-Date)] File download"
Invoke-WebRequest -Uri $url -OutFile $output
Write-Output "[$(Get-Date)] File downloaded"
Write-Output "[$(Get-Date)] Mount iso"
$mountResult =  Mount-DiskImage D:\vs2015.3.com_enu.iso -PassThru
$DriveLetter = ($mountResult | Get-Volume).DriveLetter
Write-Output "[$(Get-Date)] Start install"
$cmd = Start-Process "${DriveLetter}:\vs_community.exe" -Wait -ArgumentList /q,/Norestart
Write-Output "[$(Get-Date)] Install process exit code $($cmd.ExitCode)"