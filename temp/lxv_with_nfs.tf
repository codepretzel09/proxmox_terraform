resource "proxmox_lxc" "advanced_features" {
  target_node  = "pve"
  hostname     = "lxc-advanced-features"
  ostemplate   = "local:vztmpl/ubuntu-21.04-standard_21.04-1_amd64.tar.gz"
  unprivileged = true

  ssh_public_keys = <<-EOT
    ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBLvlul5tAWA1V8gIFwfHUxpTPJAg9m1TwkxlSXAQ5K0Xq+tQpnrlTJNoERd8+6ePXWESY90M4hWNNYYdzK2DicA= root@redlab1

  EOT

  features {
    fuse    = true
    nesting = true
    mount   = "nfs;cifs"
  }

  // Terraform will crash without rootfs defined
  rootfs {
    storage = "local-zfs"
    size    = "8G"
  }

  // NFS share mounted on host
  mountpoint {
    slot    = "0"
    storage = "/mnt/host/nfs"
    mp      = "/mnt/container/nfs"
    size    = "10G"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "192.168.1.241/24"
    # ip6    = "auto"
  }
}