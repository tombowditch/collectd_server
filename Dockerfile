FROM phusion/baseimage:bionic-1.0.0

ENV DEBIAN_FRONTEND noninteractive

# configure timezone
RUN echo "Europe/London" > /etc/timezone
RUN rm -f /etc/localtime

# update
RUN apt-get update

# install tzdata
RUN apt-get install tzdata

# reconfig tz
RUN dpkg-reconfigure -f noninteractive tzdata

# install collectd
RUN apt-get install collectd -y --no-install-recommends

RUN rm -f /etc/collectd/collectd.conf

ADD collectd.conf /etc/collectd/collectd.conf

# do CGP stuff
RUN apt-get install php php-cli php-json git rrdtool -y --no-install-recommends

RUN git clone https://github.com/pommi/CGP.git

RUN mv CGP* /www

# cleanup
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# service setup

RUN mkdir /etc/service/collectd
RUN mkdir /etc/service/cgp

COPY services/collectd /etc/service/collectd/run
COPY services/cgp /etc/service/cgp/run

RUN chmod +x /etc/service/collectd/run
RUN chmod +x /etc/service/cgp/run

EXPOSE 25899
EXPOSE 25898
EXPOSE 80

CMD ["/sbin/my_init"]
