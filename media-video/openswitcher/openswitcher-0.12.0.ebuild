# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Control app for Blackmagic ATEM video switchers"
HOMEPAGE="https://openswitcher.org/"
SRC_URI="https://git.sr.ht/~martijnbraam/pyatem/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

IUSE="X"
REQUIRED_USE="X"

DEPEND="
	>=gui-libs/libhandy-1.0.0
	=media-video/pyatem-${PV}
"
RDEPEND="${DEPEND}"
BDEPEND="
	>=dev-build/meson-0.50.0
	dev-build/meson-format-array
"

S="${WORKDIR}/pyatem-${PV}"

src_configure() {
        local emesonargs=(
		$(meson_use X with_gtk_app)
		-Dwith_proxy=false
		-Dwith_setup_app=false
        )
        meson_src_configure
}
