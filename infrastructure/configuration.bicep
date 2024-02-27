@description('Environment name')
@allowed([
  'sndbx'
  'prod'
  'dev'
])
param environment string

var environmentConfigurationMap = {
  prod: {
    SubscriptionID: 'f5d606b1-21fd-4844-9e05-e859515fc168'
    ClientId: 'edaae7d6-2147-4102-809c-7fa44a06f716'
    TenantId: '95933331-9c40-4ebf-9199-cd4c72f03a84'
    privateEndpointVnet: { // Private endpoint VNet settings
      resoureGroupName: 'iw-vnet-eastus2'
      virtualNetworkName: 'iw-vnet-eastus2-f5d606b1-21fd-4844-9e05-e859515fc168' // Name of the VNet
      subnetName: 'snet-corp-development-01-privateendpoint-eastus2-01'
    }
  }
}

output settings object = environmentConfigurationMap[environment]
