# Copyright 2020 Daniel Cordero
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Just dependencies for catalyst 3"
HOMEPAGE="https://github.com/0xdc/catalyst https://github.com/0xdc/substrate"

LICENSE="MIT"
SLOT="3"
KEYWORDS="amd64 ~x86 arm ~arm64"

PYTHON_COMPAT=( python3_{8,9,10,11} )
inherit linux-info python-r1

RDEPEND="
	amd64? (
		app-cdr/cdrtools
		dev-libs/libisoburn
		sys-boot/grub[grub_platforms_pc,grub_platforms_efi-64]
		sys-fs/mtools
		app-emulation/qemu[static-user,qemu_user_targets_arm]
	)
	app-arch/lbzip2
	app-arch/pixz
	>=dev-python/snakeoil-0.6.5[${PYTHON_USEDEP}]
	dev-python/fasteners[${PYTHON_USEDEP}]
	>=dev-python/pydecomp-0.3[${PYTHON_USEDEP}]
	|| (
		app-arch/tar[xattr]
		app-arch/libarchive[xattr]
	)
	sys-apps/util-linux[python,${PYTHON_USEDEP}]
	|| (
		<=sys-fs/squashfs-tools-4.4[xz]
		>=sys-fs/squashfs-tools-4.4_p1[lzma]
	)
"

S="${WORKDIR}"

pkg_pretend() {
	local CONFIG_CHECK="~SQUASHFS_LZO ~SQUASHFS_XZ"
	check_extra_config
}

src_compile() {
	if use amd64; then
		$(tc-getCC) ${CFLAGS} ${LDFLAGS} -static -O3 -o ${WORKDIR}/qemu-wrapper ${FILESDIR}/qemu-wrapper.c
	fi
}

src_install() {
	if use amd64; then
		dobin ${WORKDIR}/qemu-wrapper

		insinto /etc/binfmt.d
		doins ${FILESDIR}/qemu-arm-wrapper.conf
	fi
}
