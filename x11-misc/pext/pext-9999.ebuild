EAPI=6

DESCRIPTION="Python-based extendable tool launcher"
HOMEPAGE="https://pext.hackerchick.me/ https://github.com/Pext"
EGIT_REPO_URI="https://github.com/Pext/Pext"
if [[ "${PV}" = "9999" ]]; then
	inherit git-r3
else
	SRC_URI="${EGIT_REPO_URI}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~x86"
	# Because Pext is capitalised, set S
	S="${WORKDIR}/Pext-${PV}"
fi


LICENSE="GPL-3"
SLOT="0"

PYTHON_COMPAT=( python3_{7,8,9,10,11} )

PATCHES=( "${FILESDIR}/9999-20210325.patch" )
inherit distutils-r1 eutils

RDEPEND="
		dev-python/PyQt5[${PYTHON_USEDEP},widgets,declarative]
		dev-python/dulwich[${PYTHON_USEDEP}]
		dev-python/pip[${PYTHON_USEDEP}]
		dev-python/psutil[${PYTHON_USEDEP}]
		dev-python/pyopengl[${PYTHON_USEDEP}]
		dev-python/watchdog[${PYTHON_USEDEP}]
		dev-python/paramiko[${PYTHON_USEDEP}]
		dev-python/pynput[${PYTHON_USEDEP}]
		dev-qt/qtquickcontrols
"
