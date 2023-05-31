az extension add --name aks-preview
az extension update --name aks-preview

az feature register --namespace "Microsoft.ContainerService" --name "AzureOverlayPreview"
az feature register --namespace "Microsoft.ContainerService" --name "AKS-KedaPreview"

$overlayState = az feature show --namespace "Microsoft.ContainerService" --name "AKS-KedaPreview" --query "properties.state" -otsv
$kedaState = az feature show --namespace "Microsoft.ContainerService" --name "AKS-KedaPreview" --query "properties.state" -otsv

while ($kedaState -ne "Registered" -and $kedastate -ne "Failed" -and $overlayState -ne "Registered" -and $overlayState -ne "Failed")
{
    Write-Host "Waiting for feature registration. Current state: $kedaState"
    Start-Sleep -s 10
    $kedaState = az feature show --namespace "Microsoft.ContainerService" --name "AKS-KedaPreview" --query "properties.state" -otsv
    $overlayState = az feature show --namespace "Microsoft.ContainerService" --name "AKS-KedaPreview" --query "properties.state" -otsv
}

az provider register --namespace Microsoft.ContainerService