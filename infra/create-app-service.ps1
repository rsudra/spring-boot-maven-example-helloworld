
$myResourceGroupName="Soup2NutsRG"
$location="West US"
$appSvcPlanName="soup2nuts-app-plan"
$appSvc="soup2nuts-app"

Get-AzureRmResourceGroup -Name $myResourceGroupName -ErrorVariable notPresent -ErrorAction SilentlyContinue
if ($notPresent) {
    # ResourceGroup doesn't exist
    New-AzureRmResourceGroup -Name $myResourceGroupName -Location $location
    Write-Output "Resouce group created"
} else {
    Write-Output "Resouce group already exists"
}

Get-AzureRmAppServicePlan -ResourceGroupName $myResourceGroupName -Name $appSvcPlanName -ErrorVariable notPresent -ErrorAction SilentlyContinue
if ($notPresent) {
    # ResourceGroup doesn't exist
    New-AzureRmAppServicePlan -ResourceGroupName $myResourceGroupName -Name $appSvcPlanName -Location $location -Tier "Basic" -NumberofWorkers 2 -WorkerSize "Small"
    Write-Output "App service plan created"
} else {
    Write-Output "App service plan already exists"
}

Get-AzureRmWebApp -ResourceGroupName $myResourceGroupName -Name $appSvc -ErrorVariable notPresent -ErrorAction SilentlyContinue
if ($notPresent) {
    # ResourceGroup doesn't exist
    New-AzureRmWebApp -ResourceGroupName $myResourceGroupName -Name $appSvc -Location $location -AppServicePlan $appSvcPlanName
    Write-Output "App service created"
} else {
    Write-Output "App service already exists"
}

$javaVersion="1.8"
$javaContainer="TOMCAT"
$javaContainerVersion="9.0"
#Configuring jdk and web container
$PropertiesObject = @{javaVersion = $javaVersion;javaContainer = $javaContainer;javaContainerVersion = $javaContainerVersion}

$webappname="soup2nuts-app"
$rgname="Soup2NutsRG"
Set-AzureRmResource -PropertyObject $PropertiesObject -ResourceGroupName $rgname -ResourceType Microsoft.Web/sites/config -ResourceName $webappname/web -ApiVersion 2015-08-01 -Force
Write-Output "App service configured for Tomcat-Java"

# comment 2