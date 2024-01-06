NUM_APP_NODE = 2
APP_IP_START = 1

IP_NW = "192.168.56."

Vagrant.configure("2") do |config|
  # Setup the SSH Keys
  ssh_pub_key = File.readlines("#{Dir.pwd}/vagrant/key/vagrant-key.pub").first.strip
  config.vm.provision 'shell', inline: 'mkdir -p /root/.ssh'
  config.vm.provision 'shell', inline: "echo #{ssh_pub_key} >> /root/.ssh/authorized_keys"
  config.vm.provision 'shell', inline: "echo #{ssh_pub_key} >> /home/vagrant/.ssh/authorized_keys", privileged: false

  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "bento/ubuntu-22.04-arm64"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  config.vm.box_check_update = false

  config.vm.provider "vmware_desktop" do |v|
    v.gui = false
    v.vmx["memsize"] = "1024"
    v.vmx["numvcpus"] = "1"
  end


  # Provision APP Nodes
  (1..NUM_APP_NODE).each do |i|
    config.vm.define "app-#{i}" do |node|
      node.vm.hostname = "app-#{i}.vagrant.local"
      node.vm.network :private_network, ip: IP_NW + "#{APP_IP_START + i}"
      node.vm.network "forwarded_port", guest: 22, host: "#{2710 + i}", auto_correct: true

      node.vm.provision "setup-hosts", :type => "shell", :path => "vagrant/setup-hosts.sh" do |s|
        s.args = ["eth1"]
      end

      node.vm.provision "setup-dns", type: "shell", :path => "vagrant/update-dns.sh"

    end
  end

  config.vm.define "prometheus" do |node|
    node.vm.hostname = "prometheus.vagrant.local"
    node.vm.network :private_network, ip: IP_NW + "#{APP_IP_START + NUM_APP_NODE + 1}"
    node.vm.network "forwarded_port", guest: 22, host: "#{2710 + NUM_APP_NODE + 1}", auto_correct: true

    node.vm.provision "setup-hosts", :type => "shell", :path => "vagrant/setup-hosts.sh" do |s|
      s.args = ["eth1"]
    end

    node.vm.provision "setup-dns", type: "shell", :path => "vagrant/update-dns.sh"
  end

  config.vm.define "grafana" do |node|
    node.vm.hostname = "grafana.vagrant.local"
    node.vm.network :private_network, ip: IP_NW + "#{APP_IP_START + NUM_APP_NODE + 2}"
    node.vm.network "forwarded_port", guest: 22, host: "#{2710 + NUM_APP_NODE + 2}", auto_correct: true

    node.vm.provision "setup-hosts", :type => "shell", :path => "vagrant/setup-hosts.sh" do |s|
      s.args = ["eth1"]
    end

    node.vm.provision "setup-dns", type: "shell", :path => "vagrant/update-dns.sh"
  end
  
  config.vm.define "grafana-loki" do |node|
    node.vm.hostname = "grafana-loki.vagrant.local"
    node.vm.network :private_network, ip: IP_NW + "#{APP_IP_START + NUM_APP_NODE + 3}"
    node.vm.network "forwarded_port", guest: 22, host: "#{2710 + NUM_APP_NODE + 3}", auto_correct: true

    node.vm.provision "setup-hosts", :type => "shell", :path => "vagrant/setup-hosts.sh" do |s|
      s.args = ["eth1"]
    end

    node.vm.provision "setup-dns", type: "shell", :path => "vagrant/update-dns.sh"
  end

end
