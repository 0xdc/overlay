EAPI=6

DESCRIPTION="Collection of mysql tools"
HOMEPAGE="http://docs.dbsake.net/en/latest/ https://github.com/abg/dbsake"
if [[ "${PV}" = "9999" ]]; then
	EGIT_REPO_URI="https://github.com/abg/dbsake"
	inherit git-r3
else
	SRC_URI="https://github.com/abg/dbsake/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~x86"
fi

LICENSE="GPL-2"
SLOT="0"

PYTHON_COMPAT=( python{2_7,3_5,3_6,3_7,3_8,3_9,3_10,3_11} )

inherit distutils-r1

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/jinja[${PYTHON_USEDEP}]
	dev-python/wheel[${PYTHON_USEDEP}]
"

src_unpack() {
	default
	rm -fr "${WORKDIR}/${P}/tests"
}
