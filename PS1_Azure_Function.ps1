
[cmdletbinding()]
Param(
        
    [parameter(Mandatory=$false)]
	
    $AzLocation = 'UKWest',

        

    [parameter(Mandatory=$false)]
	
    $AZResourceGroupName = 'AZ-Function-Demo-RG'

)


## Sign into Azure.
Login-AzureRMAccount

## Create a new Resource Group to host your Function.
$ResourceGroupConfig = @{
   Location = $AzLocation
   Name     = $AZResourceGroupName
}

$ResourceGroup = New-AzureRMResourceGroup @ResourceGroupConfig

Write-Output ("Resource Group {0} has been create in {1} Location!" -f $ResourceGroup.ResourceGroupName,$ResourceGroup.Location)

## Create Storage Account for Azure Function

$StorageAccConfig = @{
   Location          = $AzLocation
   Name              = ($AZResourceGroupName.replace("RG","Stgacc").replace("-","").tolower())
   ResourceGroupName = $AZResourceGroupName
   SkuName           = 'Standard_LRS'
}


$StorageAccount = New-AzureRmStorageAccount @StorageAccConfig

Write-Output ("Storage Account {0} has been create in {1} Location in Resource Group {2}!" -f $StorageAccount.StorageAccountName,$StorageAccount.Location,$StorageAccount.ResourceGroupName)


## creates the function app

$WebAppConfig = @{
    Kind              = "Functionapp"
    Location          = $AzLocation
    Properties        = @{test = "test"} 
    ResourceName      = ($AZResourceGroupName.replace("RG","Function"))
    ResourceType      = "microsoft.web/sites" 
    ResourceGroupName = $AZResourceGroupName
    Force             = $true
}

$AzureFunction = New-AzureRmResource @WebAppConfig

Write-Output ("Azure Function {0} has been create in {1} Location in Resource Group {2}!" -f $AzureFunction.Name,$AzureFunction.Location,$AzureFunction.ResourceGroupName)





