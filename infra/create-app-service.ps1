
Install-Module AzureRM 

Import-Module AzureRM

New-AzureRmResourceGroup -Name "Soup2NutsRG" -Location "West US"

New-AzureRmAppServicePlan -ResourceGroupName "Soup2NutsRG" -Name "soup2nuts-app-plan" -Location "West US" -Tier "Basic" -NumberofWorkers 2 -WorkerSize "Small"

New-AzureRmWebApp -ResourceGroupName "Soup2NutsRG" -Name "ContosoSite" -Location "West US" -AppServicePlan "soup2nuts-app-plan"