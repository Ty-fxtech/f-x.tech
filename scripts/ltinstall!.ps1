# Must be ran as Admin to work
param(
    [String]$InstallerToken
)
[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.VisualBasic") > $NULL
if (!($InstallerToken))  {$InstallerToken = [Microsoft.VisualBasic.Interaction]::InputBox("Please paste your provided Installer Token below:","FX Tech Agent Installer")}
if (!($InstallerToken)) {echo "Installer Token Not Entered, exiting early"; pause; exit}
iex (new-object Net.WebClient).DownloadString('https://raw.githubusercontent.com/Ty-fxtech/fx-ltposh/master/LabTech.psm1')
$hexString = [System.Convert]::FromBase64String($InstallerToken + "==") 
$hexString = ($hexString|ForEach-Object ToString X2) -join ''
if (get-service ltservice -erroraction silentlycontinue) {Uninstall-LTService -Server "https://forrestertech.hostedrmm.com" -Force }
Install-LTService -Server "https://forrestertech.hostedrmm.com" -InstallerToken $hexString
pause
