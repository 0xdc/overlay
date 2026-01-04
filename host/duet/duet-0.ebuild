EAPI=7

DESCRIPTION="Host-specific files for the Lenovo IdeaPad Duet 3i (10IGL5-LTE)"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~x86"

PDEPEND="
    >=sys-kernel/gentoo-kernel-6.2
    sys-kernel/linux-firmware[savedconfig]
"
S="${WORKDIR}"

src_install() {
    insinto /etc/portage/savedconfig/sys-kernel
    doins ${FILESDIR}/linux-firmware

    insinto /etc/kernel/config.d
    doins ${FILESDIR}/duet.config
}
