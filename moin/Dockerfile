FROM ubuntu:16.04
MAINTAINER Masato Shimizu <ma6ato@gmail.com>

ENV HOME /root
ENV WORKDIR /root
ENV MOIN_VERSION 1.9.9
ENV EURO_VERSION 3995afe116b0

RUN apt-get update && \
    apt-get install -y python nginx uwsgi uwsgi-plugin-python wget unzip

RUN wget http://static.moinmo.in/files/moin-$MOIN_VERSION.tar.gz -P /tmp && \
    tar xzf /tmp/moin-$MOIN_VERSION.tar.gz -C /tmp && \
    cd /tmp/moin-$MOIN_VERSION && \
    python setup.py install --force --prefix=/usr/local

RUN wget https://bitbucket.org/thesheep/moin-europython/get/$EURO_VERSION.zip -P /tmp && \
    unzip /tmp/$EURO_VERSION.zip -d /tmp && \
    cd /tmp/thesheep* && \
    cp europython.py /usr/local/share/moin/data/plugin/theme && \
    cp -R /usr/local/lib/python2.7/dist-packages/MoinMoin/web/static/htdocs /usr/local/share/moin/htdocs && \
    mkdir /usr/local/share/moin/htdocs/europython && \
    cp -R css img /usr/local/share/moin/htdocs/europython

RUN mkdir -p /data/moin/pages /data/moin/user

ADD nginx.conf /etc/nginx/sites-available/default
ADD run-moinmoin.sh /run-moinmoin.sh
ADD run.sh /run.sh

EXPOSE 80 443
VOLUME ["/data"]
CMD ["/run-moinmoin.sh"]

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

