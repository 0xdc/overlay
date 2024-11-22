# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=(python3_{8..13})
inherit distutils-r1

DESCRIPTION="Control library for Blackmagic ATEM video switchers"
HOMEPAGE="https://openswitcher.org/"
SRC_URI="https://git.sr.ht/~martijnbraam/pyatem/archive/${PV}.tar.gz -> openswitcher-${PV}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-python/pyusb[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}"
BDEPEND=""
