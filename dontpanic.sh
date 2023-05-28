#!/bin/bash
cd ~

test -e ~/.ssh/id_rsa || ssh-keygen -t rsa -f ~/.ssh/id_rsa

# aliases
echo "alias la='/usr/bin/ls -la'" >> ~/.bashrc
echo "alias sl='/usr/bin/ls'" >> ~/.bashrc
echo "alias gs='git status'" >> ~/.bashrc
echo "alias k='kubectl'" >> ~/.bashrc

# packages
sudo apt-get -y update
sudo apt install -y build-essential make sqlite3 postgresql-client-common jq

mkdir dontPanic
cd dontPanic

# helix
wget $(curl -s https://api.github.com/repos/helix-editor/helix/releases/latest | jq -r ".assets[] | select(.name) | .browser_download_url" | grep x86_64-linux)
fileName=$(ls | grep helix)
tar -xvf ${fileName}
rm -f ${fileName}
folderName=$(ls | grep helix)
echo "export PATH=\"~/dontPanic/${folderName}:\$PATH\"" >> ~/.bashrc

# docker
curl -fsSL https://get.docker.com | bash
sudo usermod -aG docker $(whoami)
sudo systemctl start docker

# node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
source ~/.bashrc
nvm install node

# go
wget https://go.dev/dl/go1.20.4.linux-amd64.tar.gz
filename=$(ls | grep go)
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf ${filename}
rm -rf ${filename}
echo "export PATH=\"\$PATH:/usr/local/go/bin\"" >> ~/.bashrc
source ~/.bashrc
go install golang.org/x/tools/gopls@latest

# python
echo "export PYENV_ROOT=\"\$HOME/.pyenv\"" >> ~/.bashrc
echo "export PATH=\"\$PATH:\$HOME/.pyenv\"" >> ~/.bashrc
echo "command -v pyenv >/dev/null || export PATH=\"\$PYENV_ROOT/bin:\$PATH\"" >> ~/.bashrc
echo "eval \"\$(pyenv init -)\"" >> ~/.bashrc
echo "eval \"\$(pyenv virtualenv-init -)\"" >> ~/.bashrc
source ~/.bashrc
curl https://pyenv.run | bash
source ~/.bashrc
pyenv install 3.10.4


echo ""
echo ""
echo "Finished install! Please log out and log back in to the terminal session :)"
