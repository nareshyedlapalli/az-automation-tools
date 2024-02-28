@description('Workload name')
param workload string

@description('Environment name')
param environment string

@description('Resource Group location')
param location string


@description('Send Email Alert')
var ClientSecretExpirationRunbook = 'ClientSecretExpiration'

var automationAccountName = 'automation-${workload}-${environment}-${location}-01'

@description('Parameter to store the curent time')
param Time string = utcNow()

param startTimeUtc string = utcNow()
param delayMinutes int = 25

@description('Creating Automation account resource ')
resource automationAccount 'Microsoft.Automation/automationAccounts@2022-08-08' existing = {
  name: automationAccountName
}

@description('Creating a schedule for Add deny Resource policy')
resource ClientSecretExpiration 'Microsoft.Automation/automationAccounts/schedules@2022-08-08' = {
  parent: automationAccount
  name: 'ClientSecretExpiration'
  properties: {
    description: 'Run every day once'
    startTime: '${startTimeUtc} + duration(\'PT\' + string${delayMinutes} + \'M\')'
    expiryTime: '9999-12-31T17:59:00-06:00'
    interval: 1
    frequency: 'Day'
    timeZone: 'America/Chicago'
  }
}

@description('Creating a job schedule for Add deny Resource policy')
resource AddDenyResourcePolicyjobSchedule 'Microsoft.Automation/automationAccounts/jobSchedules@2022-08-08' = {
  parent: automationAccount
  // name: guid(resourceGroup().id, 'AddDenyResourcePolicyjobSchedule')
  name: guid(Time,'AddDenyResourcePolicyjobSchedule')
  properties: {
    runbook: {
      name: ClientSecretExpirationRunbook
    }
    schedule: {
      name: 'ClientSecretExpiration'
    }
  }
}
