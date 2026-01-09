EAPI=7

DESCRIPTION="Host-specific files for the Lenovo IdeaPad Duet 3i (10IGL5-LTE)"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~x86"

inherit linux-info

BDEPEND="sys-kernel/installkernel"
PDEPEND="
    >=sys-kernel/gentoo-kernel-6.2
    sys-kernel/linux-firmware[savedconfig]
"

S="${FILESDIR}"

pkg_pretend() {
    local CONFIG_CHECK="
        MMC_SDHCI_PCI
        MMC_BLOCK

        ~MISC_RTSX_PCI
        ~PINCTRL_GEMINILAKE
        ~IOSM
        ~USB_VIDEO_CLASS
    "
    check_extra_config
}

src_install() {
    insinto /etc/portage/savedconfig/sys-kernel
    doins linux-firmware

    insinto /etc/kernel/config.d
    doins duet.config

    insinto /etc
    doins dracut.conf

    insinto /etc/portage/patches/gentoo-kernel
    doins 10IGL5-LTE_screen_quirk.patch
}
