EAPI=6

DESCRIPTION="Collection of mysql tools"
HOMEPAGE="http://docs.dbsake.net/en/latest/ https://github.com/abg/dbsake"
SRC_URI="https://github.com/abg/dbsake/archive/${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~arm ~amd64"

RDEPEND="
	dev-python/click
	dev-python/wheel
"

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3,3_4,3_5} )

inherit distutils-r1
