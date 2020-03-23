#!/bin/sh
cd /home/ubuntu
echo "########################################"
echo "######  Installing Docker         ######"
echo "########################################"
sudo curl -sSL https://get.docker.com/ | sh
sudo usermod -aG docker ${USER}
sudo chmod 666 /var/run/docker.sock
echo "########################################"
echo "######  configure local files     ######"
echo "########################################"
mkdir jenkins_home
sudo chmod 777 jenkins_home
sudo chmod 777 gcp_crd.json
sudo chown jenkins:jenkins gcp_crd.json

VERSION=2.0.0
OS=linux  # or "darwin" for OSX, "windows" for Windows.
ARCH=amd64  # or "386" for 32-bit OSs, "arm64" for ARM 64.

curl -fsSL "https://github.com/GoogleCloudPlatform/docker-credential-gcr/releases/download/v${VERSION}/docker-credential-gcr_${OS}_${ARCH}-${VERSION}.tar.gz" | tar xz --to-stdout ./docker-credential-gcr > /usr/bin/docker-credential-gcr
chmod +x /usr/bin/docker-credential-gcr
echo "########################################"
echo "######  Building IMG              ######"
echo "########################################"
docker build -t echo/jenkins .
echo "########################################"
echo "######  Running Jenkins          #######"
echo "########################################"
  docker run -d -p 8080:8080 \
  -p 5000:5000 \
  -v ${PWD}/jenkins_home:/var/jenkins_home \
  -v /var/run/docker.sock:/var/run/docker.sock \
  echo/jenkins

echo "########################################"
echo "######    waiting for 10S'        ######"
echo "########################################"
sleep 10
echo "########################################"
echo "######  Docker process running:   ######"
echo "########################################"
docker ps