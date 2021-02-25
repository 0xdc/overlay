# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="dependencies for gambatte-speedrun game boy emulator"
HOMEPAGE="https://github.com/pokemon-speedrunning/gambatte-speedrun"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"

DEPEND="dev-qt/qtopengl"
RDEPEND="${DEPEND}"
BDEPEND="dev-util/scons"
