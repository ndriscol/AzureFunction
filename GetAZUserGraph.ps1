# POST method: $req
$requestBody = Get-Content $req -Raw | ConvertFrom-Json

$apiVersion = "2017-09-01"
$resourceURI = 'https://graph.microsoft.com'
$tokenAuthURI = $env:MSI_ENDPOINT + "?resource=$resourceURI&api-version=$apiVersion"
$bearer = Invoke-RestMethod -Method Get -Headers @{"Secret"="$env:MSI_SECRET"} -Uri $tokenAuthURI
$bearer.access_token
Invoke-RestMethod -Headers @{'Content-Type'='application\json' ;Authorization = "Bearer $bearer.access_token"} -Uri "https://graph.windows.net/e5dfffc4-be25-4cbe-9ddf-fef8889bead2/users?api-version=1.6" -Method Get


$users = Invoke-RestMethod -Method Get -Uri https://graph.microsoft.com/v1.0/users -Headers @{Authorization  = 'Bearer ' + $BearerToken.access_token} 

Out-File -Encoding Ascii -FilePath $res -inputObject ($users.Value |Select-Object -property mail,DisplayName| ConvertTo-Json)
