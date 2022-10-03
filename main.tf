terraform {
  required_providers {
    virtualbox = {
      source = "terra-farm/virtualbox"
      version = "0.2.2-alpha.1"
    }
  }
}


resource "virtualbox_vm" "node" {
# count     = 1
# name      = format("ubuntu%01d", count.index + 3)
# remplacement par des variables : voir variables.tf
  count     = var.nb
  name      = format("ubuntu%01d", count.index + var.start)
  image     = "https://app.vagrantup.com/ubuntu/boxes/focal64/versions/20220905.0.0/providers/virtualbox.box"
  cpus      = 4
  memory    = "2048 mib"

  network_adapter {
    type           = "bridged"
    host_interface = "ens160"
  }
}

# bug : possible timeout...
output "ip_addresses" {
    value = {
    for vm in virtualbox_vm.node.*:
      	vm.name => vm.network_adapter.0.ipv4_address
	}
}

#########################
# Principales commandes #
#########################

# pour valider notre script de configuration HCL
# -> terraform validate
# pour initaliser terraform (et le provider):
# -> terraform init
# pour voir ce qui va se passer :
# -> terraform plan
# pour appliquer le plan:
# -> terraform apply
# pour voir le déploiment réalisé
# -> terraform show
# ou encore
# -> terraform state list
# -> terraform state show virtualbox_vm.node[0]
# Pour retrouver les adresses ip à tout moment (voir bloc output plus haut):
# -> terraform output
# Pour supprimer les machines:
# -> terraform destroy

