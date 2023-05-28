cd ~

test -e ~/.ssh/id_rsa || ssh-keygen

# aliases 
touch .bashrc
echo "alias la='ls -la'" >> .bash
echo "alias sl='ls'"
echo "alias gs='git status'"
echo "alias k='kubectl'"

# packages
sudo apt install build-essential
sudo apt install make
sudo apt install sqlite3
sudo apt install postgresql-client-common

mkdir dontPanic
cd dontPanic

# helix
wget $(curl -s https://api.github.com/repos/helix-editor/helix/releases/latest | jq -r ".assets[] | select(.name) | .browser_download_url" | grep x86_64-linux)
tar -xvf  helix-23.05-x86_64-linux.tar.xz
export PATH="~/dontPanic/helix-23.05-x86_64-linux:$PATH"

# docker
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
sudo usermod -aG docker $(whoami)

# node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
nvm install node

# go 
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.20.4.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin
go install golang.org/x/tools/gopls@latest

# python
curl https://pyenv.run | bash
export PYENV_ROOT="$HOME/.pyenv"
export PATH=$PATH:$HOME/.pyenv
eval "$(pyenv init -)"
pyenv install 3.10.4