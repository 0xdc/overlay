# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="A custom launcher for Minecraft"
HOMEPAGE="https://multimc.org/"

LIBNBTPP_SHA=dc72a20b7efd304d12af2025223fad07b4b78464
QUAZIP_SHA=3691d57d3af13f49b2be2b62accddefee3c26b9c

SRC_URI="
	https://github.com/MultiMC/MultiMC5/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/MultiMC/libnbtplusplus/archive/${LIBNBTPP_SHA}.tar.gz -> libnbtplusplus-${LIBNBTPP_SHA}.tar.gz
	https://github.com/MultiMC/quazip/archive/${QUAZIP_SHA}.tar.gz -> quazip-${QUAZIP_SHA}.tar.gz
"

S="${WORKDIR}/MultiMC5-${PV}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
	dev-qt/qtconcurrent
	virtual/jdk
	x11-apps/xrandr
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_unpack() {
	unpack ${A}
	rmdir "${S}/libraries/libnbtplusplus" "${S}/libraries/quazip"
	ln -s "${WORKDIR}/libnbtplusplus-${LIBNBTPP_SHA}" "${S}/libraries/libnbtplusplus"
	ln -s "${WORKDIR}/quazip-${QUAZIP_SHA}" "${S}/libraries/quazip"
}

src_configure() {
	local mycmakeargs=(
		-DMultiMC_LAYOUT=lin-system
	)
	cmake_src_configure
}
