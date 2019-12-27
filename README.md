# overlay
Overlay for Gentoo Linux

# Contents

Profiles:
* amd64
  * (barebones/server)
  * desktop
  * xen (host)
* arm
  * desktop
    * chromebook

Packages:
* app-crypt/blackbox
* app-crypt/tpm2-tss (version bump)
* dev-db/dbsake
* media-tv/plex-media-server
* x11-misc/pext

# Quickstart
In a root shell:
```bash
emerge -u dev-vcs/git eselect-repository
eselect repository add 0xdc git https://github.com/0xdc/overlay
emaint sync -r 0xdc
eselect profile list
```
