FROM jenkins/jenkins:lts

USER root
RUN echo "root:pass" | chpasswd

RUN apt-get update
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
RUN apt-get install apt-transport-https ca-certificates gnupg -y
RUN apt-get update
RUN apt-get install google-cloud-sdk -y
COPY gcp_crd.json /var/jenkins_home/gcp_crd.json
RUN gcloud auth activate-service-account rainrobot@rainrobot-k8-project.iam.gserviceaccount.com --key-file=/var/jenkins_home/gcp_crd.json

RUN curl -sSL https://get.docker.com/ | sh
RUN usermod -aG docker jenkins

ENV JAVA_HOME /usr/local/openjdk-8
ENV DOCKER_HOST unix:///var/run/docker.sock

USER jenkins

COPY MBP-job /MBP-job
COPY MBP-job /var/jenkins_home/jobs/MBP-job
COPY jenkins-plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt
