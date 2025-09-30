# nfs-server-alpine
[Github Link](https://github.com/janjangao/nfs-server-alpine)

A handy NFS Server image comprising Alpine Linux and NFS v4 only, over TCP on port 2049.

## New Features
- newly built docker image based on `alpine v3.22`, `nfs-utils-2.6.4`: [janjangao/nfs-server-alpine](https://hub.docker.com/r/janjangao/nfs-server-alpine) 
- Support multiple directories with env variables: `SHARED_DIRECTORY_1`, `SHARED_DIRECTORY_2`, `SHARED_DIRECTORY_3` ...
- Support `CROSSMNT`
- Support directory format like `/nfsshare::fsid=1` to append more nfs parameters
- Support export strings with env variables: `NFS_EXPORT_ 1`, `NFS_EXPORT_2` ...

## Overview

### Docker
```
docker run -d \
  --name nfs-server \
  --cap-add SYS_ADMIN \
  -e CROSSMNT=true \
  -e SHARED_DIRECTORY=/storage \
  -e SHARED_DIRECTORY_1=/storage/media:fsid=1 \
  -p 2049:2049 \
  -v /storage:/storage \
  -v /media:/storage/media \
  --restart unless-stopped \
  janjangao/nfs-server-alpine
```
#### Compose
```
services:
  nfs-server:
    image: janjangao/nfs-server-alpine
    container_name: nfs-server
    cap_add:
        - SYS_ADMIN
    environment:
        - CROSSMNT=true
        - SHARED_DIRECTORY=/storage
        - SHARED_DIRECTORY_1=/storage/media:fsid=1
    ports:
      - "2049:2049" 
    volumes:
        - /storage:/storage
        - type: bind 
          source: /media 
          target: /storage/media
          bind: 
            propagation: rslave
    restart: unless-stopped

```

More details refer original [README](https://github.com/sjiveson/nfs-server-alpine)
