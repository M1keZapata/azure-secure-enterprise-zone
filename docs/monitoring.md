# Security Design

## Overview

The Azure Secure Enterprise Platform implements layered security controls across identity, access management, secret management, monitoring, and workload protection.

The design follows the principles of:

- Zero Trust
- Least Privilege
- Defense in Depth
- Identity-First Security
- Private Connectivity
- Centralized Monitoring

---

## Azure Key Vault

### Purpose

Provides centralized and secure storage for:

- Secrets
- Credentials
- Certificates
- Future application secrets

The Key Vault eliminates the need to store credentials within applications, scripts, or configuration files.

---

## Key Vault Deployment

### Name

```text
kv-security-prod01
```

### Resource Group

```text
gtg-security-prod
```

### Region

```text
East US
```

### Pricing Tier

```text
Standard
```

---

## Access Model

Authorization Model:

```text
Azure Role-Based Access Control (RBAC)
```

Legacy access policies are not used.

Reason:

RBAC provides centralized permission management and aligns with Microsoft security best practices.

---

## Security Features

### Soft Delete

Status:

```text
Enabled
```

Purpose:

Prevents accidental deletion of Key Vault objects.

---

### Purge Protection

Status:

```text
Enabled (where supported)
```

Purpose:

Protects deleted content from permanent removal.

---

## Key Vault Secret

### Secret Name

```text
vm-admin-password
```

Purpose:

Demonstrates centralized secret storage and retrieval using Azure Key Vault.

Notes:

The stored value is for lab validation purposes only and is not used as a production credential.

---

## RBAC Configuration

### Azure-Admins

Role:

```text
Key Vault Secrets Officer
```

Scope:

```text
kv-security-prod01
```

Purpose:

Allows authorized administrators to create, modify, and manage secrets within the Key Vault.

Design Principle:

Permissions are granted through Microsoft Entra groups rather than directly to individual user accounts.

---

## Managed Identity Integration

### Resource

```text
vm-admin-prod-01
```

### Identity Type

```text
System Assigned Managed Identity
```

### Assigned Role

```text
Key Vault Secrets User
```

### Scope

```text
kv-security-prod01
```

### Purpose

Allows the virtual machine to retrieve Key Vault secrets without storing passwords, API keys, or service account credentials.

---

## Authentication and Authorization Flow

```text
vm-admin-prod-01
        │
        ▼
Managed Identity
        │
        ▼
Azure RBAC
        │
        ▼
Key Vault Secrets User
        │
        ▼
kv-security-prod01
        │
        ▼
vm-admin-password
```

---

## Key Vault Validation

Validation Activities:

- Created Key Vault
- Enabled RBAC authorization
- Created test secret
- Assigned Key Vault Secrets Officer role
- Verified secret visibility
- Retrieved stored secret value

Outcome:

RBAC authorization for Azure Key Vault was successfully validated.

---

## Monitoring Configuration

### Diagnostic Setting

```text
keyvault-to-law
```

### Destination

```text
law-monitoring-prod
```

### Logs Enabled

- Audit Logs
- Azure Policy Evaluation Details

### Metrics Enabled

```text
AllMetrics
```

Purpose:

Provides centralized monitoring and investigation capability for Key Vault activity.

---

## Current Security Architecture

```text
Microsoft Entra ID
        │
        ▼
Azure RBAC
        │
        ▼
Azure-Admins
        │
        ▼
Key Vault Secrets Officer
        │
        ▼
kv-security-prod01
        │
        ▼
Secret Management

vm-admin-prod-01
        │
        ▼
Managed Identity
        │
        ▼
Key Vault Secrets User
        │
        ▼
kv-security-prod01
```

---

## Security Benefits

### Centralized Secret Management

Secrets are stored in Azure Key Vault rather than scripts, applications, or documentation.

---

### Least Privilege Access

Permissions are assigned through purpose-built RBAC roles rather than broad administrative rights.

---

### Passwordless Authentication

Managed Identity enables Azure resource authentication without credential storage.

---

### Auditing and Monitoring

Diagnostic logs are forwarded to:

```text
law-monitoring-prod
```

for monitoring and investigation.

---

## Future Enhancements

### Private Endpoint for Key Vault

Planned Architecture:

```text
Private Endpoint
        ↓
Azure Key Vault
```

Purpose:

Eliminate public network access.

---

### Microsoft Defender for Cloud

Planned Review:

- Secure Score
- Security Recommendations
- Cloud Security Posture Management

Purpose:

Improve visibility into Azure security posture.

---

### Microsoft Sentinel Analytics

Future Detection Opportunities:

- New RBAC Assignments
- Secret Creation Events
- Secret Deletion Events
- Privileged Activity

Purpose:

Extend Key Vault monitoring into security operations workflows.

---

## Design Principles

- Secrets should never be embedded in source code.
- Identity-based authentication is preferred over credentials.
- RBAC should be used instead of legacy access policies.
- Monitoring should be enabled for all security-sensitive resources.
- Access should follow least privilege principles.
- Public exposure should be minimized whenever possible.