# Storage Design

## Overview

The storage layer of the Azure Secure Enterprise Platform provides secure storage for files, application data, testing workloads, and private connectivity demonstrations.

The design emphasizes:

- Private access
- Least privilege
- Network isolation
- Centralized monitoring
- Enterprise storage security practices

---

## Storage Account

### Name

```text
stsecureplatprod
```

### Resource Group

```text
gtg-spoke-prod
```

### Region

```text
East US
```

### Performance

```text
Standard
```

### Redundancy

```text
Locally Redundant Storage (LRS)
```

Reason:

Provides cost-effective storage redundancy suitable for learning and testing environments.

---

## Storage Purpose

The Storage Account supports:

- File storage
- Blob storage demonstrations
- Private Endpoint testing
- Managed Identity integration
- RBAC demonstrations
- Monitoring and diagnostics
- Future security investigations

---

## Storage Account Deployment

Storage Account:

```text
stsecureplatprod
```

Performance:

```text
Standard
```

Redundancy:

```text
Locally Redundant Storage (LRS)
```

Purpose:

Provides storage services for workload integration, RBAC demonstrations, Managed Identity authentication, and Private Endpoint testing.

---

## Blob Container

### Container Name

```text
project-files
```

### Access Level

```text
Private
```

No anonymous access is allowed.

---

### Purpose

Used for:

- Azure Storage testing
- Blob operations
- RBAC demonstrations
- Monitoring validation
- Future security investigations

---

## Uploaded Content

Example uploaded files include:

```text
Cover.pdf
DjangoUnchained.txt
wired-gradient-426-brain.gif
```

Purpose:

Generate storage activity and validate blob storage functionality.

---

## Private Endpoint

### Name

```text
pe-stsecureplatprod
```

### Target Resource

```text
stsecureplatprod
```

### Subresource

```text
Blob
```

### Virtual Network

```text
vnet-spoke-prod
```

### Subnet

```text
snet-private-endpoints
```

### Purpose

Provides private network connectivity between workload resources and Azure Storage without public Internet exposure.

---

## Storage Network Security

### Public Network Access

```text
Disabled
```

### Access Method

```text
Private Endpoint
```

Purpose:

Restricts storage access to private Azure networking paths and reduces Internet exposure.

---

## Storage Security Validation

Validation Result:

Public access to the Storage Account was blocked after public network access was disabled.

Observed Behavior:

Attempts to access blob data from outside the approved network path resulted in authorization failures.

Outcome:

Only private connectivity methods remain available through the configured Private Endpoint.

Security Benefit:

Reduces attack surface and prevents direct Internet access to storage resources.

---

## Monitoring Configuration

### Diagnostic Setting

```text
storage-to-law
```

### Destination

```text
law-monitoring-prod
```

### Log Categories

- Read Operations
- Write Operations
- Delete Operations

### Metrics

```text
AllMetrics
```

### Purpose

Provides centralized auditing and monitoring of storage activity.

---

## Storage Activity Testing

Test Activities Performed:

- Blob upload
- Blob download
- Blob deletion

Purpose:

Generate telemetry for Log Analytics ingestion and future KQL analysis.

---

## Current Storage Architecture

```text
vm-admin-prod-01
        │
        ▼
vnet-spoke-prod
        │
        ▼
snet-private-endpoints
        │
        ▼
pe-stsecureplatprod
        │
        ▼
stsecureplatprod
        │
        ▼
project-files
```

---

## Security Benefits

### Private Connectivity

All approved storage traffic uses private networking paths.

### Reduced Attack Surface

Public access has been disabled.

### Monitoring Enabled

Storage activity is forwarded to Log Analytics.

### Future Identity Integration

The architecture supports:

```text
Managed Identity
        ↓
RBAC
        ↓
Storage Account
```

without requiring storage keys.

---

## Future Enhancements

### Azure RBAC for Storage

Potential future roles:

```text
Storage Blob Data Reader
Storage Blob Data Contributor
```

Purpose:

Allow data access without using storage keys.

---

### Managed Identity Integration

Planned workflow:

```text
VM
 ↓
Managed Identity
 ↓
RBAC
 ↓
Storage Account
```

Purpose:

Eliminate storage access keys and support passwordless authentication.

---

### Private DNS Zone

Planned:

```text
privatelink.blob.core.windows.net
```

Purpose:

Provide automatic name resolution for Private Endpoint connectivity.

---

## Design Principles

- Data should remain private by default.
- Public exposure should be minimized.
- Private Endpoints are preferred over public access.
- Monitoring should be enabled for all critical resources.
- Authentication should move toward identity-based access rather than storage keys.
- Storage architecture should support future security operations and monitoring initiatives.