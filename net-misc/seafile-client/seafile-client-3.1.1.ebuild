# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

CMAKE_IN_SOURCE_BUILD=1
PYTHON_COMPAT=( python2_7 )

if [[ $PV = *9999* ]]; then
	scm_eclass=git-r3
	EGIT_REPO_URI="
		git://github.com/haiwen/seafile-client.git
		https://github.com/haiwen/seafile-client.git"
	SRC_URI=""
	KEYWORDS=""
else
	SRC_URI="https://github.com/haiwen/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

inherit ${scm_eclass} eutils python-single-r1 cmake-utils

DESCRIPTION="Cloud file syncing software"
HOMEPAGE="http://www.seafile.com"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="${PYTHON_DEPS}
	dev-db/sqlite:3
	dev-qt/qtcore
	dev-qt/qtdbus
	dev-qt/qtgui
	dev-qt/qtwebkit
	net-libs/ccnet
	net-libs/libsearpc
	dev-libs/openssl
	net-misc/seafile[client,${PYTHON_USEDEP}]
	dev-libs/jansson"

RDEPEND="${DEPEND}"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DOCS=( README.md dev-guide.md )
