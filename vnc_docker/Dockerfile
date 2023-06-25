ARG BASE_IMAGE=DEBIAN:BUSTER
FROM golang:1.14-buster AS easy-novnc-build
WORKDIR /src
RUN go mod init build && \
    go get github.com/geek1011/easy-novnc@v1.1.0 && \
    go build -o /bin/easy-novnc github.com/geek1011/easy-novnc

FROM ${BASE_IMAGE}

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends openbox tigervnc-standalone-server supervisor gosu && \
    rm -rf /var/lib/apt/lists && \
    mkdir -p /usr/share/desktop-directories

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends lxterminal nano wget openssh-client rsync ca-certificates xdg-utils htop tar xzip gzip bzip2 zip unzip && \
    rm -rf /var/lib/apt/lists

RUN apt-get update && \
#    apt install software-properties-common -y && \
#    add-apt-repository ppa:mozillateam/ppa
#    gedit /etc/apt/preferences.d/mozillateamppa && \
#RUN    apt-get update && \
    apt-get install -y firefox-esr && \
    rm -rf /var/lib/apt/lists

#RUN apt-get update -y && \
#    apt-get install -y --no-install-recommends thunderbird && \
#    rm -rf /var/lib/apt/lists

COPY --from=easy-novnc-build /bin/easy-novnc /usr/local/bin/
#COPY menu.xml /etc/xdg/openbox/
#COPY supervisord.conf /etc/
EXPOSE 8080

RUN groupadd --gid 1000 app && \
    useradd --home-dir /data --shell /bin/bash --uid 1000 --gid 1000 app && \
    mkdir -p /data && \
    mkdir -p /configfiles && \
    touch /configfiles/menu.xml && \
    rm /etc/xdg/openbox/menu.xml && \
    ln -s /configfiles/menu.xml /etc/xdg/openbox/menu.xml && \
    touch /configfiles/supervisord.conf && \
    ln -s /configfiles/supervisord.conf /etc/supervisord.conf

VOLUME /data
VOLUME /configfiles


CMD ["sh", "-c", "chown app:app /data /configfiles /dev/stdout && exec gosu app supervisord"]