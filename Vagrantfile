# -*- mode: ruby -*-
# vi: set ft=ruby :

ENV["LC_ALL"] = "en_US.UTF-8"

Vagrant.require_version ">= 2.0.0"

#$vm_box = "ubuntu/xenial64"
$vm_box = "centos/7"
$instances = 1

Vagrant.configure("2") do |config|
  # always use Vagrants insecure key
  config.ssh.insert_key = false
  config.vm.box_check_update = false
  config.vm.box = $vm_box
  config.vm.synced_folder ".", "/vagrant", disabled: true

  if Vagrant.has_plugin?("vagrant-vbguest") then
    config.vbguest.auto_update = false
  end

  if Vagrant.has_plugin?("vagrant-proxyconf")
    config.proxy.http     = ENV['HTTP_PROXY'] || ENV['http_proxy'] || ""
    config.proxy.https    = ENV['HTTPS_PROXY'] || ENV['https_proxy'] ||  ""
    config.proxy.no_proxy = $no_proxy
  end

  config.vm.define vm_name = "security-test" do |config|
    config.vm.hostname = "security-test"
    config.vm.network "private_network", ip: "172.28.128.10"

    config.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--natdnshostresolver1", "off"]
      vb.customize ["modifyvm", :id, "--natdnsproxy1", "off"]
      vb.name = "security-test"
      vb.memory = "512"
      vb.cpus = "1"
    end

    config.vm.provision "ansible" do |ansible|
      # ansible.inventory_path = "./vagrant_hosts.ini"
      ansible.limit = "all"
      ansible.playbook = "play-all.yml"
    end
  end
end
