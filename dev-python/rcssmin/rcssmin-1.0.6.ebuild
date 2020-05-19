# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )
inherit distutils-r1

DESCRIPTION="CSS minifier aiming for speed instead of maximum compression"
HOMEPAGE="http://opensource.perlig.de/rcssmin/ https://pypi.org/project/rcssmin/"
SRC_URI="http://storage.perlig.de/rcssmin/rcssmin-1.0.6.tar.xz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test doc"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="
	test? ( dev-python/pytest[${PYTHON_USEDEP}] )
	dev-python/setuptools[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
