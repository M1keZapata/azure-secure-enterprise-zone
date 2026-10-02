# Networking Design

## Overview

The Azure Secure Enterprise Platform uses a hub-and-spoke network architecture to separate shared infrastructure services from workload resources.

The design emphasizes:

- Network segmentation
- Centralized security
- Scalability
- Private connectivity
- Enterprise networking practices

---

## Hub-and-Spoke Architecture

### Hub Network

Purpose:

Provides centralized networking services and shared infrastructure for the environment.

Shared Services Include:

- Azure Bastion (planned)
- Azure Firewall (planned)
- Administrative connectivity
- Future shared services

---

### Spoke Network

Purpose:

Hosts workloads and application resources.

Workload Resources Include:

- Virtual Machines
- Storage Accounts
- Private Endpoints

---

## Hub Network Deployment

### Virtual Network

Name:

```text
vnet-hub-prod
```

Resource Group:

```text
gtg-hub-prod
```

Address Space:

```text
10.0.0.0/16
```

---

### Subnets

| Subnet | Address Range |
|----------|----------------|
| snet-management | 10.0.1.0/24 |
| AzureBastionSubnet | 10.0.2.0/26 |
| AzureFirewallSubnet | 10.0.3.0/26 |

---

### Purpose

Provides centralized networking services for the Azure Secure Enterprise Platform.

---

## Spoke Network Deployment

### Virtual Network

Name:

```text
vnet-spoke-prod
```

Resource Group:

```text
gtg-spoke-prod
```

Address Space:

```text
10.1.0.0/16
```

---

### Subnets

| Subnet | Address Range |
|----------|----------------|
| snet-servers | 10.1.1.0/24 |
| snet-private-endpoints | 10.1.2.0/24 |

---

### Purpose

Hosts workloads, virtual machines, storage resources, and private service connectivity.

---

## VNet Peering

Connected Networks:

```text
vnet-hub-prod
↔
vnet-spoke-prod
```

Purpose:

Allows private communication between shared infrastructure services and workload resources.

Benefits:

- Centralized management
- Reduced network complexity
- Improved scalability
- Uses Microsoft's private backbone network

---

## Network Security Group

### NSG

Name:

```text
nsg-servers-prod
```

Resource Group:

```text
gtg-spoke-prod
```

Associated Subnet:

```text
snet-servers
```

Purpose:

Provides traffic filtering and security controls for server workloads hosted within the spoke network.

---

## NSG Rules

### allow-rdp-from-hub

Purpose:

Allows Remote Desktop traffic from the hub network to workloads hosted within the spoke network.

Configuration:

```text
Source: 10.0.0.0/16
Destination Port: 3389
Action: Allow
Priority: 100
```

Reason:

Supports future secure administrative connectivity from trusted internal networks.

---

## Private Endpoint Network

### Private Endpoint

Name:

```text
pe-stsecureplatprod
```

Target Resource:

```text
stsecureplatprod
```

Subresource:

```text
Blob
```

Virtual Network:

```text
vnet-spoke-prod
```

Subnet:

```text
snet-private-endpoints
```

Purpose:

Provides private connectivity between workload resources and Azure Storage.

---

## Network Security Principles

### Private Connectivity First

Public Internet access is minimized wherever possible.

Examples:

- Storage Account public access disabled
- Private Endpoint enabled
- No public VM access

---

### Least Privilege Networking

Traffic is explicitly allowed only where required.

Examples:

- Internal RDP access from Hub network
- Restricted workload access paths

---

### Segmentation

Workload resources are separated from shared infrastructure services.

Benefits:

- Reduced attack surface
- Easier management
- Improved scalability
- Clear security boundaries

---

## Current Network Topology

```text
Azure Subscription
│
├── vnet-hub-prod (10.0.0.0/16)
│   │
│   ├── snet-management
│   ├── AzureBastionSubnet
│   └── AzureFirewallSubnet
│
└── vnet-spoke-prod (10.1.0.0/16)
    │
    ├── snet-servers
    │    └── nsg-servers-prod
    │
    └── snet-private-endpoints
         │
         └── pe-stsecureplatprod
              │
              └── stsecureplatprod
```

---

## Future Enhancements

### Private DNS Zones

Planned:

```text
privatelink.blob.core.windows.net
```

Purpose:

Support DNS resolution for Private Endpoints.

---

### Azure Firewall

Planned Architecture Component.

Purpose:

Centralized network security and traffic inspection.

Deployment deferred to control project cost.

---

### Azure Bastion

Planned Architecture Component.

Purpose:

Secure administrative access to virtual machines without public IP addresses.

Deployment deferred to control project cost.

---

### Route Tables

Future implementation may include custom routing to support centralized traffic inspection and advanced network controls.

---

## Design Principles

- Shared services belong in the Hub network.
- Workloads belong in the Spoke network.
- Public exposure should be minimized.
- Private connectivity is preferred whenever possible.
- Security controls should be layered and centralized.
- Network architecture should support future growth without redesign.