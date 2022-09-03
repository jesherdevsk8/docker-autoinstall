#!/bin/bash
# -----------------------------------------------------------------
# Script   : install.sh
# Descrição: script de instalação do docker
# Versão   : 1.5
# Data     : sex 2 set 2022
# Histórico:
#  v1.0 02/09/2022 Slackjeff :
#     - Versão inicial <https://github.com/slackjeff/preset/blob/master/debian_install_docker>
#  v1.5 02/09/2022 Jesher :
#     - Adiciona docker ao usuário, para nao executar como root
# -----------------------------------------------------------------
# Uso: ./autoinstall
# -----------------------------------------------------------------

non_root_user=$(who am i | awk '{print $1}');

[[ $UID -ne 0 ]] && { echo "Precisa de Root..." ; exit 1; }

install(){
	apt-get install ca-certificates curl gnupg lsb-release -y
	curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
	echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
	apt update
	apt-get install docker-ce docker-ce-cli containerd.io
}

config(){
	usermod -a -G docker $non_root_user
}

install
config

### Please reboot your system