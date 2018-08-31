#!/bin/bash

#min_vbox_ver="5.1.26"
#min_vagrant_ver="1.9.8"
#min_packer_ver="1.0.4"
#min_vagrantreload-ver="0.0.1"
#packer_bin="packer"

if ls | grep -q 'kali-linux-vbox-amd64'; then
  echo "A Kali Linux box already exists. Skipping additional Packer build."
else
  echo "Assembling Kali Linux box."
fi

echo "Adding box to Vagrant."

if vagrant box list | grep -q 'Kali Linux'; then
  echo "Kali Linux already found. Skipping the new assembly."
  echo "To start over, type the commands: "
  echo "vagrant destroy"
  echo "vagrant up"
else
  if vagrant box add kali-linux-vbox-amd64 --name Kali Linux; then
    echo "Box successfully added to Vagrant."
  else
    echo "Error adding box to Vagrant. See the above output for any error messages."
    exit 1
  fi
fi

echo "---------------------------------------------------------------------"
echo "SUCCESS: Run 'vagrant up' to provision and start Kali."
echo "NOTE: The VM will need Internet access to provision properly."
