FROM alpine:latest

ENV PYTHONUNBUFFERED=1

COPY requirements.txt /tmp/
RUN apk --no-cache --update add \
        nodejs \
        npm \
        python3 \
        py3-pip \
        ca-certificates \
        groff \
        less \
        bash \
        make \
        curl \
        wget \
        zip \
        git \
        && \
    update-ca-certificates && \
    npm install -g aws-cdk && \
    pip install -r /tmp/requirements.txt

VOLUME [ "/root/.aws" ]
VOLUME [ "/opt/app" ]

WORKDIR /opt/app

CMD ["cdk", "--version"]
