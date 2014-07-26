# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

CMAKE_IN_SOURCE_BUILD=1
PYTHON_COMPAT=( python2_7 )
inherit eutils python-single-r1 cmake-utils

DESCRIPTION="Cloud file syncing software"
HOMEPAGE="http://www.seafile.com"
SRC_URI="https://github.com/haiwen/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="${PYTHON_DEPS}
	dev-db/sqlite:3
	dev-qt/qtcore
	dev-qt/qtgui
	net-libs/ccnet
	net-libs/libsearpc
	dev-libs/openssl
	net-misc/seafile[client,${PYTHON_USEDEP}]
	dev-libs/jansson"

RDEPEND="${DEPEND}"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DOCS=( README.md dev-guide.md )
