$env:resourceGroupName = "rg-aks-01"
$env:clusterName = "aks-01"
$env:location = "westeurope"


#Create the resource group if not exists
az group create --name $env:resourceGroupName --location $env:location

$env:AKSAdminGroup = az ad group create --display-name "rbr-aks-admins" `
                   --mail-nickname "rbr-aks-admins" `
                   --query "id" -otsv

#Add current User to the group
$currentUserId = az ad signed-in-user show --query "id" -otsv 
az ad group member add --group $env:AKSAdminGroup --member-id $currentUserId

#install CLI Tools
az aks install-cli
winget instqall Helm.Helm
