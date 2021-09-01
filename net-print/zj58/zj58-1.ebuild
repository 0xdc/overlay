# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="CUPS driver for Zijiang 58mm thermal printers"
HOMEPAGE="https://github.com/adafruit/zj-58"
SRC_URI="https://github.com/adafruit/zj-58/archive/refs/heads/master.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0/adafruit"
KEYWORDS="~amd64 ~x86"

DEPEND="net-print/cups"
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/zj-58-master"

src_install() {
	dodoc README.md

	exeinto /usr/lib/cups/filter
	doexe rastertozj

	insinto /usr/share/cups/model/zjiang
	doins ZJ-58.ppd
}
