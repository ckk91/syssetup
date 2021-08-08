# Enabling WSL2 on windows 
# enable wsl2
function enable-wsl {
    $ErrorActionPreference = "Stop"
    
    Write-Host Enabling WSL2 and restarting the machine.
    
    dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
    dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
    
    # todo make reboot safe as admin

    Restart-Computer
}

function initialize-ubuntu {
    $ProgressPreference = 'SilentlyContinue'
    $ErrorActionPreference = "Stop"
    
    Write-Host Fetching and applying WSL2 update
    
    Invoke-WebRequest -Uri https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi -OutFile .\wsl_update.msi
    # omfg https://powershellexplained.com/2016-10-21-powershell-installing-msi-files/
    # Start-Process msiexec.exe -Wait -ArgumentList ' /I .\wsl_update.msi /quiet'
    Start-Process -wait .\wsl_update.msi
    Write-Host "Post kernel patch"
    Remove-Item '.\wsl_update.msi'

    Write-Host Setting WSL Default Version 2
    wsl --set-default-version 2

    # Write-Host Installing Ubuntu 20.04 LTS
    # Invoke-WebRequest -Uri https://aka.ms/wslubuntu2004 -OutFile Ubuntu.appx -UseBasicParsing
    # Add-AppxPackage .\Ubuntu.appx
    # Remove-Item '.\Ubuntu.appx'

    # # Initial housekeeping
    # #https://github.com/kaisalmen/wsltooling/blob/world/installUbuntuLTS.ps1
    # Write-Host Initial Ubuntu update
    # wsl -u root -- apt update `&`& apt upgrade -y

    $ProgressPreference = 'Continue'  # because ms engineers cant do concurrency apparently
    # https://stackoverflow.com/a/15166968

}

if ($args[0] -eq "setup") {
    initialize-ubuntu
} else {
    enable-wsl
}
