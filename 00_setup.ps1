$env:resourceGroupName = "rg-aks-in-day"
$env:clusterName = "aks-01"
$env:location = "uksouth"
$env:registryName = "acraksinaday"


#Create the resource group if not exists
az group create --name $env:resourceGroupName --location $env:location

$env:AKSAdminGroup = az ad group create --display-name "rbr-aks-admins" `
                   --mail-nickname "rbr-aks-admins" `
                   --query "id" -otsv

az acr create --resource-group $env:resourceGroupName `
              --name $env:registryName `
              --sku Basic

az identity create --name clustermi `
                   --resource-group $env:resourceGroupName `
                   --location uksouth 
                 
                 
$env:miResourceId = $(az identity show --resource-group $env:resourceGroupName --name clustermi --query id --output tsv)
$spId=$(az identity show --resource-group $env:resourceGroupName --name clustermi --query principalId --output tsv)
$acrResourceId=$(az acr show --resource-group $env:resourceGroupName --name $env:registryName --query id --output tsv)
az role assignment create --assignee $spId --scope $acrResourceId --role acrpull

#Add current User to the group
$currentUserId = az ad signed-in-user show --query "id" -otsv 
az ad group member add --group $env:AKSAdminGroup --member-id $currentUserId

#install CLI Tools
az aks install-cli
winget install Helm.Helm

#build containers and push to ACR
$currentFolder = Get-Location

#### BUILD THE .NET 7 App ####
Set-Location .\src\DotNetCoreApp
az acr build -r $env:registryName -t webapp02:latest --platform linux .
Set-Location $currentFolder

#### BUILD THE .NET Framework App ####
Set-Location .\src\DotnetFrameworkApp
./msbuild.bat
az acr build -r $env:registryName -t webapp01:latest --platform windows ./publish
Set-Location $currentFolder

#### BUILD THE wINDOWS AZURE DEVOPS AGENT ####
Set-Location .\src\AzDoAgent
az acr build -r $env:registryName -t azdowin:latest --platform windows .
Set-Location $currentFolder
