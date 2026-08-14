FROM docker.io/almalinux/9-base:9.5-20250307

COPY alice-system-deps.repo /etc/yum.repos.d/
COPY packages /home/
RUN dnf install -y epel-release dnf-plugins-core && \
    dnf update -y && \
    dnf config-manager --set-enabled crb && \
    dnf group install -y 'Development Tools' && \
    dnf update -y && \
    dnf install -y alice-o2-full-deps alibuild && \
    dnf install -y $(cat /home/packages) && \
    dnf clean all && \
    rm -rf /var/cache/yum && \
    wget -O /usr/local/bin/direnv https://github.com/direnv/direnv/releases/download/v2.37.1/direnv.linux-arm64 && \
    chmod +x /usr/local/bin/direnv