terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
  service_account_key_file = var.service_account_key_file
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
}

resource "yandex_kubernetes_cluster" "cluster" {
  name        = var.cluster_name
  description = var.cluster_name

  network_id = var.network_id

  master {
    version = var.kubernetes_version
    zonal {
      zone      = var.zone
      subnet_id = var.subnet_id
    }

    public_ip = true

    maintenance_policy {
      auto_upgrade = true
    }
  }

  service_account_id      = var.service_account_id
  node_service_account_id = var.service_account_id

  release_channel         = var.kubernetes_release_channel
  network_policy_provider = var.kubernetes_network_policy_provider
}


resource "yandex_kubernetes_node_group" "node_group" {
  cluster_id  = yandex_kubernetes_cluster.cluster.id
  name        = "${var.cluster_name}-nodegroup"
  description = "${var.cluster_name}-nodegroup"
  version     = var.kubernetes_version

  instance_template {
    platform_id = "standard-v2"

    network_interface {
      nat        = true
      subnet_ids = [var.subnet_id]
    }

    resources {
      memory = var.res_memory
      cores  = var.res_cores
    }

    boot_disk {
      type = "network-ssd"
      size = var.res_disk_size
    }

    scheduling_policy {
      preemptible = false
    }
  }

  scale_policy {
    fixed_scale {
      size = var.worker_count
    }
  }

  allocation_policy {
    location {
      zone = var.zone
    }
  }

  maintenance_policy {
    auto_upgrade = true
    auto_repair  = true
  }
}
