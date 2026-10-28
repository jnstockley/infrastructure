# UniFi

[OpenTofu overview](../README.md)

Manages network configuration through the UniFi API, including networks,
wireless access, firewall policies, VPN, and port forwarding.

## Configuration map

| File | Responsibility |
| --- | --- |
| [provider.tofu](provider.tofu) | Provider requirements, HTTP backend, inputs, and API configuration. |
| [vlan.tofu](vlan.tofu) | Network and VLAN definitions. |
| [wifi.tofu](wifi.tofu) | Wireless LAN definitions and passphrase input use. |
| [ap_group.tofu](ap_group.tofu) | Lookup of the built-in All APs broadcast group. |
| [client_qos_rate.tofu](client_qos_rate.tofu) | Default user group used by both wireless LANs. |
| [client.tofu](client.tofu) | Existing photo-server, air-quality-monitor, and LG TV clients and DHCP reservations. |
| [firewall.tofu](firewall.tofu) | Firewall zones, existing-zone lookups, and policies. |
| [vpn.tofu](vpn.tofu) | VPN server configuration. |
| [port_forward.tofu](port_forward.tofu) | Port forwarding rules. |

Provider sources: `ubiquiti-community/unifi`. See
`provider.tofu` for version constraints and `.terraform.lock.hcl` for
selected dependency versions.

## Inputs and dependencies

Declared inputs, supplied as `TF_VAR_<name>` or approved local inputs:

- `unifi_api_key`
- `gitlab_username`
- `gitlab_access_token`
- `wifi_passphrase`

Also supply the backend variables described in the
[shared local workflow](../README.md#local-workflow). Remote-state inputs:
[adguard](../adguard/README.md).

Reads the AdGuard local suffix to construct the controller API URL. The
provider uses `unifi_api_key`; Wi-Fi credentials use `wifi_passphrase`.
CI establishes WireGuard before planning against the private controller.
The resource files describe desired configuration; this guide does not
assert that every resource is already deployed.

Both wireless LANs reference the default QoS resource and the All APs data
source. The built-in AP group is read-only and automatically follows AP
membership. The default QoS group's imported unlimited rates are left
computed because the provider rejects the controller's `-1` sentinel in
configuration.

Firewall client matches reference managed client MACs. Network/VPN DNS and
port forwarding reference the photo server's fixed IPv4 address. Client
network bindings are omitted to preserve the controller's existing unset
values and avoid a dependency cycle with network DNS settings. The
WireGuard IPv6 destination remains explicit: the client resource exposes
no IPv6 address. Subnets, DHCP ranges, public DNS servers, and ports remain
configuration values.

Review network/VLAN identifiers, zone memberships, policy direction,
allowed ports, VPN routes, and forwarding destinations together. A
firewall or network change can remove the path used to manage the
controller. Keep an independent management/recovery path for authorized
rollouts, then verify client connectivity, DNS, Wi-Fi, and affected flows.

## Validation and maintenance

From this directory, after backend and credential provisioning:

```bash
bash ../init.sh
tofu validate
tofu plan -out=tfplan
```

Review the plan before an authorized apply. Follow the
[shared workflow and CI caveats](../README.md) for state access and rollout.

The import blocks use controller IDs for QoS groups and MAC addresses for
clients. On a state where these four objects are not yet managed, the
adoption plan should show four imports with no additions, changes, or
deletions. Import blocks can remain after adoption; subsequent plans skip
objects already present in state. The All APs lookup needs no import.
Client deletion uses the provider's default forget behavior; review any
future destroy plan before removing a managed reservation.

**Maintenance:** review this README with every change in this directory.
Update the resource map, inputs, dependencies, operational notes, and any
affected state consumers or overview diagram in the same change. Follow
[the required documentation checklist](../../docs/documentation.md).
