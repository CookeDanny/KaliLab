$ErrorActionPreference = "Stop"

$virtualBoxMinVersion = "5.1.26"
$packerMinVersion = "1.0.4"
$vagrantMinVersion = "1.9.8"
$vagrantreloadMinVersion = "0.0.1"

If ($(Test-Path "kali-linux-vbox-amd64") -eq $True) {
    Write-Host "It looks like the Vagrant box already exists. Skipping the Packer build."
} else {
    Write-Host "Building the Vagrant box..."

    if($?) {
        Write-Host "Box successfully built by Packer."
    } else {
        throw "Error building the Vagrant box using Packer. Please check the output above for any error messages."
    }
}

echo "Attempting to add the box to Vagrant..."

$vagrant_box_list = cmd.exe /c "vagrant box list" | select-string -pattern "Kali Linux"

If ($vagrant_box_list) { $vagrant_box_list = $vagrant_box_list.ToString().Trim() }

If ($vagrant_box_list -eq "Kali Linux") {
    Write-Host "Kali Linux already found in Vagrant box repository. Skipping the addition to Vagrant."
} else {

    cmd.exe /c vagrant box add Kali Linux kali-linux-vbox-amd64

    if($?) {
        Write-Host "Box successfully added to Vagrant."
    } else {
        throw "Error adding box to Vagrant. See the above output for any error messages."
    }
}

Write-Host "SUCCESS: Run 'vagrant up' to provision and start Kali Linux."
Write-Host "NOTE: The VM will need Internet access to provision properly."
