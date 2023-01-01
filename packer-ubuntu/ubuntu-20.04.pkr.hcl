variable "iso_file" {
  type    = string
  default = "local:iso/ubuntu-20.04.iso"
}

variable "proxmox_host" {
  type    = string
  default = "crsm3pve"
}

variable "proxmox_url" {
  type    = string
  default = "https://10.91.31.230:8006/api2/json"
}

variable "proxmox_username" {
  type    = string
  default = "root@pam"
}

variable "proxmox_pass" {
  type    = string
  default = ""
}

variable "ssh_password" {
  type      = string
  default   = ""
}

variable "ssh_username" {
  type    = string
  default = "ubuntu"
}

variable "template_description" {
  type    = string
  default = "Ubuntu 20.04 x86_64 template built with packer"
}

variable "vm_core" {
  type    = string
  default = "4"
}

variable "vm_disk_size" {
  type    = string
  default = "60G"
}

variable "vm_memory" {
  type    = string
  default = "8192"
}

variable "vm_name" {
  type    = string
  default = null
}

variable "vm_id" {
  type    = string
  default = null
}


locals {
  build_date = formatdate("DD MMM YYYY hh:mm ZZZ", timestamp())
}

source "proxmox" "ubuntu" {
  boot_command = ["<enter><enter><f6><esc><wait> ", "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>", "autoinstall ds=nocloud-net;s=http://github-runners.igk.intel.com/", "<enter>"]
  boot_wait    = "5s"
  cores        = var.vm_core
  disks {
    disk_size         = var.vm_disk_size
    format            = "raw"
    storage_pool      = "local-zfs"
    storage_pool_type = "zfspool"
    type              = "scsi"
  }
  insecure_skip_tls_verify = true
  iso_file                 = var.iso_file
  memory                   = var.vm_memory
  network_adapters {
    bridge      = "vmbr30"
    mac_address = "D6:0B:86:D3:60:7B"
    model       = "virtio"
  }
  node                   = var.proxmox_host
  username               = var.proxmox_username
  password               = var.proxmox_pass
  proxmox_url            = var.proxmox_url
  scsi_controller        = "virtio-scsi-pci"
  ssh_handshake_attempts = "20"
  ssh_password           = var.ssh_password
  ssh_timeout            = "30m"
  ssh_username           = var.ssh_username
  template_description   = var.template_description
  unmount_iso            = true
  vm_id                  = var.vm_id
  vm_name                = var.vm_name
}

# a build block invokes sources and runs provisioning steps on them. The
# documentation for build blocks can be found here:
# https://www.packer.io/docs/templates/hcl_templates/blocks/build
build {
  description = "Build Ubuntu 20.04 (focal) x86_64 Proxmox template"

  sources = ["source.proxmox.ubuntu"]

  provisioner "ansible" {
    ansible_env_vars = ["ANSIBLE_HOST_KEY_CHECKING=False", "ANSIBLE_SSH_ARGS='-o ForwardAgent=yes -o ControlMaster=auto -o ControlPersist=60s'"]
    extra_arguments  = ["--extra-vars", "img_version=${var.vm_name} build_date='${local.build_date}' ansible_connection=ssh ansible_user=ubuntu ansible_ssh_pass=${var.ssh_password} ansible_ssh_common_args='-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'"]
    playbook_file    = "ansible/sysconfig.yml"
    use_proxy        = false
    user             = "root"
  }

  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    script          = "scripts/setup_cloud-init.sh"
  }

}
