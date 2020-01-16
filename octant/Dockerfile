FROM opsforge/kubetools:latest

MAINTAINER opsforge.io
LABEL type="thick"

# OS fixes and additions

USER root

# Ubuntu package installs

RUN mkdir -p /tmp

RUN cd /tmp && \
    curl -o octant.deb -kL https://github.com/vmware-tanzu/octant/releases/download/$(curl -s https://github.com/vmware-tanzu/octant/releases/latest | sed 's/^.*tag\///' | sed 's/\".*$//')/octant_$(curl -s https://github.com/vmware-tanzu/octant/releases/latest | sed 's/^.*tag\///' | sed 's/\".*$//' | sed 's/v//' )_Linux-64bit.deb && \
    dpkg -i octant.deb

# Cleanup

RUN rm -rf /tmp/*

# Entrypoint

COPY entrypoint.sh /root/entrypoint.sh
RUN chmod +x /root/entrypoint.sh

SHELL ["/bin/bash", "-c"]
CMD ["/root/entrypoint.sh"]