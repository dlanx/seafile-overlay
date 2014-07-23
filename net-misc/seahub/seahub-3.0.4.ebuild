# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# Created by Martin Kupec

EAPI=5

AUTOTOOLS_IN_SOURCE_BUILD=1

PYTHON_COMPAT=( python2_7 )
inherit eutils python-single-r1 autotools-utils

DESCRIPTION="Cloud file syncing software"
HOMEPAGE="http://www.seafile.com"
SRC_URI="https://github.com/haiwen/${PN}/archive/v${PV}-server.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="fastcgi"

DEPEND="${PYTHON_DEPS}
	net-misc/seafile[server,${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	fastcgi? ( dev-python/flup )
	"

RDEPEND="${DEPEND}"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

S="${WORKDIR}"/${P}-server

src_install() {
	SEAFILE_PATH="/opt/seafile/seafile-server"
	insinto ${SEAFILE_PATH}
	doins -r ${WORKDIR}/${P}

	elog "Seahub has been installed to ${SEAFILE_PATH}/${P}"
	elog "Follow the instructions from the seafile-wiki to create the configuration files:"
	elog "https://github.com/haiwen/seafile/wiki/Build-and-deploy-seafile-server-from-source#Create_Configurations_with_the_seafileadmin_script"
}
