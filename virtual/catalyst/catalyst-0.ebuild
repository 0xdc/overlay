# Copyright 2020 Daniel Cordero
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Just dependencies for catalyst 3"
HOMEPAGE="https://github.com/0xdc/catalyst https://github.com/0xdc/substrate"

LICENSE="MIT"
SLOT="3"
KEYWORDS="amd64 ~x86 arm ~arm64"

PYTHON_COMPAT=( python3_{6,7,8} )
inherit linux-info python-r1

RDEPEND="
	>=dev-python/snakeoil-0.6.5[${PYTHON_USEDEP}]
	>=dev-python/pydecomp-0.3[${PYTHON_USEDEP}]
	>=dev-python/toml-0.10.0-r1[${PYTHON_USEDEP}]
	!kernel_FreeBSD? ( || ( app-arch/tar[xattr] app-arch/libarchive[xattr] ) )
"

pkg_pretend() {
	local CONFIG_CHECK="~SQUASHFS_LZO"
	check_extra_config
}

pkg_postinst() {
	elog "Install  sys-fs/squashfs-tools[lzo]  to be able to manipulate downloaded snapshots."
}
