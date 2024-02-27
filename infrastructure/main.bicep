@description('Workload name')
param workload string = 'crop'

@description('Environment name')
param environment string = 'prod'

@description('Resource Group location')
param location string = 'eastus2'
 
@description('SMTP configuration password')
@secure()
param AppSecret string = 'v0_8Q~fKq9OQSerrPn6_yhgf7xrW1THHJJSXwcHb'

@description('A module that defines all the environment specific configuration')
module configModule './configuration.bicep' = {
  name: '${resourceGroup().name}-config-module'
  scope: resourceGroup()
  params: {
    environment: environment
  }
}

@description('A variable to hold all environment specific variables')
var config = configModule.outputs.settings

@description('Obtaining reference to the virtual network subnet for the private endpoints')
resource privateEndpointSubnet 'Microsoft.Network/virtualNetworks/subnets@2021-08-01' existing = {
  name: '${config.privateEndpointVnet.virtualNetworkName}/${config.privateEndpointVnet.subnetName}'
  scope: resourceGroup(config.privateEndpointVnet.resoureGroupName)
}

@description('Module to create automation-account')
module automationAccountModule './automation-account.bicep' = {
  name:  'aa-${workload}-${environment}-${location}-01'
  params: {
    automationAccountName: 'aa-${workload}-${environment}-${location}-01'
    location: location
    SubscriptionID: config.SubscriptionID
    ClientId: config.ClientId
    privateEndpointSubnetId: privateEndpointSubnet.id
    workload: workload
    environment: environment
    AppSecret: config.AppSecret
    TenantId: config.TenantId
  }    
}
