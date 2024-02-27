param($ResourceGroup, $automationAccountName)

$ClientSecretExpiration = 'ClientSecretExpiration'


Import-AzAutomationRunbook -AutomationAccountName $automationAccountName -ResourceGroupName $ResourceGroup -Name $ClientSecretExpiration -Path "./infrastructure/runbooks/client-secret-expiration.ps1" -Published -Type PowerShell -Force
