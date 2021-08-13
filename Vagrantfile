Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-21.04"

  # folder sync
  # config.vm.synced_folder ".", "/vagrant", :mount_options => [ "dmode=777", "fmode=777" ]

  config.vm.provider "virtualbox" do |v|
    # free to beef it up to improve performance if needed.
    v.name = "ubuntu-21"
    v.cpus = "1"
    v.memory = "1024"

    # Uncomment this if you want a GUI environment.
    # v.gui = true
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    v.customize ["guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold", 10000]
    v.customize ["modifyvm", :id, "--usb", "off"]
    v.customize ["modifyvm", :id, "--usbehci", "off"]
    v.customize ["modifyvm", :id, "--cableconnected1", "on"]
  end

  config.vm.provision :shell, path: "bootstrap.sh"

  # networking
  # Create a private network, which allows host-only access to the machine using a specific IP.
  config.vm.network "private_network", ip: "192.168.33.22"
  # auto_correct means vm can start if there is a port collision on host port
  config.vm.network "forwarded_port", guest:80, host:8888, auto_correct: true
  config.vm.network "forwarded_port", guest:27017, host:37017, auto_correct: true

  [4567].each do |port|
    config.vm.network :forwarded_port, guest: port, host: port, auto_correct: true
  end

end
