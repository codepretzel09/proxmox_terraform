#######################################
###      Create lxc container       ###
#######################################

resource "proxmox_lxc" "basic" {
  target_node  = "pve"
  hostname     = "lxc-basic"
  ostemplate   = "local:vztmpl/ubuntu-21.04-standard_21.04-1_amd64.tar.gz"
  password     = "BasicLXCContainer"
  ostype      = "ubuntu"
  unprivileged = true
  onboot       = true
  ssh_public_keys = <<-EOT
  ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBLvlul5tAWA1V8gIFwfHUxpTPJAg9m1TwkxlSXAQ5K0Xq+tQpnrlTJNoERd8+6ePXWESY90M4hWNNYYdzK2DicA= root@redlab1

 EOT

  // Terraform will crash without rootfs defined
  rootfs {
    storage = "local-zfs"
    size    = "8G"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "dhcp"
  }

    features {
    fuse    = true
    nesting = true
    mount   = "nfs;cifs"
  }

    mountpoint {
    key     = "1"
    slot    = 1
    storage = "/media/Photos"
    volume  = "/media/Photos"
    mp      = "/mnt/media/Photos"
    size    = "32G"
  }

  #   mountpoint {
  #   slot    = "2"
  #   key     = "2"
  #   storage = "/kb/nxtcld"
  #   mp      = "/mnt/container/nfs"
  #   size    = "5G"
  # }
}