$currentFolder = Get-Location

#### BUILD THE .NET 7 App ####
Set-Location ..\src\DotNetCoreApp
#az acr build -r aksinaday -t aksinaday.azurecr.io/webapp02:latest --platform linux .
Set-Location $currentFolder

#### BUILD THE .NET Framework App ####
Set-Location ..\src\DotnetFrameworkApp
#./msbuild.bat
#az acr build -r aksinaday -t aksinaday.azurecr.io/webapp01:latest --platform windows ./publish
Set-Location $currentFolder

#### BUILD THE wINDOWS AZURE DEVOPS AGENT ####
Set-Location ..\src\AzDoAgent
az acr build -r aksinaday -t aksinaday.azurecr.io/azdowin:latest --platform windows .
Set-Location $currentFolder


