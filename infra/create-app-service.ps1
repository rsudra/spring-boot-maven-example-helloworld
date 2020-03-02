

New-AzureRmResourceGroup -Name "Soup2NutsRG" -Location "West US"

New-AzureRmAppServicePlan -ResourceGroupName "Soup2NutsRG" -Name "soup2nuts-app-plan" -Location "West US" -Tier "Basic" -NumberofWorkers 2 -WorkerSize "Small"

New-AzureRmWebApp -ResourceGroupName "Soup2NutsRG" -Name "soup2nuts-app" -Location "West US" -AppServicePlan "soup2nuts-app-plan"

$javaVersion="1.8"
$javaContainer="TOMCAT"
$javaContainerVersion="9.0"
#Configuring jdk and web container
$PropertiesObject = @{javaVersion = $javaVersion;javaContainer = $javaContainer;javaContainerVersion = $javaContainerVersion}

$webappname="soup2nuts-app"
$rgname="Soup2NutsRG"
Set-AzureRmResource -PropertyObject $PropertiesObject -ResourceGroupName $rgname -ResourceType Microsoft.Web/sites/config -ResourceName $webappname/web -ApiVersion 2015-08-01 -Force
