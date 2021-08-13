#!/usr/bin/env bash

# setup
apt-get install -y curl git build-essential libssl-dev libreadline-dev zlib1g-dev

git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.1
echo -e '\n. $HOME/.asdf/asdf.sh' >> ~/.bashrc
echo -e '\n. $HOME/.asdf/completions/asdf.bash' >> ~/.bashrc
echo 'source ~/.asdf/asdf.fish' >> ~/.config/fish/config.fish
mkdir -p ~/.config/fish/completions || exit 0; cp ~/.asdf/completions/asdf.fish ~/.config/fish/completions

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# end-setup

# docker
brew install docker

asdf plugin-add docker-slim
asdf install docker-slim 1.24
asdf global docker-slim 1.24

sudo groupadd docker
sudo usermod -aG docker $USER
# end-docker

# nodejs
asdf plugin-add nodejs
asdf install nodejs 16.6.0
asdf global nodejs 16.6.0

npm i -g npm
# end-nodejs

# kubernetes
asdf plugin-add k3d
asdf install k3d 4.4.3
asdf global k3d 4.4.3

asdf plugin-add k9s
asdf install k9s 0.24.8
asdf global k9s 0.24.8

asdf plugin-add kompose
asdf install kompose 1.22.0
asdf global kompose 1.22.0

asdf plugin-add kustomize
asdf install kustomize 4.1.3
asdf global kustomize 4.1.3

asdf plugin-add ctlptl
asdf install ctlptl 0.5.1
asdf global ctlptl 0.5.1

asdf plugin-add kubectl
asdf install kubectl 1.21.0
asdf global kubectl 1.21.0

asdf plugin-add tilt
asdf install tilt 0.20.6
asdf global tilt 0.20.6

brew install krew

if grep -q krew"$HOME/.bashrc"; then
  echo 'No update to PATH'
else
  echo 'Updating PATH'
  echo '' >> ~/.bashrc
  echo 'export PATH="${PATH}:${HOME}/.krew/bin"' >> ~/.bashrc
  echo '' >> ~/.bashrc
  echo 'Please restart your shell'
fi

CLUSTER_NAME='local-cattle-ranch'
k3d cluster create"$CLUSTER_NAME" --registry-create
k3d kubeconfig merge"$CLUSTER_NAME" --kubeconfig-switch-context

kubectl krew install konfig
kubectl get pods --all-namespaces
#end-kubernetes

# shell
brew install rbenv direnv fish
# end-shell

