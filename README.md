# VMware vSphere Terraform Deployment

This repository contains files for deploying virtual machines on a VMware vSphere environment. The deployment is customizable using variables that you can define in your `defaults.tfvars` file or pass them through the command line when running Terraform commands.

## Prerequisites

- Terraform installed on your local machine
- VMware vSphere environment with necessary permissions to create resources
- VMware vSphere provider for Terraform (automatically installed when running `terraform init`)

## Configuration

1. Clone this repository or download the Terraform configuration files.
2. Create a `.tfvars` file in the same directory as the Terraform configuration files, or update the provided `defaults.tfvars` file with your custom values.
3. Set the required variables in your `.tfvars` file or pass them as command line arguments when running Terraform commands. The required variables for `defaults.tfvars` are:

   - `vsphere_user`: The vSphere user with necessary permissions to create resources
   - `vsphere_password`: The password for the vSphere user
   - `admin_user`: The username for the virtual machine's OS
   - `admin_password`: The password for the virtual machine's OS user
   - `vm_name` : The hostname of the virtual machine
   - `ip_addresses` : The IPv4 address of the virtual machine. Leave blank if using DHCP.

## Deployment

1. Open a terminal and navigate to the directory containing the Terraform configuration files.
2. Run `terraform init` to initialize the Terraform working directory and download the necessary provider plugins.
3. Run the following command to review the planned changes before applying them:

```shell
terraform plan
-var-file = <defaults.tfvars>
-var "vsphere_user = <vsphere_user>"
-var "vsphere_password = <vsphere_password>""
-var "admin_user = <admin_username>"
-var "admin_password = <password>"
-var "vm_name = <vm_name>"
-var "ip_addresses = [<list of ip addresses>]"
```

4. If the plan output looks correct and you want to proceed with the deployment, run the following command to apply the changes:

```shell
terraform apply
-var-file = <defaults.tfvars>
-var "vsphere_user = <vsphere_user>"
-var "vsphere_password = <vsphere_password>"
-var "admin_user = <admin_user>"
-var "admin_password = <admin_password>"
-var "vm_name = <vm_name>"
-var "ip_addresses = [<list of ip addresses>]"
```

5. Once the deployment is complete, you can verify the created resources in your vSphere environment.

## Cleanup

To destroy the resources created by this Terraform configuration, run the following command:

```shell
terraform destroy
-var-file = <defaults.tfvars>
-var "vsphere_user = <vsphere_user>"
-var "vsphere_password = <vsphere_password>"
-var "admin_user = <admin_user>"
-var "admin_password = <admin_password>"
-var "vm_name = <vm_name>"
-var "ip_addresses = [<list of ip addresses>]"
```

**Note:** Destroying the resources will delete the virtual machines and associated resources from your vSphere environment. Be cautious when running this command.
