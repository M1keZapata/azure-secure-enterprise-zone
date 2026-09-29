# Storage Design

## Storage Account

**Purpose**:
Provides secure storage for application data, files, future testing workloads, and private endpoint demonstrations.

### Planned Configuration

**Storage Account**:
stsecureplatprod

**Resource Group**:
rg-spoke-prod

**Performance**:
Standard

**Redundancy**:
Locally Redundant Storage (LRS)

## Private Endpoint

**Name**: 
pe-stsecureplatprod

**Target Resource**: 
stsecureplatprod

**Subresource**: 
Blob

**Virtual Network**: 
vnet-spoke-prod

**Subnet**:
snet-private-endpoints

**Purpose**:
Provides private network connectivity between workload resources and Azure Storage without requiring public network access.

### Security Requirements

- Public network access disabled
- Private endpoint enabled
- Azure RBAC authentication preferred
- Diagnostic logging enabled

## Design Goals

- Secure data access
- Least privilege access
- Private network connectivity
- Enterprise storage architecture