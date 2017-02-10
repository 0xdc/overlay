EAPI=6

DESCRIPTION="Collection of mysql tools"
HOMEPAGE="http://docs.dbsake.net/en/latest/ https://github.com/abg/dbsake"
if [[ "${PV}" = "9999" ]]; then
	EGIT_REPO_URI="https://github.com/abg/dbsake"
	inherit git-r3
else
	SRC_URI="https://github.com/abg/dbsake/archive/${PV}.tar.gz"
	KEYWORDS=""
fi

LICENSE="GPL-2"
SLOT="0"

RDEPEND="
	dev-python/click
	dev-python/wheel
"

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3,3_4,3_5} )

inherit distutils-r1
