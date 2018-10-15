$ssb = "$env:USERPROFILE\AppData\Local\slack\app-3.3.1\resources\app.asar.unpacked\src\static\ssb-interop.js"
$theme = "$env:USERPROFILE\Documents\Scripts\theme.txt"
$slackDir = "$env:USERPROFILE\AppData\local\slack\Slack.exe"
$running = Get-Process slack  
$hasTheme = Get-cotent $$ssb | Select-String "cssPath"

if ($running) {
  $running.CloseMainWindow() 
  if (!$running.HasExited) {
    $running | Stop-Process -Force
  }
}

if ($hasTheme) {
  Start-Process $slackDir
  Write-Host "Slack is already themed"
  exit
}

if (!$hasTheme) {
  Write-Host "Applying theme to Slack"
  Add-Content $ssb -Value (Get-Content "$theme")
  Start-Process $slackDir
  exit
}
