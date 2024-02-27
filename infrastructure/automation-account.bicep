

@description('automationAccountName')
param automationAccountName string

@description('Subnet Id for private endpoint creation')
param privateEndpointSubnetId string

@description('location')
param location string

@description('Application environment')
param environment string

@description('Application workload type')
param workload string

@description('smtpserver')
param ClientId string


@description('Sandbox subscription ID')
param SubscriptionID string



@description('Automation account private endpoint resource definition')
resource automationAccountPrivateEndpoint 'Microsoft.Network/privateEndpoints@2023-04-01' = {
  name: 'pep-aa-${workload}-${environment}-${location}-01'
  location: location
  properties: {
    privateLinkServiceConnections: [
      {
        name: 'plconnection-aa-${workload}-${environment}'
        properties: {
          privateLinkServiceId: automationAccount.id
          groupIds: ['Webhook']
        }
      }
    ]
    subnet: {
      id: privateEndpointSubnetId
    }
  }
}

@description('Creating Automation account resource ')
resource automationAccount 'Microsoft.Automation/automationAccounts@2022-08-08' = {
  name: automationAccountName
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    publicNetworkAccess: false
    disableLocalAuth: false
    sku: {
      name: 'Basic'
    }
    encryption: {
      keySource: 'Microsoft.Automation'
      identity: {}
    }
  }
}

@description('A resource definition to hold excludedRGlist variable') 
resource automationAccountSubscriptionIDVariable 'Microsoft.Automation/automationAccounts/variables@2022-08-08' = {
  parent: automationAccount
  name: 'SubscriptionID'
  properties: {
    isEncrypted: false
    value: '"${SubscriptionID}"'
  }
}

@description('A resource definition to hold excludedRGlist variable') 
resource automationAccountsmtpportVariable 'Microsoft.Automation/automationAccounts/variables@2022-08-08' = {
  parent: automationAccount
  name: 'tenant-id'
  properties: {
    isEncrypted: false
    value: '"${TenantId}"'
  }
}

@description('A resource definition to hold excludedRGlist variable') 
resource automationAccountSenderVariable 'Microsoft.Automation/automationAccounts/variables@2022-08-08' = {
  parent: automationAccount
  name: 'client-id'
  properties: {
    isEncrypted: true
    value: '"${ClientId}"'
  }
}


