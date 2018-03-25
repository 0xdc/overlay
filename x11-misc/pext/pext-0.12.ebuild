EAPI=6

DESCRIPTION="Python-based extendable tool launcher"
HOMEPAGE="https://pext.hackerchick.me/ https://github.com/Pext"
if [[ "${PV}" = "9999" ]]; then
	EGIT_REPO_URI="https://github.com/Pext/Pext"
	inherit git-r3
else
	SRC_URI="https://github.com/Pext/Pext/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~x86"
fi

# Because Pext is capitalised, set S
S="${WORKDIR}/Pext-${PV}"

LICENSE="GPL-3"
SLOT="0"

RDEPEND="
		dev-python/PyQt5
		dev-python/dulwich
"

PYTHON_COMPAT=( python3_{4,5,6} )

inherit distutils-r1
