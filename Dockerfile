FROM ubuntu:jammy

ENV PYTHONUNBUFFERED=1
ENV PYTHONIOENCODING=UTF-8

RUN apt update && apt upgrade -y
RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt -y install tzdata locales

# Set the locale for UTF-8 support
RUN echo en_US.UTF-8 UTF-8 >> /etc/locale.gen && \
    locale-gen && \
    update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV PATH /usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/bin:/sbin

RUN apt install -y python3 python3-distutils python3-pip libexpat1 ca-certificates curl zip git vim.tiny
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash - && apt install -yq nodejs build-essential
RUN curl https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o /tmp/awscliv2.zip && \
    cd /tmp && \
    unzip awscliv2.zip && \
    ./aws/install >/dev/null && \
    rm awscliv2.zip

COPY requirements.txt /tmp/
COPY sleep.sh /bin/sleep.sh

RUN npm install -g aws-cdk && \
    pip install -r /tmp/requirements.txt

RUN rm -rf /var/cache/apt

VOLUME [ "/root/.aws" ]
VOLUME [ "/opt/app" ]

WORKDIR /opt/app

CMD ["cdk", "--version"]
