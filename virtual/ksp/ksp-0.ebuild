# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="dependencies for kerbal space program mods"
HOMEPAGE="https://www.kerbalspaceprogram.com/ https://www.kerbalspaceprogram.com/kspstore/app/web/user/login"
SRC_URI=""

LICENSE="All Rights Reserved"
SLOT="0"
KEYWORDS="amd64 ~x86"

DEPEND="
	dev-lang/mono
	|| ( net-misc/netket-telnetd net-misc/telnet-bsd )"
RDEPEND="${DEPEND}"
BDEPEND=""
