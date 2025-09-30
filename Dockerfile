FROM alpine:latest
LABEL maintainer "janjangao <focussellingcute30years@gmail.com>"
LABEL source "https://github.com/sjiveson/nfs-server-alpine/pull/23"
LABEL issue_30 "https://github.com/sjiveson/nfs-server-alpine/pull/30"

RUN apk add --no-cache --update --verbose nfs-utils bash && \
    rm -rf /var/cache/apk /tmp /sbin/halt /sbin/poweroff /sbin/reboot && \
    mkdir -p /var/lib/nfs/rpc_pipefs /var/lib/nfs/v4recovery && \
    echo "rpc_pipefs    /var/lib/nfs/rpc_pipefs rpc_pipefs      defaults        0       0" >> /etc/fstab && \
    echo "nfsd  /proc/fs/nfsd   nfsd    defaults        0       0" >> /etc/fstab

COPY nfsd.sh /usr/bin/nfsd.sh

RUN chmod +x /usr/bin/nfsd.sh

ENTRYPOINT ["/usr/bin/nfsd.sh"]
