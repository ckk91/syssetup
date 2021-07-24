# Enabling WSL2 on windows 
# enable wsl2
function enable-wsl {
    
    dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
    dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

    # make ready for rerun
    # push-location HKCU:\Software\Microsoft\Windows\CurrentVersion\RunOnce
    # new-itemproperty . MyKey -propertytype String -value "Start-Process powershell -Wait -Verb runAs -ArgumentList 'c:\bootstrap_wsl.ps1 setup'"
    # pop-location

    # Copy-Item .\bootstrap_wsl.ps1 -Destination C:\bootstrap_wsl.ps1

    Restart-Computer
}

function initialize-ubuntu {
    $ProgressPreference = 'SilentlyContinue'
    Invoke-WebRequest -Uri https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi -OutFile .\wsl_update.msi
    # omfg https://powershellexplained.com/2016-10-21-powershell-installing-msi-files/
    Start-Process msiexec.exe -Wait -ArgumentList ' /I .\wsl_update.msi /quiet'
    Remove-Item '.\wsl_update.msi'

     wsl --set-default-version 2

    Invoke-WebRequest -Uri https://aka.ms/wslubuntu2004 -OutFile Ubuntu.appx -UseBasicParsing
    Add-AppxPackage .\Ubuntu.appx
    Remove-Item '.\Ubuntu.appx'

    # Initial housekeeping
    #https://github.com/kaisalmen/wsltooling/blob/world/installUbuntuLTS.ps1
     wsl -u root -- apt update `&`& apt upgrade -y

     $ProgressPreference = 'Continue'  # because ms engineers cant do concurrency apparently
# https://stackoverflow.com/a/15166968
# todo https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi
# after reboot
}
