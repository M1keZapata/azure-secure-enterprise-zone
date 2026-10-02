# Azure Naming Standards
 
## Purpose
 
This naming standard provides consistency across all Azure resources deployed within the Azure Secure Enterprise Platform.
 
Goals:
 
- Improve resource discoverability
- Simplify administration
- Support automation
- Standardize documentation
- Align with enterprise cloud practices
 
---
 
## Naming Convention Structure
 
General format:
 
<resource-type>-<function>-<environment>
 
Examples:
 
vnet-hub-prod
 
vm-admin-prod-01
 
kv-security-prod
 
---
 
## Resource Groups
 
Format:
 
rg-<function>-<environment>
 
Examples:
 
rg-hub-prod
 
rg-spoke-prod
 
rg-security-prod
 
rg-monitoring-prod
 
---
 
## Virtual Networks
 
Format:
 
vnet-<function>-<environment>
 
Examples:
 
vnet-hub-prod
 
vnet-spoke-prod
 
---
 
## Subnets
 
Format:
 
snet-<function>
 
Examples:
 
snet-management
 
snet-servers
 
snet-private-endpoints
 
AzureBastionSubnet
 
AzureFirewallSubnet
 
---
 
## Network Security Groups
 
Format:
 
nsg-<function>-<environment>
 
Examples:
 
nsg-servers-prod
 
nsg-management-prod
 
---
 
## Virtual Machines
 
Format:
 
vm-<role>-<environment>-<instance>
 
Examples:
 
vm-admin-prod-01
 
vm-web-prod-01
 
vm-app-prod-01
 
---
 
## Storage Accounts
 
Format:
 
st<workload><environment>
 
Examples:
 
stsecureplatprod
 
stplatformprod
 
Notes:
 
- Must be globally unique
- Lowercase only
- No hyphens
 
---
 
## Private Endpoints
 
Format:
 
pe-<resource>
 
Examples:
 
pe-stsecureplatprod
 
pe-keyvault-prod
 
---
 
## Log Analytics Workspaces
 
Format:
 
law-<function>-<environment>
 
Examples:
 
law-monitoring-prod
 
---
 
## Azure Key Vaults
 
Format:
 
kv-<function>-<environment>
 
Examples:
 
kv-security-prod
 
kv-security-prod01
 
---
 
## Microsoft Entra ID Groups
 
Format:
 
Azure-<Role>
 
Examples:
 
Azure-Admins
 
Azure-Readers
 
Azure-Security
 
---
 
## Diagnostic Settings
 
Format:
 
<resource>-to-law
 
Examples:
 
activitylogs-to-law
 
storage-to-law
 
keyvault-to-law
 
---
 
## Design Principles
 
- Resource names should describe purpose, not owner.
- Environment identifiers should be included when applicable.
- Naming should remain consistent across subscriptions.
- Abbreviations should be standardized and documented.
- Names should support future automation through Terraform and CI/CD pipelines.