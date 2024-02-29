

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

@description('Environment subscription ID')
param SubscriptionID string

@description('Environment client ID')
param ClientId string

@description('Environment tenantId ID')
param TenantId string

@description('Environment client ID appsecret')
@secure()
param AppSecret string

@description('Email Sender')
param EmailSender string

@description('Email To')
param EmailTo string



@description('Automation account private endpoint resource definition')
resource automationAccountPrivateEndpoint 'Microsoft.Network/privateEndpoints@2023-04-01' = {
  name: 'pep-${workload}-${environment}-${location}-01'
  location: location
  properties: {
    privateLinkServiceConnections: [
      {
        name: 'plconnection-${workload}-${environment}'
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
resource automationAccounAppSecretVariable 'Microsoft.Automation/automationAccounts/variables@2022-08-08' = {
  parent: automationAccount
  name: 'app-Secret'
  properties: {
    isEncrypted: true
    value: '"${AppSecret}"'
  }
}

@description('A resource definition to hold excludedRGlist variable') 
resource automationAccountTenetIdVariable 'Microsoft.Automation/automationAccounts/variables@2022-08-08' = {
  parent: automationAccount
  name: 'tenant-id'
  properties: {
    isEncrypted: false
    value: '"${TenantId}"'
  }
}

@description('A resource definition to hold excludedRGlist variable') 
resource automationAccountClientIdVariable 'Microsoft.Automation/automationAccounts/variables@2022-08-08' = {
  parent: automationAccount
  name: 'client-id'
  properties: {
    isEncrypted: true
    value: '"${ClientId}"'
  }
}
@description('A resource definition to hold excludedRGlist variable') 
resource automationAccountEmailSenderVariable 'Microsoft.Automation/automationAccounts/variables@2022-08-08' = {
  parent: automationAccount
  name: 'email-sender'
  properties: {
    isEncrypted: true
    value: '"${EmailSender}"'
  }
}

@description('A resource definition to hold excludedRGlist variable') 
resource automationAccountEmailToVariable 'Microsoft.Automation/automationAccounts/variables@2022-08-08' = {
  parent: automationAccount
  name: 'email-to'
  properties: {
    isEncrypted: false
    value: '"${EmailTo}"'
  }
}
