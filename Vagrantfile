
#HOST_ONLY_NETWORK = "vboxnet1" # Typically on Linux/Mac
HOST_ONLY_NETWORK = "VirtualBox Host-Only Ethernet Adapter #3" # Typically on Windows

Vagrant.configure("2") do |config|
      config.vm.boot_timeout = 600
    config.vm.define "companyrouter" do |host|
        host.vm.box = "almalinux/9"
        host.vm.hostname = "companyrouter"

        host.vm.network "private_network", ip: "192.168.62.253", netmask: "255.255.255.0", name: HOST_ONLY_NETWORK
        host.vm.network "private_network", ip: "172.30.255.254", netmask: "255.255.0.0", virtualbox__intnet: "internal-company-lan"

        host.vm.provider :virtualbox do |v|
            v.name = "companyrouter"
            v.cpus = "1"
            v.memory = "512"
        end

        host.vm.provision "shell", inline: <<-SHELL
            # Default gateway
            nmcli connection modify "System eth1" ipv4.gateway 192.168.62.254
            systemctl restart NetworkManager
        SHELL
    end

    config.vm.define "dns" do |host|
        host.vm.box = "generic/alpine318"
        host.vm.hostname = "dns"

        host.vm.network "private_network", ip: "172.30.0.4", netmask: "255.255.255.0", virtualbox__intnet: "internal-company-lan"

        host.vm.provider :virtualbox do |v|
            v.name = "dns"
            v.cpus = "1"
            v.memory = "256"
        end

        host.vm.provision "shell", inline: <<-SHELL
            # For ansible
            apk --no-cache add python3

            # Default gateway
            echo "gateway 172.30.255.254" >> /etc/network/interfaces
            service networking restart
        SHELL
    end

    config.vm.define "web" do |host|
        host.vm.box = "almalinux/9"
        host.vm.hostname = "web"

        host.vm.network "private_network", ip: "172.30.0.10", netmask: "255.255.255.0", virtualbox__intnet: "internal-company-lan"

        host.vm.provider :virtualbox do |v|
            v.name = "web"
            v.cpus = "1"
            v.memory = "1024"
        end

        host.vm.provision "shell", inline: <<-SHELL
            # Default gateway
            nmcli connection modify "System eth1" ipv4.gateway 172.30.255.254
            systemctl restart NetworkManager
        SHELL
    end

    config.vm.define "database" do |host|
        host.vm.box = "generic/alpine318"
        host.vm.hostname = "database"

        host.vm.network "private_network", ip: "172.30.0.15", netmask: "255.255.255.0", virtualbox__intnet: "internal-company-lan"

        host.vm.provider :virtualbox do |v|
            v.name = "database"
            v.cpus = "1"
            v.memory = "256"
        end

        host.vm.provision "shell", inline: <<-SHELL
            # For ansible
            apk --no-cache add python3

            # Default gateway
            echo "gateway 172.30.255.254" >> /etc/network/interfaces
            service networking restart
        SHELL
    end

    config.vm.define "employee" do |host|
        host.vm.box = "generic/alpine318"
        host.vm.hostname = "employee"

        # TODO DHCP
        host.vm.network "private_network", ip: "172.30.0.123", netmask: "255.255.255.0", virtualbox__intnet: "internal-company-lan"

        host.vm.provider :virtualbox do |v|
            v.name = "employee"
            v.cpus = "1"
            v.memory = "256"
        end

        host.vm.provision "shell", inline: <<-SHELL
            # For ansible
            apk --no-cache add python3

            # Default gateway
            echo "gateway 172.30.255.254" >> /etc/network/interfaces
            service networking restart
        SHELL
    end

    config.vm.define "isprouter" do |host|
        host.vm.box = "generic/alpine318"
        host.vm.hostname = "isprouter"

        host.vm.network "private_network", ip: "192.168.62.254", netmask: "255.255.255.0", name: HOST_ONLY_NETWORK

        host.vm.provider :virtualbox do |v|
            v.name = "isprouter"
            v.cpus = "1"
            v.memory = "256"
        end

        host.vm.provision "shell", inline: <<-SHELL
            apk --no-cache add python3 # For ansible
        SHELL
        host.vm.provision "file", source: "ansible", destination: "$HOME/ansible"
    end

    config.vm.define "homerouter" do |host|
        host.vm.box = "almalinux/9"
        host.vm.hostname = "homerouter"

        host.vm.network "private_network", ip: "192.168.62.42", netmask: "255.255.255.0", name: HOST_ONLY_NETWORK
        host.vm.network "private_network", ip: "172.10.10.254", netmask: "255.255.255.0", virtualbox__intnet: "employee-home-lan"

        host.vm.provider :virtualbox do |v|
            v.name = "homerouter"
            v.cpus = "1"
            v.memory = "1024"
        end

        host.vm.provision "shell", inline: <<-SHELL
            # Default gateway
            nmcli connection modify "System eth1" ipv4.gateway 192.168.62.254
            systemctl restart NetworkManager
        SHELL
    end

    config.vm.define "remote-employee" do |host|
        host.vm.box = "almalinux/9"
        host.vm.hostname = "remote-employee"

        host.vm.network "private_network", ip: "172.10.10.123", netmask: "255.255.255.0", virtualbox__intnet: "employee-home-lan"

        host.vm.provider :virtualbox do |v|
            v.name = "remote-employee"
            v.cpus = "1"
            v.memory = "1024"
        end

        host.vm.provision "shell", inline: <<-SHELL
            # Default gateway
            nmcli connection modify "System eth1" ipv4.gateway 172.10.10.254
            systemctl restart NetworkManager
        SHELL
    end

    config.vm.define "red" do |red|
        red.vm.box = "kalilinux/rolling"
        red.vm.box_version = "2025.3.0"
        red.vm.hostname = "red"
        red.vm.provider "virtualbox" do |vb|
            vb.gui = true
            vb.name = "red"
            vb.memory = "2048"
            vb.cpus = "2"
        end

    # Verbind de machine met het 'fake internet' netwerk
    red.vm.network "private_network", ip: "192.168.62.100", name: HOST_ONLY_NETWORK

    # Configureer IP, gateway en DNS in één keer om timingproblemen te voorkomen
    red.vm.provision "shell", inline: <<-SHELL
      echo "Configuring network for Kali machine..."
      # Wacht even tot de netwerk-service volledig is opgestart
      sleep 10
      # Stel IP, gateway, en DNS in voor "Wired connection 2"
      nmcli connection modify "Wired connection 2" \
        ipv4.addresses 192.168.62.100/24 \
        ipv4.gateway 192.168.62.254 \
        ipv4.dns "192.168.62.254" \
        ipv4.method manual
      # Activeer de verbinding om de wijzigingen toe te passen
      nmcli connection up "Wired connection 2"
      # Herstart de NetworkManager voor de zekerheid
      systemctl restart NetworkManager
    SHELL
  end
end
