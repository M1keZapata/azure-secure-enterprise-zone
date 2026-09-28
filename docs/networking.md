# Networking Design

## Hub-and-Spoke Architecture

This environment uses a hub-and-spoke topology.

### Hub Network

**Purpose**:
Provides centralized networking services for the Azure Secure Enterprise Platform.

- Shared services
- Azure Firewall
- Azure Bastion
- Future shared connectivity

**VNet Name**:
vnet-hub-prod

**Address Space**:
10.0.0.0/16

### Subnets
| Subnet | Address Range |
|----------|----------------|
| snet-management | 10.0.1.0/24 |
| AzureBastionSubnet | 10.0.2.0/26 |
| AzureFirewallSubnet | 10.0.3.0/26 |

---

### Spoke Network

**Purpose**:
Hosts workloads, virtual machines, and private service connectivity.

- Workloads
- Virtual machines
- Application services
- Private endpoints

**VNet Name**:
vnet-spoke-prod

**Address Space**:
10.1.0.0/16

### Subnets
| Subnet | Address Range |
|----------|----------------|
| snet-servers | 10.1.1.0/24 |
| snet-private-endpoints | 10.1.2.0/24 |




### Planned Connectivity

Hub VNet
↔
Spoke VNet

VNet Peering will be used to enable communication.

---

## Network Security Group

**Name**:
nsg-servers-prod

**Associated Subnet**:
snet-servers

**Purpose**:
Provides traffic filtering and security controls for server workloads hosted within the spoke network.

## NSG Rules

**Name**: allow-rdp-from-hub

**Purpose**:
Allows Remote Desktop traffic from the hub network to server workloads in the spoke network.


**Source**:
10.0.0.0/16


**Destination Port**: 
3389


**Action**: 
Allow


**Priority**: 
100

## Future Components

- Azure Firewall
- Azure Bastion
- Private Endpoints
