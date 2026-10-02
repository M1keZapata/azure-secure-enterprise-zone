# Compute Design

## Overview

The compute layer of the Azure Secure Enterprise Platform provides a managed Windows server used for administration, connectivity testing, monitoring validation, identity integration, and future security demonstrations.

The design emphasizes:

- Private networking
- Least privilege access
- Managed identity integration
- Cost control
- Enterprise administration practices

---

## Windows Administration Server

### Purpose

Provides a managed Windows server for:

- Administration
- Connectivity testing
- Monitoring validation
- RBAC testing
- Azure service integration
- Managed Identity demonstrations

---

## Virtual Machine Configuration

### Name

```text
vm-admin-prod-01
```

### Resource Group

```text
gtg-spoke-prod
```

### Region

```text
East US
```

### Operating System

```text
Windows Server 2025 Datacenter: Azure Edition
```

---

## VM Sizing Decision

### Selected Size

```text
F1als_v7
```

### Original Design

Preferred Size:

```text
B2s
```

Reason:

- Low cost
- Suitable for administration tasks
- Appropriate for lab workloads

---

### Deployment Adjustment

The deployment could not use a B-series VM because of subscription quota restrictions.

Selected Instead:

```text
F1als_v7
```

Rationale:

- Available within current subscription quota limits
- Enables project progression
- Supports administrative and testing workloads

---

## Storage Configuration

### OS Disk

Type:

```text
Standard SSD
```

Reason:

- Lower cost
- Suitable performance for administrative workloads

---

## Network Configuration

### Virtual Network

```text
vnet-spoke-prod
```

### Subnet

```text
snet-servers
```

### Public IP

```text
None
```

### Public Inbound Ports

```text
None
```

---

## Security Design

### Network Security

Protected by:

```text
nsg-servers-prod
```

Administrative access model:

```text
Hub Network
        ↓
Allowed RDP (3389)
        ↓
Spoke Workloads
```

---

### Identity

Authentication Model:

```text
Local Administrator Account
```

Administrative Account:

```text
azureadmin
```

---

### Managed Identity

Type:

```text
System Assigned Managed Identity
```

Status:

```text
Enabled
```

Purpose:

Provides authentication to Azure resources without storing credentials.

---

### Managed Identity Integration

Current Integration:

```text
vm-admin-prod-01
        ↓
Key Vault Secrets User
        ↓
kv-security-prod01
```

Purpose:

Allows the VM to retrieve secrets from Azure Key Vault without passwords or service accounts.

---

## Cost Controls

Implemented Controls:

- No Public IP
- Standard SSD OS Disk
- Single VM deployment
- Auto-shutdown enabled

---

### Auto Shutdown

Status:

```text
Enabled
```

Schedule:

```text
9:00 PM Eastern Time
```

Purpose:

Reduce unnecessary Azure consumption and project costs.

---

## Deployment Status

Status:

```text
Deployed
```

Resource:

```text
vm-admin-prod-01
```

Deployment Notes:

The virtual machine was successfully deployed using a quota-available VM size while maintaining the original security and architecture objectives.

---

## Current Architecture

```text
vm-admin-prod-01
        │
        ▼
vnet-spoke-prod
        │
        ▼
snet-servers
        │
        ▼
nsg-servers-prod
        │
        ▼
Managed Identity
        │
        ▼
Azure Key Vault
```

---

## Operational Use Cases

The virtual machine supports:

- RBAC validation
- Azure networking validation
- Managed Identity testing
- Key Vault integration
- Monitoring demonstrations
- Future Log Analytics integration
- Future security investigations

---

## Future Enhancements

### Azure Monitor Agent

Planned:

```text
Azure Monitor Agent (AMA)
```

Purpose:

Send telemetry and event data to Log Analytics.

---

### Microsoft Entra Login

Potential future enhancement:

```text
Login with Microsoft Entra ID
```

Purpose:

Eliminate dependence on local administrative credentials.

---

### Key Vault Secret Retrieval

Future validation:

```text
VM
 ↓
Managed Identity
 ↓
Key Vault
 ↓
Retrieve Secret
```

Purpose:

Demonstrate passwordless authentication workflows.

---

## Design Principles

- Workloads should remain private by default.
- Public exposure should be minimized.
- Authentication should move toward passwordless models.
- Managed Identities should be preferred over stored credentials.
- Cost controls should be implemented wherever practical.
- Resource design should support future monitoring and security operations.