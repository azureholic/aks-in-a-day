az aks update --enable-oidc-issuer `
              --enable-workload-identity `
              --resource-group $env:resourceGroupName `
              --name $env:clusterName

$env:AKS_OIDC_Issuer="$(az aks show --name $env:clusterName `
              --resource-group $env:ResourceGroupName `
              --query "oidcIssuerProfile.issuerUrl" -otsv)"