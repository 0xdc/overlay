# overlay
Overlay for Gentoo Linux

# Quickstart
In a root shell:
```bash
emerge dev-vcs/git
mkdir /etc/portage/repos.conf/
wget -O/etc/portage/repos.conf/0xdc.conf https://github.com/0xdc/overlay/raw/master/metadata/repos.conf
emaint sync -r 0xdc
eselect profile list
```
