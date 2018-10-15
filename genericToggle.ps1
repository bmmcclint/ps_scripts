# PS Script that elevates its privileges to enable or disable the touch screen.
# Privilege escalation is necessary since device settings are being changed.
# Should work for 90% percent of laptops/hybrids. Some systems utilize sensors 
#   to control the activation of the touch screen (weird, huh?).

# Written by Brandon McClinton on April 14, 2018

Write-Host "This script will either enable or disable your touch screen";
Write-Host "It has been designed to elevate it's own privileges to run as admin";
Sleep 4;
  
# Gets the id and security principal for the user
$userID = [System.Security.Principal.WindowsIdentity]::GetCurrent();
$userPrin = New-Object System.Security.Principal.WindowsPrincipal($userID);

# Gets the security principal for admin
$adminRol = [System.Security.Principal.WindowsBuiltInRole]::Administrator;

# Variables pertinent to touch screen device
$getDevice = Get-PnpDevice | Where-Object {$_.FriendlyName -like '*HID-compliant touch screen*'};
$status = $getDevice | Select-Object -ExpandProperty "Status";
$instID = $getDevice | Select-Object -ExpandProperty "InstanceId";

# checks if shell has root
if ($userPrin.IsInRole($adminRol)){
  # running as root, change title to reflect
  $host.UI.RawUI.WindowTitle = $MyInvocation.MyCommand.Definition + " (ELEVATED) ";
  Clear-Host;
}

# Not running as root, make it so
else {
  # Creates mew process object for starting PowerShell
  $newProcess = New-Object System.Diagnostics.ProcessStartInfo "PowerShell";
  # Specifies script path and name as params 
  $newProcess.Arguments = "& '" + $Script:MyInvocation.MyCommand.Path + "'"
  # Adds flag to run as admin
  $newProcess.Verb = "runas";
  # Starts new PowerShell process as admin
  [System.Diagnostics.Process]::Start($newProcess);
  # Exits current shell
  Exit;
}

# If the status returns OK, disable the touch screen
if ($status -eq 'OK') {
  $getDevice | Disable-PnpDevice -Confirm:$false | echo $instID;
  Write-Host "Touch screen is now disabled!";
  Write-Host "Touch screen can be re-enabled by running this again.";
  Sleep 2.5;
  Stop-Process -Id $PID;
}

# Once disabled, you can re-enable the touch screen by running again
else {
  $getDevice | Enable-PnpDevice -Confirm:$false | echo $instID;
  Write-Host "Touch screen is now enabled!";
  Write-Host "Enjoy touching your screen.";
  Sleep 2.5;
  Stop-Process -Id $PID;
}