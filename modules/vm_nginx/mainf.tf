resource "proxmox_vm_qemu" "proxmox_vm_master" {
  count = 2
  vmid        = "${count.index + 420}"
  desc        = "Created by Terraform"
  name        = "${var.vmname}-${count.index + 1}"
  target_node = var.node
  clone       = var.tamplate_vm_name
  os_type     = "cloud-init"
  # agent       = 1
  memory      = var.memory
  cores       = var.vcpu
  scsihw = "virtio-scsi-pci"
  #  sockets     = 
  onboot = var.onboot
  #  hagroup     =
  #  pool        =
  network {
    model  = "virtio"
    bridge = "vmbr0"
  }

  # cloud-init
   ipconfig0 = "ip=${var.ip}${count.index + 1}/24,gw=${var.gateway}"
   sshkeys = <<EOF
  ${var.ssh_key}
  EOF

# if using a template the first disk block must match the template disk size

# Root Volume 
  disk {
    size     = "31948M"
    type     = "scsi"
    storage  = "fast"
    iothread = 1
  }

# Second Volume
  # disk {
  #   size     = "10G"
  #   type     = "scsi"
  #   storage  = "fast"
  #   iothread = 1
  # }

# Post creation actions
  provisioner "remote-exec" {
    inline = var.install_nginx_script
    # inline = concat(var.extend_root_disk_script, var.firewalld_k8s_config)
    connection {
      type        = "ssh"
      user        = var.ssh_user
      # password    = var.ssh_password
      private_key = file("~/.ssh/id_ecdsa")
      host        = "${var.ip}${count.index + 1}"
    }
  }
}




















#######################################
###      Create lxc container       ###
#######################################

# resource "proxmox_lxc" "basic" {
#   target_node  = "pve"
#   hostname     = "lxc-basic"
#   ostemplate   = "local:vztmpl/ubuntu-21.04-standard_21.04-1_amd64.tar.gz"
#   password     = "BasicLXCContainer"
#   unprivileged = true
#   onboot       = true
#   ssh_public_keys = <<-EOT
#   ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBLvlul5tAWA1V8gIFwfHUxpTPJAg9m1TwkxlSXAQ5K0Xq+tQpnrlTJNoERd8+6ePXWESY90M4hWNNYYdzK2DicA= root@redlab1

#  EOT

#   // Terraform will crash without rootfs defined
#   rootfs {
#     storage = "local-zfs"
#     size    = "8G"
#   }

#   network {
#     name   = "eth0"
#     bridge = "vmbr0"
#     ip     = "dhcp"
#   }
# }