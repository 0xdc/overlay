EAPI=6
if [ "$PV" = "9999" ]; then
	EGIT_REPO_URI="https://github.com/StackExchange/blackbox/"
	inherit git-r3
else
	inherit versionator
	MY_P="${PN}-1.${PV}"

	S="${WORKDIR}/${MY_P}"
	SRC_URI="https://github.com/StackExchange/blackbox/archive/v1.${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~x86"
fi

SLOT=0
LICENSE="MIT"
HOMEPAGE="https://github.com/StackExchange/blackbox/"
DESCRIPTION="Safely store secrets in Git/Mercurial/Subversion"

src_compile() {
	# Override default as we do not need to run make
	true;
}

src_install() {
	dobin bin/*

	# There is a Makefile in bin/. Remove it.
	rm -v ${ED}/usr/bin/Makefile

	einstalldocs
}
