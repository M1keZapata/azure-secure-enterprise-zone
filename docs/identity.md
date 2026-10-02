# Identity Design

## Overview

Identity within the Azure Secure Enterprise Platform is built around Microsoft Entra ID, Azure Role-Based Access Control (RBAC), and Managed Identities.

The design prioritizes:

- Least privilege access
- Group-based authorization
- Elimination of credential sprawl
- Scalable administration
- Modern Azure security practices

---

## Microsoft Entra ID Groups

### Azure-Admins

Purpose:

Administrative access to Azure resources.

Responsibilities:

- Resource deployment
- Platform administration
- Operational management

Current Membership:

- Mike Zapata

---

### Azure-Readers

Purpose:

Read-only visibility into Azure resources.

Responsibilities:

- Monitoring
- Reporting
- Resource review

Current Membership:

None

---

### Azure-Security

Purpose:

Security monitoring and compliance operations.

Responsibilities:

- Security investigations
- Risk assessment
- Security posture review

Current Membership:

None

---

## Design Principle

Permissions are assigned to groups rather than directly to users.

Preferred Model:

```text
User
    ↓
Group
    ↓
Role
    ↓
Resource
```

Avoided Model:

```text
User
    ↓
Direct Permission Assignment
```

Benefits:

- Easier administration
- Consistent access control
- Simplified auditing
- Improved scalability

---

## Role-Based Access Control (RBAC)

### Azure-Admins

Role:

```text
Contributor
```

Scope:

```text
Subscription
```

Purpose:

Provides administrative access to Azure resources across the subscription.

Capabilities:

- Create resources
- Modify resources
- Delete resources

Limitations:

- Cannot grant permissions to other users

---

### Azure-Readers

Role:

```text
Reader
```

Scope:

```text
Subscription
```

Purpose:

Provides read-only visibility into Azure resources.

Capabilities:

- View resources
- Review configurations
- Access monitoring data (where authorized)

Limitations:

- Cannot modify resources

---

### Azure-Security

Role:

```text
Security Reader
```

Scope:

```text
Subscription
```

Purpose:

Provides visibility into security-related resources and recommendations.

Capabilities:

- Review security posture
- View Defender recommendations
- Review security monitoring data

Limitations:

- No resource modification permissions

---

## RBAC Design Principles

- Use groups rather than individual user assignments.
- Assign roles at the lowest practical scope.
- Follow least-privilege principles.
- Prefer built-in roles when possible.
- Use Azure RBAC over resource-specific permission models when available.

---

## Managed Identities

### Purpose

Managed Identities enable Azure resources to authenticate to Azure services without storing credentials.

Benefits:

- Eliminates stored passwords
- Eliminates client secrets
- Improves security posture
- Supports Zero Trust principles
- Reduces credential management overhead

---

### Authentication Model

Traditional:

```text
Application
    ↓
Username
Password
    ↓
Azure Service
```

Managed Identity:

```text
Application
    ↓
Managed Identity
    ↓
Azure Service
```

---

## Virtual Machine Managed Identity

Resource:

```text
vm-admin-prod-01
```

Identity Type:

```text
System Assigned Managed Identity
```

Status:

```text
Enabled
```

Purpose:

Allows the virtual machine to authenticate to Azure services without storing credentials locally.

---

## Managed Identity Integration

Resource:

```text
vm-admin-prod-01
```

Role:

```text
Key Vault Secrets User
```

Scope:

```text
kv-security-prod01
```

Purpose:

Allows the virtual machine to retrieve secrets from Azure Key Vault using its Managed Identity.

Design Principle:

Authentication is handled through Managed Identity while authorization is controlled through Azure RBAC.

---

## Identity Architecture

```text
Mike Zapata
     ↓
Azure-Admins
     ↓
Contributor
     ↓
Azure Subscription

Azure-Admins
     ↓
Key Vault Secrets Officer
     ↓
Azure Key Vault

vm-admin-prod-01
     ↓
Managed Identity
     ↓
Key Vault Secrets User
     ↓
Azure Key Vault
```

---

## Future Enhancements

### Privileged Identity Management (PIM)

Potential future implementation:

- Eligible assignments
- Just-in-time elevation
- Approval workflows

---

### Custom RBAC Roles

Potential future implementation:

- Storage Blob Reader
- Platform Operator
- Security Operations Role

---

## Design Principles

- Authenticate using Microsoft Entra ID.
- Authorize using Azure RBAC.
- Prefer group-based access management.
- Use Managed 