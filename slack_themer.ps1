$slack = Get-Process slack -ErrorAction SilentlyContinue
$slackDir = C:\Users\Brother\AppData\Local\slack\Slack.exe
$themeDir = C:\Users\Brother\AppData\Local\slack\app-3.3.3\resources\app.asar.unpacked\src\static\ssb-interop.js
$hasThem = Select-String -path "themeDir" -pattern "customCustomCSS

if ($slack) {
  $slack.CloseMainWindow()
  Sleep 5
  if (!$slack.HasExited) {
    $slack | Stop-Process -Force
  }
}

Select-String -path "themeDir" -pattern "customCustomCSS" -allmatches -simplematch

if (!$slack) {
  Start-Process $slackDir
}
Remove-Variable slack
Remove-Variable slackDir
