# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="dependencies for multimc minecraft launcher"
HOMEPAGE="https://github.com/MultiMC/MultiMC5"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ~x86"

DEPEND="
	dev-qt/qtconcurrent
	virtual/jdk
	x11-apps/xrandr
"
RDEPEND="${DEPEND}"
BDEPEND="dev-util/cmake"
