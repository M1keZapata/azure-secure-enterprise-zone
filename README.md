![Azure hub-and-spoke architecture](docs/azure-architecture.svg)

# Azure Secure Enterprise Zone
Hands-on Azure cloud platform project covering hub-and-spoke networking, Entra ID, Defender for Cloud, Sentinel, Terraform, and planned GitHub Actions automation.

## Overview

Azure Secure Enterprise Zone is a hands-on cloud engineering and security project designed to simulate a real-world enterprise Azure environment.

The goal is to demonstrate practical skills across `networking`, `identity`, `security`, `governance`, `monitoring`, `infrastructure as code`, and `DevOps automation`. This repository is a technical portfolio and reference architecture; planned scope is not a claim of completed implementation or production readiness.

---

## Architecture Goals

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

Project resource groups are in East US and use the `gtg-<function>-prod` naming convention.

| Resource Group | Purpose |
|---|---|
| `gtg-hub-prod` | Central networking and connectivity resources |
| `gtg-spoke-prod` | Application, compute, and workload resources |
| `gtg-security-prod` | Security services and supporting resources |
| `gtg-monitoring-prod` | Centralized monitoring and logging resources |

---

## Project Roadmap

Snapshot: 2026-10-21. Checked items record completion of the named implementation or review task, not resolution of every audit finding or successful end-to-end testing. Evidence comes from owner-supplied assessments, Azure portal screenshots, and explicit owner confirmation. No direct Azure API verification was performed during this documentation update.

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
- [ ] Deploy Azure Bastion — deferred for cost; `AzureBastionSubnet` is prepared at `10.0.2.0/26`, but the service is not deployed.

### Phase 3: Identity

- [x] Configure Microsoft Entra ID groups
- [x] Implement role-based access control
- [ ] Configure managed identities — task completion not verified.

### Phase 4: Compute

- [x] Deploy Windows Server virtual machine
- [ ] Secure administrative access — in progress; private addressing and subnet NSG confirmed, but hub-only RDP restriction and a working management path are not validated.
- [ ] Configure monitoring extensions — not started; portal lists zero extensions, with a warning about unavailable details while the VM is stopped.

### Phase 5: Storage

- [x] Deploy storage account
- [x] Configure private endpoints — reviewed Blob endpoint configuration; client-side tests deferred.
- [x] Disable public access — public network access disabled; separate anonymous Blob access setting not reviewed.

### Phase 6: Security

- [x] Deploy Azure Key Vault
- [x] Enable Microsoft Defender for Cloud — foundational posture assessment confirmed, not full workload protection.
- [x] Review Secure Score — baseline reviewed; recommendations not all remediated.

### Phase 7: Monitoring

- [x] Create Log Analytics workspace
- [x] Configure Azure Monitor — observed diagnostic settings; comprehensive coverage and ingestion not fully validated.
- [x] Build KQL queries
- [x] Create alerts — enabled rule confirmed; firing and notification delivery not tested.

### Phase 8: Security Operations

- [x] Enable Microsoft Sentinel
- [ ] Create detection rules — completion unverified. Sentinel overview displays one enabled analytics rule, but its identity, logic, and origin were not inspected. Owner reports no Defender custom detections created.
- [ ] Generate test incidents — owner confirms not completed.

### Phase 9: Infrastructure as Code

- [ ] Build Terraform modules
- [x] Deploy core infrastructure — owner confirms Terraform deployment; code/state/apply evidence not independently reviewed in this audit.
- [ ] Configure remote state

### Phase 10: DevOps

- [ ] Configure GitHub Actions
- [ ] Automate Terraform formatting and validation
- [ ] Automate Terraform planning
- [ ] Automate approved Terraform deployments

---

## Current Status

Of 35 roadmap tasks: 23 complete, 1 in progress, 1 deferred for cost, and 10 not started or unverified.

| Phase | Complete / Total | Remaining status |
|---|---|---|
| Governance | 4 / 4 | None |
| Networking | 4 / 5 | Bastion deferred for cost |
| Identity | 2 / 3 | Managed-identity task unverified |
| Compute | 1 / 3 | Administrative access in progress; monitoring extensions not started |
| Storage | 3 / 3 | Client-side validation deferred separately |
| Security | 3 / 3 | Hardening and workload-protection gaps recorded separately |
| Monitoring | 4 / 4 | Coverage, query quality, and notification validation gaps recorded separately |
| Security Operations | 1 / 3 | Detection-rule completion unverified; test incidents not generated |
| Infrastructure as Code | 1 / 3 | Modules and remote state not started |
| DevOps | 0 / 4 | All tasks not started |

<!--
### Recorded Evidence

- Governance: resource groups `gtg-hub-prod`, `gtg-spoke-prod`, `gtg-security-prod`, and `gtg-monitoring-prod`; resource-group tags `CostCenter`, `Environment`, `ManagedBy`, `Owner`, and `Project`; subscription policy requiring the `Environment` tag on resource groups with enforcement enabled, per earlier owner-supplied assessment.
- Networking: hub `vnet-hub-prod` (`10.0.0.0/16`), spoke `vnet-spoke-prod` (`10.1.0.0/16`), and connected bidirectional peering per earlier assessment. Hub subnets include `snet-management` (`10.0.1.0/24`), `AzureBastionSubnet` (`10.0.2.0/26`), and `AzureFirewallSubnet` (`10.0.3.0/26`). Prepared subnets do not prove Bastion or Firewall deployment.
- Network security: `nsg-servers-prod` is attached to `snet-servers`. Rule `allow-rdp-from-hub` allows TCP/3389 from `10.0.0.0/16` at priority 100. Default `AllowVnetInBound` at priority 65000 still allows all ports/protocols for matching VirtualNetwork traffic; the custom allow alone does not enforce hub-only RDP. This corrects earlier README wording.
- Identity: `Azure-Admins` has subscription Contributor; the everyday lab account is its sole reviewed direct member and also has direct permanent subscription Owner. `Azure-Readers` has eligible time-bound Reader, zero members, and one owner. `Azure-Security` has eligible time-bound Security Reader; zero members and sole ownership were owner-reported. Group ownership is distinct from membership.
- Authentication: a sampled Azure Resource Manager sign-in shows Security Defaults Enabled, Success, and Require multifactor authentication Satisfied. Earlier details show Previously satisfied, not proof of a fresh challenge or the original authentication method.
- Compute: `vm-admin-prod-01` in `gtg-spoke-prod`, East US; Windows Server image publisher `MicrosoftWindowsServer`, offer `WindowsServer`; exact version not visible. Generation V2, x64, Standard F1als v7, 1 vCPU, 2 GiB RAM; stopped/deallocated; private IP `10.1.1.4` in `vnet-spoke-prod/snet-servers`; no public IP displayed.
- Storage: StorageV2 account `stsecureplatprod` in `gtg-spoke-prod`, East US; public network access Disabled. Blob private endpoint `pe-stsecureplatprod` is Succeeded and Approved in `vnet-spoke-prod/snet-private-endpoints`, private IP `10.1.2.4`.
- Private DNS: endpoint associated with `privatelink.blob.core.windows.net`, zone group `default`; displayed private hostname maps to `10.1.2.4`. Zone link to `vnet-spoke-prod` is Completed. Client-side resolution and authorized Blob operations were deferred, not passed.
- Key Vault: `kv-security-prod01` in `gtg-security-prod`, East US; Standard tier; Azure RBAC permission model; soft-delete Enabled; purge protection Disabled; public network access Enabled from all networks; no private endpoint configured. Deployment is complete, hardening is not asserted complete.
- Defender for Cloud: one subscription, 21 assessed resources; Secure Score 46%; 24 recommendations (1 high, 0 medium, 23 low); workload-protection coverage displayed as 0%. Microsoft cloud security benchmark shows 47 of 63 controls passed, separately from Secure Score and not a certification. Dashboard warns of potentially limited visibility; zero alerts/attack paths do not establish absence of threats.
- Log Analytics: `law-monitoring-prod` in `gtg-monitoring-prod`, East US; Active; Pay-as-you-go; operational issues OK.
- Azure Monitor: diagnostics inventory shows Enabled for `stsecureplatprod` parent resource, `kv-security-prod01`, and `law-monitoring-prod`. Displayed setting `gtg-AllAzure` selects `allLogs` and `AllMetrics` and targets `law-monitoring-prod`; its source resource is not identified in the screenshot. Storage child-service diagnostics and project NSG/NIC diagnostics are shown Disabled.
- KQL: workspace query history shows executed AzureActivity exploration with nonzero results on October 2–3, 2026. Historical availability is demonstrated, not current ingestion. The displayed `distinct OperationNameValue` followed by grouped `count()` counts each unique name once; remove `distinct` to count event frequency. A historical `AZKVAuditLogs | take 5` returned zero rows, not proof of Key Vault ingestion.
- Alerts: `StorageAccountsWatchRule` is Enabled; Activity log signal, `Category=Administrative`, severity `4 - Verbose`, storage-account target type. Full scope is truncated; action group, firing, and delivery were not reviewed. List was filtered to Enabled.
- Sentinel: enabled for project workspace `law-monitoring-prod`, separate from `GooderThanLAW`; overview shows 2 active connectors, 0 unhealthy connectors, one enabled analytics rule, and no incidents/automation rules found in the displayed view. Rule details and historical incident completeness are not established.
- Terraform: owner explicitly confirms core-infrastructure deployment using Terraform. This audit did not independently inspect code, state, plan/apply output, or exact deployed scope. A `ManagedBy: Terraform` tag alone is not deployment proof. Modules, remote state, and DevOps automation are not asserted complete.

-->

### Deferred for Cost

- Deploy Azure Bastion: prepared subnet only; service not deployed.

<!--
### Next Work / Verification

- Complete secure administrative access; inspect default NSG allowances and validate the intended management path before changing access.
- Configure monitoring extensions and verify collection where required.
- Identify the existing Sentinel analytics rule before claiming detection-rule creation; generate controlled test incidents when ready.
- Verify the managed-identity task separately from service-created identities.
- Complete Terraform modules, remote state, and DevOps automation.
- Revisit storage client-side DNS/data tests, diagnostic coverage, notification delivery, and Key Vault hardening.
-->

<!--
### Progress Basis and Notion Alignment

Aligned to the task statuses agreed during the 2026-10-21 roadmap review and recorded in Notion. Completion of a deployment/configuration/review task is separate from end-to-end validation or remediation. Governance/networking include earlier owner-supplied assessments; later findings use portal screenshots; Terraform deployment is owner-confirmed. No live Azure API verification occurred during this README update. Synchronization remains manual.
-->

---

## Things I Would Correct Next Time

Lessons learned and improvements for a future iteration of this project.

- **Build with Terraform from day one.** Resources were first created by hand in the portal. Starting with Infrastructure as Code would make the environment repeatable, reviewable, and easier to rebuild or tear down. Core deployment is now owner-confirmed as Terraform-based; modularization and remote state remain unfinished.
- **Set a budget and cost alerts before deploying anything.** Azure Bastion was deferred to control cost. A budget with alert thresholds up front would make cost decisions planned rather than reactive.
- **Decide on remote-access design earlier.** The Bastion subnet exists, but the Bastion service does not. Choosing the access method at the design stage avoids leaving a gap in secure administration.
- **Apply network security groups to every subnet that supports them.** The earlier assessment recorded no NSG or route table on the hub management subnet. Review service-specific subnet requirements before adding controls.
- **Define and test traffic flow before building.** Route tables and firewall rules should be planned alongside the subnets so that prepared subnets are not left idle. Review default NSG rules: a narrow allow does not implicitly deny other sources.
- **Collect evidence as work is completed.** Export inventories and save dated screenshots, configuration outputs, and deployment records rather than reconstructing proof afterward.
- **Keep documentation and tracking in sync.** The README checklist and project tracker were updated manually and drifted apart. Update them in the same sitting as each change.
- **Finish identity before compute.** Group-based RBAC exists, but the everyday lab account retains permanent Owner. Implementation is not proof of least-privilege operation.
- **Separate planned scope from deployed reality.** Distinguish task completion, owner confirmation, observed configuration, successful tests, and unresolved findings.

---

## Technologies Used

**Cloud and networking**

![Microsoft Azure](https://img.shields.io/badge/Microsoft_Azure-0078D4?style=flat&logo=microsoftazure&logoColor=white)
![Virtual Networks](https://img.shields.io/badge/Azure_VNet-0078D4?style=flat)
![VNet Peering](https://img.shields.io/badge/VNet_Peering-0078D4?style=flat)
![NSG](https://img.shields.io/badge/Network_Security_Groups-0078D4?style=flat)

**Identity and security**

![Microsoft Entra ID](https://img.shields.io/badge/Microsoft_Entra_ID-0078D4?style=flat)
![Defender for Cloud](https://img.shields.io/badge/Defender_for_Cloud-0078D4?style=flat)
![Microsoft Sentinel](https://img.shields.io/badge/Microsoft_Sentinel-2088FF?style=flat)

**Monitoring**

![Azure Monitor](https://img.shields.io/badge/Azure_Monitor-0078D4?style=flat)
![Log Analytics](https://img.shields.io/badge/Log_Analytics-0078D4?style=flat)
![KQL](https://img.shields.io/badge/KQL-0078D4?style=flat)

**Infrastructure as Code and DevOps**

![Terraform](https://img.shields.io/badge/Terraform-844FBA?style=flat&logo=terraform&logoColor=white)
![GitHub Actions](https://img.shields.io/badge/GitHub_Actions-2088FF?style=flat&logo=githubactions&logoColor=white)
![GitHub](https://img.shields.io/badge/GitHub-181717?style=flat&logo=github&logoColor=white)

This list describes project scope, not confirmation that every service or automation is implemented. GitHub Actions remains planned.
