VAGRANT=/mnt/c/HashiCorp/Vagrant/bin/vagrant.exe
BASENAME=$(shell basename "${PWD}")

default: vagrant-init ssh-config

vagrant-init:
	${VAGRANT} up

ifeq ("$(shell grep "Host ${BASENAME}" ~/.ssh/config > /dev/null 2>&1 || echo "1")", "1")
ssh-config:
	$(shell ${VAGRANT} ssh-config >> ~/.ssh/config)
	cp "$(shell cat ~/.ssh/config | grep IdentityFile | cut -d '"' -f2 | sed "s/C:/\/mnt\/c/g")" ~/.ssh/${BASENAME}.key
	chmod 600 ~/.ssh/${BASENAME}.key
	sed -i '/IdentityFile/{/${BASENAME}\// s/"[^"][^"]*"/"~\/.ssh\/${BASENAME}.key"/}' ~/.ssh/config
else
ssh-config: ;
endif

