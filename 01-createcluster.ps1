#create the initial cluster
az aks create --resource-group $env:resourceGroupName `
              --name $env:clusterName `
              --location $env:location `
              --enable-aad `
              --aad-admin-group-object-ids $env:AKSAdminGroup `
              --node-count 1 `
              --node-vm-size Standard_D2s_v3 `
              --nodepool-name nplinux `
              --os-sku AzureLinux `
              --zones 1 2 3 `
              --enable-cluster-autoscaler `
              --min-count 1 `
              --max-count 3 `
              --network-plugin azure `
              #--network-plugin-mode overlay

              

az aks get-credentials --resource-group $env:resourceGroupName `
              --name $env:clusterName `
              --overwrite-existing

kubelogin convert-kubeconfig -l azurecli