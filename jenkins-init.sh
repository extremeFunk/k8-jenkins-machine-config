#!/bin/sh
#cd /home/ubuntu
#echo "########################################"
#echo "######  Installing Docker         ######"
#echo "########################################"
#sudo curl -sSL https://get.docker.com/ | sh
#sudo usermod -aG docker ${USER}
#sudo chmod 666 /var/run/docker.sock
echo "########################################"
echo "######  install cradential helper     ######"
echo "########################################"

VERSION=2.0.0
OS=linux  # or "darwin" for OSX, "windows" for Windows.
ARCH=amd64  # or "386" for 32-bit OSs, "arm64" for ARM 64.

curl -fsSL "https://github.com/GoogleCloudPlatform/docker-credential-gcr/releases/download/v${VERSION}/docker-credential-gcr_${OS}_${ARCH}-${VERSION}.tar.gz" \
  > docker-credential-gcr.tar.gz
tar -xvzf docker-credential-gcr.tar.gz
sudo mv docker-credential-gcr /usr/bin/docker-credential-gcr
chmod +x /usr/bin/docker-credential-gcr
