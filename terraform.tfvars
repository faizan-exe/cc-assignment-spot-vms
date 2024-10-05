vm = {
  vm_01 = {
    name         = "vm-laboratory"
    machine_type = "custom-1-2048"
    boot_disk = {
      initialize_params = {
        image = "ubuntu-os-cloud/ubuntu-2204-lts"
        size  = 15
        type  = "pd-standard"
      }
    }
    network_interface = {
      network = "default"
    }
    scheduling = {
      preemptible        = true
      automatic_restart  = false
      provisioning_model = "SPOT"
    }
    tags                      = ["ansible", "infrastructure", "ssh", "docker"]
    allow_stopping_for_update = true
    desired_status            = "RUNNING"
  }
 
}

GOOGLE_CREDENTIALS = "service-account.json"