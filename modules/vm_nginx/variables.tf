# VM SETTINGS
variable "vmname" {
  description = "name of the VM to deploy"
  default     = "debian"
}

variable "node" {
  description = "proxmox node on which to deploy the VM"
  default     = "nuc10"
}

variable "vcpu" {
  description = "How many virtual cpus allocated to the VM"
  default     = 1
}

variable "memory" {
  description = "RAM allocated to the VM in MB - 2GB = 2048, 4GB = 4096, 8GB = 8192, etc."
  default     = "2048"
}

variable "tamplate_vm_name" {
  description = "name of the template to clone from"
  default     = "debian10-template"
}

variable "onboot" {
  description = "whether or not to automatically start the VM with the proxmox host"
  default     = "true"
}

variable "ip" {
  description = "set VM ip address here (192.168.1.51,52,53,54 = 192.168.1.5"
  default     = "192.168.1.5"
}

variable "gateway" {
  description = "set VM gateway address here"
  default     = "192.168.1.1"
}

variable "ssh_key" {
  default = "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBLvlul5tAWA1V8gIFwfHUxpTPJAg9m1TwkxlSXAQ5K0Xq+tQpnrlTJNoERd8+6ePXWESY90M4hWNNYYdzK2DicA= root@redlab1"
}

variable "ssh_user" {
    default = "ubuntu"
}

variable "install_nginx_script" {
    type = list
}

