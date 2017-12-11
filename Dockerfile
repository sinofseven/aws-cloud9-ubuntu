FROM ubuntu:16.04
RUN apt-get update && \
    apt-get install -y apt-transport-https \
                       ca-certificates \
                       curl \
                       software-properties-common \
                       build-essential \
                       git \
                       sudo \
                       libssl-dev \
                       libreadline6-dev \
                       zlib1g-dev \
                       openssh-server && \
    apt-get clean

ENV PUBLIC_KEY 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDHiNpEQL2obDIj0zFjqJBG2anexi7wCp4uHNuVyOi28x+j0p00Cn8AAWI1J9cUtDiv7lpaWKaFypgjjC922dROLzZ7cl2cKd8GfVs5H4S2Ly6S80mDp1KJEXX+F9fdYI170fHi6gtBNESGYm4ajnyHjZflcdi52zvjBwpN1Ds7U+UltmJ0i2UM59uPwtvW6fSc61OwM6YXuXUCFenVhWPrYmR99/oGSfimGpDPbXJpYsA8J1fA/mO7nD5pHwxOc7Gm4hxqEbtSAYaJ+EW+/tEfAoCUzoM3QGtvoTIlTdSE8vIkwsYJaoPmW8SiFPpKBUG3XxeYxW+/PEjmprBS6kxl cloud9@dc6451299562'

RUN useradd cloud9 && \
    usermod -aG sudo cloud9 && \
    echo 'cloud9 ALL=NOPASSWD:ALL' > /etc/sudoers.d/cloud9 && \
    mkdir -p /home/cloud9/.ssh && \
    touch /home/cloud9/.ssh/authorized_keys && \
    echo "source .bashrc" > /home/cloud9/.profile && \
    echo "alias ls='ls --color'" > /home/cloud9/.bashrc && \
    chown -R cloud9:cloud9 /home/cloud9 && \
    chmod 600 /home/cloud9/.ssh/authorized_keys && \
    mkdir /var/run/sshd && \
    chsh -s /bin/bash cloud9

ADD sshd_config /etc/ssh/sshd_config
ADD init.sh /root/init.sh

EXPOSE 22

CMD ["bash", "/root/init.sh"]
