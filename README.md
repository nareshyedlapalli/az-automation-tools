# Az-CostAutomation-Tool

Tool will include Resource Deny creation, Timer Reset. Resource Deny creation tool will help to monitor the budget for subscription and resource groups, send alerts and disable the resource creation when the budget reached the threshold by enabling the Deny all resource creation policy. Timer Reset tool will help to remove the Deny all resource creation policy every starting of the month, meaning it will reset budget and user can again start creating resources.

## Application Architecture

![Architecture](./img/img.png)

## Tools And Technologies

The application is built with following tools and technologies -

- Source Control - [Github](https://github.com/)
- Development IDE - [Visual Studio Code](https://code.visualstudio.com/)
- Powershell - [Powershell](https://learn.microsoft.com/en-us/powershell/scripting/overview?view=powershell-7.3)
- Bicep - [Bicep](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/overview?tabs=bicep)
- Az cli - [AZ CLI](https://learn.microsoft.com/en-us/cli/azure/)

## Project Components

- Function App
- Storage Account
- Action Groups
- Application insights

## Common commands

- To install bicep 
    - 'az bicep install' (https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/install)
- To run the deployment from local 
    - 'az deployment group create --resource-group amit-budget-policy --template-file ./infrastructure/main.bicep --parameters location=eastus2 workload=costautomation environment=sndbx automationAccountName=budget-automation-account'