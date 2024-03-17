$csMaintToken = "abcdefg"
$s1SiteToken = "qwertyuiop="

#remove CrowdStrike
c:\temp\CsUninstallTool.exe MAINTENANCE_TOKEN=$csMaintToken /quiet
if (-not (get-service "CSFalconService" -ErrorAction SilentlyContinue)) {write-host "CrowdStrike has been removed."}

#install SentinelOne
c:\temp\SentinelOneInstaller.exe -q --dont_fail_on_config_preserving_failures -t $s1SiteToken
if (get-service "SentinelOneServices" -ErrorAction SilentlyContinue) {write-host "SentinelOne is now installed."}
