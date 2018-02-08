FROM phusion/baseimage:0.10.0
MAINTAINER jamesgol <james@gnuinter.net>
ENV DEBIAN_FRONTEND noninteractive

# Set correct environment variables
ENV HOME /root

# Use baseimage-docker's init system
CMD ["/sbin/my_init"]

# Fix a Debianism of the nobody's uid being 65534
RUN usermod -u 99 nobody && usermod -g 100 nobody

RUN apt-get update && \
    apt-get install -qy software-properties-common && \
    add-apt-repository ppa:deluge-team/ppa && \
    add-apt-repository multiverse

RUN apt-get update -qq && \
    apt-get install -qy deluged deluge-web unrar unzip p7zip && \
    apt-get autoremove -qy && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


#Path to a directory that only contains the deluge.conf
VOLUME /config
VOLUME /downloads

EXPOSE 8112
EXPOSE 58846

RUN mkdir /etc/service/deluged /etc/service/deluge-web
ADD deluged.sh /etc/service/deluged/run
ADD deluge-web.sh /etc/service/deluge-web/run
