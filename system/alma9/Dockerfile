# AlmaLinux 9 with systemd support
FROM almalinux:9

ENV container=docker
STOPSIGNAL SIGRTMIN+3

# Install systemd and a few service diagnostics
RUN dnf -y update && \
    dnf -y install --allowerasing systemd systemd-udev dbus dnf-plugins-core \
                   procps-ng iproute iputils \
                   vim less curl wget \
    && dnf clean all && rm -rf /var/cache/dnf

# Clean systemd machine-id to avoid duplicates
RUN rm -f /etc/machine-id && touch /etc/machine-id

# systemd needs these dirs
VOLUME [ "/sys/fs/cgroup" ]

# Default to systemd
CMD ["/usr/sbin/init"]
