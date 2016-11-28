# dewarsztaty - Windows Containers

##Przygotowanie środowiska
	
1. Założenie konta Microsoft Account -[http://outlook.com](http://outlook.com).
2. Aktywacja konta Azure z AzurePass - [link](https://www.microsoftazurepass.com/).
3. Instalacja środowsika w Azure z szablonu. Klikamy na przycisk **Deploy to Azure** poniżej. Przy wypełnianiu parametrów wdrożenia w polu **Resource group** wybieramy **Create new** i wpisujemy **devwarsztaty** oraz jako **Location** ustawiamy **West Europe**.

	<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fkaluzaaa%2Fdewarsztaty-Windows-Containers%2Fmaster%2Ftemplates%2Fazuredeploy.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>

##Instalacja Docker na Windows Server

Na serwerze docker02 instalujemy Windows Containers i silnik Docker.

```powershell
Install-Module -Name DockerMsftProvider -Repository PSGallery -Force

Install-Package -Name docker -ProviderName DockerMsftProvider

Restart-Computer -Force
```

Sprawdzenie wersji zainstalowanego Docker

```
docker version
```

Uruchomienie testowego kontenera

```
docker run microsoft/dotnet-samples:dotnetapp-nanoserver
```

##Uruchomienie kontenera z IIS

Na serwerze docker02.

```
docker run -d --name iis01 -p 80:80 microsoft/iis cmd
```

Sprawdź adres ip kontenera.

```
docker inspect -f "{{ .NetworkSettings.Networks.nat.IPAddress }}" iis01
```

Sprawdź stronę na porcie 80 korzystając z wcześniej sprawdzonego IP.

Podłącz się do kontenera.

```
docker exec -it iis01 cmd
```

Skasuj iisstart.htm i utwórz nowy plik index.html

```
del C:\inetpub\wwwroot\iisstart.htm

echo "Hello World From a Windows Server Container" > C:\inetpub\wwwroot\index.html
```

Odśwież stronę.

```
exit
```

Wyświetl kontenery

```
docker ps -a
```

Wyłącz kontener

```
docker stop iis01
```

##Tworzenie własnego obrazu ręcznie

Stworzenie obrazu z istniejącego kontenera

```
docker commit iis01 modified-iis
```

Wyświetlenie dostępnych obrazów

```
docker images
```

Stworzenie obrazu z przypisaniem taga


```
docker commit iis01 modified-iis:test
```

Wyświetlenie dostępnych obrazów

```
docker images
```

##Tworzenie własnego obrazu z Dockerfile
