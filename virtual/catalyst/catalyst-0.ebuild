# Copyright 2020 Daniel Cordero
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Just dependencies for catalyst 3"
HOMEPAGE="https://github.com/0xdc/catalyst https://github.com/0xdc/substrate"

LICENSE="MIT"
SLOT="3"
KEYWORDS="amd64 ~x86 arm ~arm64"

PYTHON_COMPAT=( python3_{8,9} )
inherit linux-info python-r1

RDEPEND="
	amd64? (
		app-cdr/cdrtools
		dev-libs/libisoburn
		sys-boot/grub[grub_platforms_pc,grub_platforms_efi-64]
		sys-fs/mtools
	)
	app-arch/lbzip2
	app-arch/pixz
	>=dev-python/snakeoil-0.6.5[${PYTHON_USEDEP}]
	>=dev-python/pydecomp-0.3[${PYTHON_USEDEP}]
	>=dev-python/toml-0.10.0-r1[${PYTHON_USEDEP}]
	!kernel_FreeBSD? ( || ( app-arch/tar[xattr] app-arch/libarchive[xattr] ) )
	sys-apps/util-linux[python,${PYTHON_USEDEP}]
	sys-fs/squashfs-tools[xz]
"

pkg_pretend() {
	local CONFIG_CHECK="~SQUASHFS_LZO ~SQUASHFS_XZ"
	check_extra_config
}
