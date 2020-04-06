# Copyright 2020 Daniel Cordero
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Just dependencies for catalyst 3"
HOMEPAGE="https://github.com/0xdc/catalyst https://github.com/0xdc/substrate"

LICENSE="MIT"
SLOT="3"
KEYWORDS="amd64 ~x86 arm ~arm64"

PYTHON_COMPAT=( python3_{6,7,8} )
inherit python-r1

RDEPEND="
	>=dev-python/snakeoil-0.6.5[${PYTHON_USEDEP}]
	>=dev-python/pydecomp-0.3[${PYTHON_USEDEP}]
	app-arch/lbzip2
	>=sys-fs/squashfs-tools-2.1[xz]
	!kernel_FreeBSD? ( || ( app-arch/tar[xattr] app-arch/libarchive[xattr] ) )
"
