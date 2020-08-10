FROM ubuntu:20.04

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

# cleanup
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


EXPOSE 25899
EXPOSE 25898
CMD ["/usr/sbin/collectd", "-f"]
