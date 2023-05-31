az aks update `
  --resource-group $env:ResourceGroupName `
  --name $env:clusterName `
  --enable-keda 