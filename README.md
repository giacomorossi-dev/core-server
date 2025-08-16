# Core server

## Setup

- Login as root
- sudo adduser admin
- sudo usermod -aG docker admin
- ssh-keygen -t ed25519 -C "admin@core-server" -f ~/.ssh/github-core-server
- chmod 700 ~/.ssh
- chmod 600 ~/.ssh/github-core-server
- chmod 644 ~/.ssh/github-core-server.pub
- setup ./ssh/config

- cat ~/.ssh/github-core-server.pub
- add to deploy keys

- sudo mkdir /opt/core-server
- sudo chown -R admin:admin core-server/
- git clone

- sudo docker network create proxy_public
