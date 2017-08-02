FROM ubuntu

MAINTAINER Federico Moya <federico.moya@surhive.com>

RUN apt-get update && apt-get -y install \
    git \
    wget \
    openssh-server \
    openjdk-8-jdk \
    sudo

# Set SSH Configuration to allow remote logins without /proc write access
RUN sed -ri 's/^session\s+required\s+pam_loginuid.so$/session optional pam_loginuid.so/' /etc/pam.d/sshd

RUN mkdir /var/run/sshd

# Create Jenkins User
RUN useradd jenkins -m -s /bin/bash

# Add public key for Jenkins login
RUN mkdir /home/jenkins/.ssh
COPY jenkins-ssh/authorized_keys /home/jenkins/.ssh/authorized_keys
RUN chown -R jenkins /home/jenkins
RUN chgrp -R jenkins /home/jenkins
RUN chmod 600 /home/jenkins/.ssh/authorized_keys
RUN chmod 700 /home/jenkins/.ssh

# Root directory required for Jenkins (master).
RUN mkdir /home/jenkins/jenkins-slave-agent-root
RUN chown -R jenkins /home/jenkins/jenkins-slave-agent-root

# Add the jenkins user to sudoers
RUN echo "jenkins  ALL=(ALL)  ALL" >> etc/sudoers


# Expose SSH port and run SSHD
EXPOSE 22
CMD ["/usr/sbin/sshd","-D"]
