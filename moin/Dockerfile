FROM ubuntu:18.04
MAINTAINER Masato Shimizu <ma6ato@gmail.com>

ENV HOME /root
ENV WORKDIR /root
ENV MOIN_VERSION 1.9.9

RUN apt update && \
    apt install -y python nginx uwsgi uwsgi-plugin-python wget unzip

RUN wget http://static.moinmo.in/files/moin-$MOIN_VERSION.tar.gz -P /tmp && \
    tar xzf /tmp/moin-$MOIN_VERSION.tar.gz -C /tmp && \
    cd /tmp/moin-$MOIN_VERSION && \
    python setup.py install --force --prefix=/usr/local

RUN    cp -R /usr/local/lib/python2.7/dist-packages/MoinMoin/web/static/htdocs /usr/local/share/moin/htdocs

RUN mkdir -p /data/moin/pages /data/moin/user

ADD nginx.conf /etc/nginx/sites-available/default
ADD run-moinmoin.sh /run-moinmoin.sh
ADD run.sh /run.sh

EXPOSE 80 443
VOLUME ["/data"]
CMD ["/run-moinmoin.sh"]

RUN apt clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

