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
* dev-db/dbsake
* dev-ml/ocaml-gettext-stub
* x11-misc/pext

# Quickstart
In a root shell:
```bash
emerge -u dev-vcs/git eselect-repository
eselect repository add 0xdc git https://github.com/0xdc/overlay
emaint sync -r 0xdc
eselect profile list
```
