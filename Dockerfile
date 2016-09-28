FROM ruby:2.3.1-alpine
MAINTAINER Ryan Schlesinger <ryan@outstand.com>

RUN addgroup -S ecs_console && \
    adduser -S -G ecs_console ecs_console

ENV GOSU_VERSION 1.9
ENV DUMB_INIT_VERSION 1.1.3

RUN apk add --no-cache ca-certificates gnupg openssl && \
    mkdir -p /tmp/build && \
    cd /tmp/build && \
    gpg --keyserver pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 && \
    wget -O gosu "https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-amd64" && \
    wget -O gosu.asc "https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-amd64.asc" && \
    gpg --verify gosu.asc && \
    chmod +x gosu && \
    cp gosu /bin/gosu && \
    wget https://github.com/Yelp/dumb-init/releases/download/v${DUMB_INIT_VERSION}/dumb-init_${DUMB_INIT_VERSION}_amd64 && \
    wget https://github.com/Yelp/dumb-init/releases/download/v${DUMB_INIT_VERSION}/sha256sums && \
    grep dumb-init_${DUMB_INIT_VERSION}_amd64$ sha256sums | sha256sum -c && \
    chmod +x dumb-init_${DUMB_INIT_VERSION}_amd64 && \
    cp dumb-init_${DUMB_INIT_VERSION}_amd64 /bin/dumb-init && \
    cd /tmp && \
    rm -rf /tmp/build && \
    apk del gnupg && \
    rm -rf /root/.gnupg

RUN apk add --no-cache \
    git \
    openssh-client

ENV USE_BUNDLE_EXEC true
ENV BUNDLE_GEMFILE /ecs_console/Gemfile

WORKDIR /ecs_console
COPY Gemfile ecs_console.gemspec /ecs_console/
COPY lib/ecs_console/version.rb /ecs_console/lib/ecs_console/
COPY scripts/fetch-bundler-data.sh /ecs_console/scripts/fetch-bundler-data.sh

ARG bundler_data_host
RUN /ecs_console/scripts/fetch-bundler-data.sh ${bundler_data_host} && \
      (bundle check || bundle install) && \
      git config --global push.default simple
COPY . /ecs_console/
RUN ln -s /ecs_console/exe/ecs_console /usr/local/bin/ecs_console && \
    mkdir -p /home/ecs_console/.ssh && \
    chown ecs_console:ecs_console /home/ecs_console/.ssh && \
    chmod 700 /home/ecs_console/.ssh

COPY scripts/docker-entrypoint.sh /docker-entrypoint.sh

ENV DUMB_INIT_SETSID 0
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["help"]
