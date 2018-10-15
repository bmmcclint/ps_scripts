# PowerShell Script that periodically checks if the Windows Update service is
# running and will automatically stop it.

$wuSvc = "wuauserv"
$usoSvc = "usosvc"
$wuPrior = Get-Service $wuSvc
$usoPrior = Get-Service $usovc 
$wuStatus = $wuPrior.status
$usoStatus = $usoPrior.status
$compName = $env:computerName

# If Windows Update service is stopped, start it
If (($wuStatus -eq 'Stopped') -and ($usoStatus -eq 'Stopped')) {
  Start-Service $wuSvc -and Start-Service $usoSvc 
  $wuSvc + ' and ' + $usoSvc + ' are ' + $wuStatus + ' and ' + $usoStatus
  #Start-Service $usoSvc
  #$usoSvc + ' is ' + $usoStatus 
}

# If Windows Update servce is running, stop it
ElseIf (($wuStatus -eq 'Running') -and ($usoStatus -eq 'Running')) {
  Stop-Service $wuSvc -and Stop-Service $usoSvc
  $wuSvc + ' and ' + $usoSvc + ' are ' + $wuStatus + ' and ' + $usoStatus
  #Stop-Service $usoSvc
  #$usoSvc + ' is ' + $usoStatus 
}
