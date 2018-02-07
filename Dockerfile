FROM phusion/baseimage:0.10.0
MAINTAINER jamesgol <james@gnuinter.net>
ENV DEBIAN_FRONTEND noninteractive

# Set correct environment variables
ENV HOME /root

# Fix a Debianism of the nobody's uid being 65534
RUN usermod -u 99 nobody && usermod -g 100 nobody

RUN apt-get update && \
    apt-get install -qy software-properties-common && \
    add-apt-repository ppa:deluge-team/ppa && \
    add-apt-repository multiverse && \
    apt-get remove -qy software-properties-common && \
    apt-get autoremove -qy

RUN apt-get update -qq && \
    apt-get install -qy deluged deluge-web unrar unzip p7zip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


#Path to a directory that only contains the deluge.conf
VOLUME /config
VOLUME /downloads

EXPOSE 8112
EXPOSE 58846

ADD run.sh /run.sh

ENTRYPOINT ["/bin/bash", "/run.sh"]
