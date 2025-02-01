# Proxmox Setup

## Install Tofu on local machine
- Run:
```bash 
 ./tf/install.sh
 ```

### Common Errors
#### Failed to obtain the latest release from the GitHub API. Try passing --opentofu-version to specify a version.
1. Make sure `wget` is NOT installed using `brew`
2. Ensure GH installed
3. Ensure GH Auth return logged in state
    - If not, run `gh auth login`
4. Ensure `GITHUB_TOKEN` is set in environment variables
    - If not, run `gh auth token` and set the token in environment variables in `nano ~/.zshrc` or `nano ~/.bashrc`

## Setup Terraform
### Create Role
- Name: `Terraform`
- Privileges: 
```
Datastore.AllocateSpace
Datastore.AllocateTemplate
Datastore.Audit
Pool.Allocate
Sys.Audit
Sys.Console
Sys.Modify
VM.Allocate
VM.Audit
VM.Clone
VM.Config.CDROM
VM.Config.Cloudinit
VM.Config.CPU
VM.Config.Disk
VM.Config.HWType
VM.Config.Memory
VM.Config.Network
VM.Config.Options
VM.Migrate
VM.Monitor
VM.PowerMgmt
SDN.Use
```

### Create User
- Name: `TerraformUser`

### Add Role to User
- Go to Permissions
- Assign Role `Terraform` to User `TerraformUser` with path `/`

### Create API User
- User: `TerraformUser`
- TokenId: `terraform`

### Setup Tofu
- Save `TokenId` as `proxmox_api_token_id` in `credentials.auto.tfvars`
- Save `Secret` as `proxmox_api_token_secret` in `credentials.auto.tfvars`

## Download Debian 12 ISO

## Download Windows 11 ISO

## Download Hassio Image