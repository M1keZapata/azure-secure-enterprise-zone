# Azure Tagging Strategy
 
## Purpose
 
The Azure Secure Enterprise Platform uses standardized tags to improve governance, cost tracking, ownership identification, resource discovery, reporting, and automation.
 
This tagging strategy is applied consistently across platform resources.
 
---
 
## Standard Tags
 
| Tag | Value |
|------|--------|
| Environment | Production |
| Owner | Mike Zapata |
| Project | Azure Secure Enterprise Platform |
| ManagedBy | Terraform |
| CostCenter | IT |
 
---
 
## Tag Definitions
 
### Environment
 
Identifies the deployment environment.
 
Examples:
 
```text
Production
Development
Test
Sandbox
```
 
Current Value:
 
```text
Production
```
 
---
 
### Owner
 
Identifies the individual responsible for the resource.
 
Current Value:
 
```text
Mike Zapata
```
 
Purpose:
 
- Accountability
- Resource governance
- Contact identification
 
---
 
### Project
 
Identifies the project associated with the resource.
 
Current Value:
 
```text
Azure Secure Enterprise Platform
```
 
Purpose:
 
- Group related resources
- Support reporting
- Support cost analysis
 
---
 
### ManagedBy
 
Indicates the management method used for the resource.
 
Current Value:
 
```text
Terraform
```
 
Purpose:
 
- Infrastructure-as-Code tracking
- Platform automation visibility
- Operational consistency
 
Note:
 
Although some resources were initially created manually for learning purposes, future deployment goals include Terraform-based provisioning.
 
---
 
### CostCenter
 
Supports budgeting and financial tracking.
 
Current Value:
 
```text
IT
```
 
Purpose:
 
- Azure Cost Management
- Chargeback reporting
- Resource cost attribution
 
---
 
## Resources Tagged
 
Current project resources include:
 
### Governance
 
- gtg-hub-prod
- gtg-spoke-prod
- gtg-security-prod
- gtg-monitoring-prod
 
### Networking
 
- vnet-hub-prod
- vnet-spoke-prod
- nsg-servers-prod
- pe-stsecureplatprod
 
### Compute
 
- vm-admin-prod-01
 
### Storage
 
- stsecureplatprod
 
### Security
 
- kv-security-prod01