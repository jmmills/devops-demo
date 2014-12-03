# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "puppetlabs/centos-7.0-64-puppet"

  config.vm.network "forwarded_port", guest: 8080, host: 8080,
    auto_correct: true
  config.vm.network "forwarded_port", guest: 3000, host: 3000,
    auto_correct: true

  config.vm.define "a", primary: true do |node|
    node.vm.network "private_network", ip: "192.168.50.5"

    node.vm.provision :shell do |shell|
      shell.inline = "puppet module install garethr-docker"
    end

    node.vm.provision "puppet" do |puppet|
      puppet.manifests_path = "puppet/manifests"
      puppet.options = "--verbose --debug"
    end
  end

  config.vm.define "b", primary: false, autostart: false do |node|
    node.vm.network "private_network", ip: "192.168.50.6"

    node.vm.provision :shell do |shell|
      shell.inline = "puppet module install garethr-docker"
    end

    node.vm.provision "puppet" do |puppet|
      puppet.manifests_path = "puppet/manifests"
      puppet.options = "--verbose --debug"
    end
  end

  config.vm.define "c", primary: false, autostart: false do |node|
    node.vm.network "private_network", ip: "192.168.50.6"

    node.vm.provision :shell do |shell|
      shell.inline = "puppet module install garethr-docker"
    end

    node.vm.provision "puppet" do |puppet|
      puppet.manifests_path = "puppet/manifests"
      puppet.options = "--verbose --debug"
    end
  end

end
