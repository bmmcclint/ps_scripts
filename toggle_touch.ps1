# Simple PowerShell script to either enable or disable the touchscreen 
# Requires installation of devcon, either the standalone executable or installed with VS
param([string]$option)

$touchID = "HID\VID_03EB&PID_8AB2&MI_01&Col01"
$devStat = devcon status $touchID | Select-String "running"

# If tablet mode is disabled, disable touch screen
if ($option -eq 'off') {
  if ($devStat) {
    devcon disable $touchID
  }
}

# if tablet mode is enabled, enable touch screen 
elseif ($option -eq 'on') {
  if (!$devStat) {
    devcon enable $touchID
  }
}

# If no argument entered, display usage information
else {
  Write-Host "usage: on = enable touch, off = disable touch"
}
