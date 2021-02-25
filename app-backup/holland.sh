#!/bin/bash

PV=$1

COPYRIGHT_YEAR="$(date +%Y)"
PN=holland
LIBS=" common lvm mysql "
PLUGINS=" example mariabackup mongodump mysql_lvm mysqldump pgdump random sqlite tar xtrabackup "
PYTHON="python2_7 python3_{3,4,5,6,7,8,9}"

for lib in $LIBS; do
	dir="${PN}-lib-${lib}"
	ebuild="${dir}/${dir}-${PV}.ebuild"
	test -d "${dir}" || mkdir "${dir}"

	tee "$ebuild" <<-EOF
	# Copyright 1999-${COPYRIGHT_YEAR} Gentoo Foundation
	# Distributed under the terms of the GNU General Public License v2

	EAPI=6
	PYTHON_COMPAT=( ${PYTHON} )

	inherit distutils-r1

	DESCRIPTION="Holland ${lib} Library"
	EOF
	tee -a "$ebuild" <<-'EOF'
	HOMEPAGE="http://www.hollandbackup.org"
	MY_P="holland-${PV}"
	SRC_URI="https://github.com/holland-backup/holland/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz"
	LICENSE="GPL-2"
	SLOT="0"
	KEYWORDS="~amd64 ~x86"
	IUSE=""

	DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
	RDEPEND="~app-backup/holland-${PV}[${PYTHON_USEDEP}]"

	S="${WORKDIR}/${MY_P}/plugins/${PN//-/.}"
	EOF

	ebuild $ebuild manifest
done

for plugin in $PLUGINS; do
	dir="${PN}-backup-${plugin}"
	ebuild="${dir}/${dir}-${PV}.ebuild"
	test -d "${dir}" || mkdir "${dir}"

	tee "$ebuild" <<-EOF
	# Copyright 1999-${COPYRIGHT_YEAR} Gentoo Foundation
	# Distributed under the terms of the GNU General Public License v2

	EAPI=6
	PYTHON_COMPAT=( ${PYTHON} )

	inherit distutils-r1

	DESCRIPTION="Holland ${plugin} Plugin"
	EOF

	tee -a "$ebuild" <<-'EOF'
	RDEPEND="
		app-arch/gzip
		~app-backup/holland-${PV}[${PYTHON_USEDEP}]
		~app-backup/holland-lib-common-${PV}[${PYTHON_USEDEP}]
		dev-python/iniparse[${PYTHON_USEDEP}]
	EOF
	test "$plugin" = "*mysql*" && tee -a "$ebuild" <<<'                ~app-backup/holland-lib-common-${PV}[${PYTHON_USEDEP}]'
	
	tee -a "$ebuild" <<-'EOF'
	"
	HOMEPAGE="http://www.hollandbackup.org/"
	MY_P="holland-${PV}"
	SRC_URI="https://github.com/holland-backup/holland/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz"
	LICENSE="GPL-2"
	SLOT="0"
	KEYWORDS="~amd64 ~x86"
	IUSE=""

	DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

	S="${WORKDIR}/${MY_P}/plugins/${PN//-/.}"

	python_install_all() {
		distutils-r1_python_install_all

		insinto /etc/holland/backupsets
		doins "${WORKDIR}/${MY_P}/config/backupsets/examples/${PN##*-}.conf"

		insinto /etc/holland/providers
		doins "${WORKDIR}/${MY_P}/config/providers/${PN##*-}.conf"
	}
	EOF

	ebuild $ebuild manifest
done

dir="${PN}-backup-mysql-meta"
ebuild="${dir}/${dir}-${PV}.ebuild"
test -d "${dir}" || mkdir "${dir}"

tee "$ebuild" <<EOF
# Copyright 1999-${COPYRIGHT_YEAR} Gentoo Foundation
EOF
tee -a "$ebuild" <<'EOF'
# Distributed under the terms of the GNU General Public License v2

EAPI=6
EOF

tee -a "$ebuild" <<EOF
PYTHON_COMPAT=( ${PYTHON} )
EOF

tee -a "$ebuild" <<'EOF'
inherit python-r1

DESCRIPTION="Holland MySQL"
HOMEPAGE="http://www.hollandbackup.org/"
SRC_URI=""
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="lvm +mysqldump mysqlhotcopy"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="
        ${PYTHON_DEPS}
        =app-backup/holland-${PV}[${PYTHON_USEDEP}]
        lvm? ( ~app-backup/holland-backup-mysql-lvm-${PV}[${PYTHON_USEDEP}] )
        mysqldump? ( ~app-backup/holland-backup-mysqldump-${PV}[${PYTHON_USEDEP}] )
        mysqlhotcopy? ( ~app-backup/holland-backup-mysqlhotcopy-${PV}[${PYTHON_USEDEP}] )
"
EOF

ebuild $ebuild manifest


dir="${PN}"
ebuild="${dir}/${dir}-${PV}.ebuild"
test -d "${dir}" || mkdir "${dir}"

tee "$ebuild" <<EOF
# Copyright 1999-${COPYRIGHT_YEAR} Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( ${PYTHON} )

inherit distutils-r1

EOF
tee -a "$ebuild" <<'EOF'
DESCRIPTION="Holland Backup"
HOMEPAGE="http://www.hollandbackup.org/"
SRC_URI="https://github.com/holland-backup/holland/archive/v${PV}.tar.gz -> holland-${PV}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples +mysql postgres sqlite"

DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )
"
RDEPEND="
	mysql? ( ~app-backup/holland-backup-mysql-meta-${PV}[${PYTHON_USEDEP}] )
	postgres? ( ~app-backup/holland-backup-pgdump-${PV}[${PYTHON_USEDEP}] )
	sqlite? ( ~app-backup/holland-backup-sqlite-${PV}[${PYTHON_USEDEP}] )
	examples? (
		~app-backup/holland-backup-example-${PV}[${PYTHON_USEDEP}]
		~app-backup/holland-backup-random-${PV}[${PYTHON_USEDEP}]
	)
"

python_compile_all() {
	use doc && emake -C docs html
}

python_install_all() {
	use doc && local HTML_DOCS=( docs/build/html/. )

	distutils-r1_python_install_all

	keepdir /var/log/holland

	keepdir /etc/holland/providers

	insinto /etc/holland
	doins config/holland.conf

	insinto /etc/holland/backupsets
	doins config/backupsets/default.conf

	doman docs/man/holland.1
}
EOF
ebuild $ebuild manifest
