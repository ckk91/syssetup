# chocolatey and boxstarter
### HACK Workaround choco / boxstarter path too long error
## https://github.com/chocolatey/boxstarter/issues/241
$ChocoCachePath = "$env:USERPROFILE\AppData\Local\Temp\chocolatey"
New-Item -Path $ChocoCachePath -ItemType Directory -Force

# Set-WindowsExplorerOptions -EnableShowHiddenFilesFoldersDrives -EnableShowProtectedOSFiles -EnableShowFileExtensions

# Disable-UAC

cinst -y 7zip
cinst -y audacity
# cinst -y blender
cinst -y calibre
# cinst -y discord
# cinst -y dropbox
cinst -y everything
cinst -y f.lux
cinst -y fastcopy
cinst -y filezilla
cinst -y firefox
cinst -y freefilesync
# cinst -y git
# cinst -y google-backup-and-sync
cinst -y googlechrome
cinst -y keepass
# cinst -y malwarebytes
cinst -y skype
cinst -y teamviewer
cinst -y thunderbird
# cinst -y veracrypt
# cinst -y vlc
cinst -y vscode
cinst -y windirstat
cinst -y winmerge
cinst -y winrar
# cinst -y you-need-a-budget
cinst -y zoom
cinst -y docker-desktop
cinst -y heidisql
cinst -y putty

# todo terminal, spotify

cinst -y choco-cleaner
Set-ExecutionPolicy -ExecutionPolicy Unrestricted
\ProgramData\chocolatey\bin\Choco-Cleaner.ps1

# === System Update ===
# Enable-MicrosoftUpdate
# Install-WindowsUpdate -acceptEula

#--- Restore Temporary Settings ---
# Enable-UAC