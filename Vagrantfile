# -*- mode: ruby -*-
# vi: set ft=ruby :

vagrant_root = File.basename(File.dirname(__FILE__))

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"
  config.vm.box_check_update = false
  config.vm.hostname = vagrant_root
  config.vm.define vagrant_root do |foo|
  end

  # Specify VirtualBox parameters
  config.vm.provider "virtualbox" do |vb|
      vb.memory = 2048
      vb.cpus = 2
      vb.name = config.vm.hostname
  end

  # Update and install core necessities
  config.vm.provision "shell", inline: <<-SHELL
      apt-get -y update
      apt-get -y upgrade
  SHELL
  config.vm.provision "shell", inline: <<-SHELL
      apt-get install -y g++
      apt-get install -y cmake
      apt-get install -y autoconf
      apt-get install -y libncurses5-dev
      apt-get install -y libevent-dev
      apt-get install -y golang-go
  SHELL

  # Build fish shell
  config.vm.provision "shell", inline: <<-SHELL
      git clone https://github.com/fish-shell/fish-shell.git
      mkdir fish-shell/build && cd fish-shell/build
      cmake ..
      make
      make install
      echo /usr/local/bin/fish | tee -a /etc/shells
      chsh -s /usr/local/bin/fish vagrant
      cd ../.. && rm -rf fish-shell
  SHELL
  config.vm.provision "shell", privileged: false, inline: <<-SHELL
      mkdir -p /home/vagrant/.config/fish
  SHELL

  # Build tmux
  config.vm.provision "shell", inline: <<-SHELL
      git clone https://github.com/tmux/tmux.git
      cd tmux
      git checkout 2.7
      ./autogen.sh
      ./configure && make
      make install
      cd .. && rm -rf tmux
  SHELL

  # Build vim
  config.vm.provision "shell", inline: <<-SHELL
      git clone https://github.com/vim/vim.git
      cd vim/src && make
      make install
      cd ../.. && rm -rf vim
  SHELL

  # Build golang
  config.vm.provision "shell", privileged: false, inline: <<-SHELL
      git clone https://go.googlesource.com/go
      cd go && git checkout go1.10.3
      cd src && ./all.bash
      cd .. && cp -r bin/ /home/vagrant/go-bin-tmp
      cd .. && rm -rf go
      mkdir -p /home/vagrant/go/
      cp -r /home/vagrant/go-bin-tmp/ /home/vagrant/go/bin
      rm -rf /home/vagrant/go-bin-tmp
  SHELL

  # Copy dotfiles
  config.vm.provision "file", source: ".dotfiles", destination: "/home/vagrant/.dotfiles"
  config.vm.provision "shell", privileged: false, inline: <<-SHELL
      cd /home/vagrant/.dotfiles && make
  SHELL

  # Install tmux plugins
  config.vm.provision "shell", privileged: false, inline: <<-SHELL
      git clone https://github.com/tmux-plugins/tpm /home/vagrant/.tmux/plugins/tpm
      cd /home/vagrant/.tmux/plugins/tpm/bin/ && ./install_plugins
  SHELL

  # Install vim plugins
  config.vm.provision "shell", privileged: false, inline: <<-SHELL
      git clone https://github.com/VundleVim/Vundle.vim.git /home/vagrant/.vim/bundle/Vundle.vim
      vim -c "PluginInstall" -c "q" -c "q" > /dev/null
  SHELL
end
