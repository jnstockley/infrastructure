# Proxmox

[OpenTofu overview](../README.md)

Manages QEMU virtual machines through the Proxmox API, using the Telmate
provider. This root covers VM configuration rather than all host setup.

## Configuration map

| File | Responsibility |
| --- | --- |
| [provider.tofu](provider.tofu) | Provider requirements, HTTP backend, inputs, and API configuration. |
| [debian-12.tofu](debian-12.tofu) | Debian VM definition. |
| [hassio.tofu](hassio.tofu) | Home Assistant OS VM definition. |
| [win-11.tofu](win-11.tofu) | Windows 11 VM definition. |

Provider sources: `telmate/proxmox`. See
`provider.tofu` for version constraints and `.terraform.lock.hcl` for
selected dependency versions.

## Inputs and dependencies

Declared inputs, supplied as `TF_VAR_<name>` or approved local inputs:

- `proxmox_api_user`
- `proxmox_api_password`
- `gitlab_username`
- `gitlab_access_token`

Also supply the backend variables described in the
[shared local workflow](../README.md#local-workflow). Remote-state inputs:
[adguard](../adguard/README.md).

Reads the local DNS suffix from AdGuard state to construct API access.
The API must be reachable from the planning machine; CI establishes a
WireGuard connection before planning. Inspect VM identifiers, target nodes,
boot media, disks, passthrough, and network settings before applying.
Replacement or deletion can affect persistent guest data.

[SETUP.md](SETUP.md) contains historical installation and permission notes,
including token inputs that differ from the username/password variables
currently declared by the provider. Follow `provider.tofu` for current
inputs. [HASSIO-SETUP.md](HASSIO-SETUP.md) links to an image setup reference.
Verify guest startup and network access after an authorized VM change;
formatting and validation cannot verify a bootable guest.

## Validation and maintenance

From this directory, after backend and credential provisioning:

```bash
bash ../init.sh
tofu validate
tofu plan -out=tfplan
```

Review the plan before an authorized apply. Follow the
[shared workflow and CI caveats](../README.md) for state access and rollout.

**Maintenance:** review this README with every change in this directory.
Update the resource map, inputs, dependencies, operational notes, and any
affected state consumers or overview diagram in the same change. Follow
[the required documentation checklist](../../docs/documentation.md).
