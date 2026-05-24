Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/jammy64"

  # ---------------------------------------------------------
  # 1. Web Server (Target - Fully Isolated)
  # ---------------------------------------------------------
  config.vm.define "web" do |web|
    web.vm.hostname = "nginx"

    web.vm.provider "virtualbox" do |vb|
      vb.name = "sps-special-nginx"
      vb.memory = "512"
      vb.cpus = 2
      vb.gui = false
    end

    # ONLY connected to the isolated internal network
    web.vm.network "private_network", ip: "10.0.0.20", virtualbox__intnet: "lab_internal"
  end

  # ---------------------------------------------------------
  # 2. DNS Server (Target - Fully Isolated)
  # ---------------------------------------------------------
  config.vm.define "dns" do |dns|
    dns.vm.hostname = "ns1"
      
    dns.vm.provider "virtualbox" do |vb|
      vb.name = "sps-special-dns-ns1"
      vb.memory = "512"
      vb.cpus = 2
      vb.gui = false
    end

    # ONLY connected to the isolated internal network
    dns.vm.network "private_network", ip: "10.0.0.30", virtualbox__intnet: "lab_internal"
  end

  # ---------------------------------------------------------
  # 3. Management Server (Control Node)
  # ---------------------------------------------------------
  config.vm.define "mgmt" do |mgmt|
    mgmt.vm.hostname = "ansible"
    
    mgmt.vm.provider "virtualbox" do |vb|
      vb.name = "sps-special-ansible"
      vb.memory = "512"
      vb.cpus = 2
      vb.gui = false
    end
    # Interface 1: Host-only (Allows you to connect from your laptop)
    mgmt.vm.network "private_network", ip: "192.168.56.10"
    # Interface 2: Internal Network (Connects to the isolated lab)
    mgmt.vm.network "private_network", ip: "10.0.0.10", virtualbox__intnet: "lab_internal"
    
    # Install Ansible and sshpass directly onto this server
    mgmt.vm.provision "shell", inline: <<-SHELL
      apt-get update
      apt-get install -y python3-pip sshpass
      pip install ansible
      ansible-galaxy collection install ansible.posix
    SHELL

    mgmt.vm.provision "shell", inline: <<-SHELL
      # Creating keys folder
      mkdir -p /home/vagrant/.ssh/machines_keys

      # Copy private keys to the mgmt
      cp /vagrant/.vagrant/machines/dns/virtualbox/private_key /home/vagrant/.ssh/machines_keys/dns_private_key
      cp /vagrant/.vagrant/machines/web/virtualbox/private_key /home/vagrant/.ssh/machines_keys/web_private_key

      # Permissions
      # chmod 600 ~/.ssh/machines_keys/*
      sudo chown -R vagrant:vagrant /home/vagrant/.ssh

      sudo chmod 700 /home/vagrant/.ssh
      sudo chmod 700 /home/vagrant/.ssh/machines_keys

      sudo chmod 600 /home/vagrant/.ssh/machines_keys/*
    SHELL

    mgmt.vm.provision "shell", inline: <<-SHELL
      # Copy ansible files
      mkdir -p /home/vagrant/ansible
      cp -r /vagrant/ansible/* /home/vagrant/ansible
    SHELL
  end
end