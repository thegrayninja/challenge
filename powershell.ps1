$inventory = ( Get-Content .\ps_inventory.txt -Raw | ConvertFrom-StringData )
$s1SiteToken = "qwertyuiop="
$cred = get-credential
$sentinelOneAgent = "test.txt"

foreach($asset in $inventory.GetEnumerator()){
    #UNINSTALL CROWDSTRIKE

    Write-Output 'Host: ',$asset.Name
    #Write-Output "value: $($asset.Value)"
    Invoke-Command -ComputerName $asset.Name -ScriptBlock { c:\temp\CsUninstallTool.exe MAINTENANCE_TOKEN=$asset.Values /quiet } -credential $cred
    Invoke-Command -ComputerName $asset.Name -ScriptBlock { if (-not (get-service "CSFalconService" -ErrorAction SilentlyContinue)) {write-host "CrowdStrike has been removed."} else {write-host "CrowdStrike is still installed"} } -credential $cred



    ## SENTINELONE COPY
    If(!(test-path -PathType container \\$($asset.Name)\c$\temp)){
      New-Item -ItemType Directory -Path \\$($asset.Name)\c$\temp
    }
        
    Copy-Item -Path c:\agents\test.txt -Destination \\$($asset.Name)\c$\temp\test.txt
    
    if(test-path \\$($asset.Name)\c$\temp\test.txt){
      Write-Host "$($sentinelOneAgent) copied successfully onto host $($asset.Name)"
    } else {
      Write-Host "ERROR - File FAILED to copy to host $($asset.Name)"
    }

    ## SENTINELONE INSTALL
    Invoke-Command -ComputerName $asset.Name -ScriptBlock { c:\temp\SentinelOneInstaller.exe -q --dont_fail_on_config_preserving_failures -t $s1SiteToken } -credential $cred

    
    ## SENTINELONE VERIFY
    Invoke-Command -ComputerName $asset.Name -ScriptBlock { if (get-service "SentinelOneServices" -ErrorAction SilentlyContinue) {write-host "SentinelOne is now installed."} else {write-host "SentinelOne failed to install"} } -credential $cred
}


