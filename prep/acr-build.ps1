$currentFolder = Get-Location

#### BUILD THE .NET 7 App ####
Set-Location ..\src\DotNetCoreApp
#az acr build -r aksinaday -t aksinaday.azurecr.io/webapp02:latest --platform linux .
Set-Location $currentFolder

#### BUILD THE .NET Framework App ####
Set-Location ..\src\DotnetFrameworkApp
copy Dockerfile ./publish
az acr build -r aksinaday -t aksinaday.azurecr.io/webapp01:latest --platform windows ./publish
Set-Location $currentFolder


