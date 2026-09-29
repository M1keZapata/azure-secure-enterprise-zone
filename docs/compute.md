# Compute Design

## Windows Administration Server

**Purpose**:

Provides a managed Windows server for administration, connectivity testing, monitoring, RBAC validation, and future managed identity demonstrations.

### Configuration

**Name**:

vm-admin-prod-01

**Resource Group**:

rg-spoke-prod

**Network**:

vnet-spoke-prod

**Subnet**:

snet-servers

---

### Security Design

- No public IP address
- Protected by Network Security Group
- Managed through Azure RBAC
- Future Azure Bastion support

### Future Enhancements

- Managed Identity
- Azure Monitor Agent
- Log Analytics Integration

### VM Sizing Decision

Selected Size:

B2s

Reason:

Provides sufficient resources for administration, testing, monitoring, and identity demonstrations while maintaining low operating costs.

### Cost Controls

- No Public IP
- Auto-Shutdown Enabled
- Single VM Deployment