![Azure hub-and-spoke architecture](docs/azure-architecture.svg)

# Azure Secure Enterprise Zone
End-to-end Azure cloud platform showcasing hub-and-spoke networking, Entra ID, Defender for Cloud, Sentinel, Terraform, GitHub Actions, and enterprise security architecture.

## Overview

Azure Secure Enterprise Zone is a hands-on cloud engineering and security project designed to simulate a real-world enterprise Azure environment.

The goal of this project is to demonstrate practical skills across multiple Azure disciplines, including `networking`, `identity`, `security`, `governance`, `monitoring`, `infrastructure as code`, and `DevOps automation`.

This repository serves as both a technical portfolio project and a reference architecture for Azure administration, cloud engineering, and security engineering roles.

---

## Architecture Goals

The platform is designed around the following principles:

- Zero Trust security model
- Least-privilege access
- Infrastructure as Code
- Secure remote administration
- Private service communication
- Centralized monitoring and logging
- Automated deployments
- Enterprise-grade networking

---

## Resource Group Structure

Actual resource groups are in East US and use the `gtg-<function>-prod` naming convention.

| Resource Group | Purpose |
|---|---|
| `gtg-hub-prod` | Central networking and connectivity resources |
| `gtg-spoke-prod` | Application, compute, and workload resources |
| `gtg-security-prod` | Security services and supporting resources |
| `gtg-monitoring-prod` | Centralized monitoring and logging resources |

---

## Project Roadmap

Checked items are recorded complete in the latest user-supplied project assessment. Unchecked items are not confirmed complete; Bastion is intentionally deferred as noted below.

### Phase 1: Governance

- [x] Create resource groups
- [x] Define naming standards
- [x] Implement resource tags
- [x] Configure Azure policies

### Phase 2: Networking

- [x] Deploy hub virtual network
- [x] Deploy spoke virtual network
- [x] Configure VNet peering
- [x] Implement network security groups
- [ ] Deploy Azure Bastion — deferred for cost; `AzureBastionSubnet` is prepared at `10.0.2.0/26`, but the Bastion service is not deployed.

### Phase 3: Identity

- [ ] Configure Microsoft Entra ID groups
- [ ] Implement role-based access control
- [ ] Configure managed identities

### Phase 4: Compute

- [ ] Deploy Windows Server virtual machine
- [ ] Secure administrative access
- [ ] Configure monitoring extensions

### Phase 5: Storage

- [ ] Deploy storage account
- [ ] Configure private endpoints
- [ ] Disable public access

### Phase 6: Security

- [ ] Deploy Azure Key Vault
- [ ] Enable Microsoft Defender for Cloud
- [ ] Review Secure Score

### Phase 7: Monitoring

- [ ] Create Log Analytics workspace
- [ ] Configure Azure Monitor
- [ ] Build KQL queries
- [ ] Create alerts

### Phase 8: Security Operations

- [ ] Enable Microsoft Sentinel
- [ ] Create detection rules
- [ ] Generate test incidents

### Phase 9: Infrastructure as Code

- [ ] Build Terraform modules
- [ ] Deploy core infrastructure
- [ ] Configure remote state

### Phase 10: DevOps

- [ ] Configure GitHub Actions
- [ ] Automate Terraform formatting and validation
- [ ] Automate Terraform planning
- [ ] Automate approved Terraform deployments

---

## Current Status

Progress snapshot: 2026-10-21. Of 35 roadmap tasks, 8 are complete, 1 is intentionally deferred for cost, and 26 across Phases 3–10 remain unverified. No additional task is asserted to be in progress.

### Completed

- [x] Create resource groups
- [x] Define naming standards
- [x] Implement resource tags
- [x] Configure Azure policies
- [x] Deploy hub virtual network
- [x] Deploy spoke virtual network
- [x] Configure VNet peering
- [x] Implement network security groups

### Recorded Evidence

- Resource groups: `gtg-hub-prod`, `gtg-spoke-prod`, `gtg-security-prod`, and `gtg-monitoring-prod` in East US.
- Resource group tags: `CostCenter`, `Environment`, `ManagedBy`, `Owner`, and `Project` applied consistently.
- Governance: a subscription-level policy requires the `Environment` tag on resource groups, with enforcement enabled.
- Hub: `vnet-hub-prod` in `gtg-hub-prod`, address space `10.0.0.0/16`.
- Spoke: `vnet-spoke-prod` in `gtg-spoke-prod`, address space `10.1.0.0/16`.
- Peering: `hub-to-spoke` and `spoke-to-hub` connected and fully synchronized.
- Network security: `nsg-servers-prod` associated with `snet-servers`, allowing TCP/3389 only from the hub range `10.0.0.0/16`.
- Hub subnets: `snet-management` (`10.0.1.0/24`), `AzureBastionSubnet` (`10.0.2.0/26`), and `AzureFirewallSubnet` (`10.0.3.0/26`).
- Spoke subnets include `snet-servers` and `snet-private-endpoints`.

Prepared subnets do not establish deployment of Azure Bastion, Azure Firewall, or private endpoints.

### Deferred for Cost

- [ ] Deploy Azure Bastion. Its subnet is prepared, but the service itself is not deployed. This is an intentional deferral, not a completed roadmap task.

<!--
### Next Work / Verification

- Verify management VM / jump-host security, or proceed to Phase 3: Identity.
- Validate remaining identity, compute, storage, security, monitoring, Sentinel, Terraform, and GitHub Actions work before marking it complete.
-->

<!--
### Progress Basis and Notion Alignment

This snapshot reflects the newer project assessment screenshot supplied by the project owner, superseding the older README checklist. No live Azure verification was performed during this documentation update. Notion tracks the matching roadmap; synchronization is manual, not automatic. Tracker setup is separate from Azure deployment completion.
-->

---

## Things I Would Correct Next Time

Lessons learned and improvements for a future iteration of this project.

- **Build with Terraform from day one.** Resources were first created by hand in the portal. Starting with Infrastructure as Code would make the environment repeatable, reviewable, and easier to rebuild or tear down.
- **Set a budget and cost alerts before deploying anything.** Azure Bastion was deferred to control cost. A budget with alert thresholds up front would make cost decisions planned rather than reactive.
- **Decide on remote-access design earlier.** The Bastion subnet exists, but the Bastion service does not. Choosing the access method (Bastion, just-in-time access, or a restricted jump host) at the design stage avoids leaving a gap in secure administration.
- **Apply network security groups to every subnet that supports them.** The hub management subnet currently has no NSG or route table attached. Note that `AzureFirewallSubnet` does not support an NSG, and `AzureBastionSubnet` requires specific rules if one is attached.
- **Define and test traffic flow before building.** Route tables and firewall rules should be planned alongside the subnets so that prepared subnets are not left idle.
- **Collect evidence as work is completed.** Export resource inventories (for example with Azure CLI) and save dated screenshots, rather than reconstructing proof afterward.
- **Keep documentation and tracking in sync.** The README checklist and the project tracker were updated manually and drifted apart. Pick one source of truth and update it in the same sitting as each change.
- **Finish identity before compute.** Entra ID groups and role-based access control should exist before workloads are deployed, so that access is least-privilege from the start.
- **Separate planned scope from deployed reality.** Mark each service as planned, deployed, or verified so that readers can see exactly what exists.

---

## Technologies Used

The project scope includes Azure networking, Microsoft Entra ID, Microsoft Defender for Cloud, Microsoft Sentinel, Azure Monitor, Log Analytics, KQL, Terraform, and GitHub Actions. Inclusion here describes project scope, not confirmation that every service is deployed.
