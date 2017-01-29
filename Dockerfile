# Use phusion/baseimage as base image. (using latest is bad)
FROM stratolinux/baseimage-docker:0.9.19

# shared volume
VOLUME ["/samba"]
# ports needed
EXPOSE 80


# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# ...put your own build instructions here...
RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold"
RUN apt-get install -y -o Dpkg::Options::="--force-confold" apache2 samba samba-client samba-common


COPY etc/ /etc/

RUN chmod +x /etc/my_init.d/*
RUN find /etc/service -name run -exec chmod +x {} \;

ADD apaxy /root/

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
