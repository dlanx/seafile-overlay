# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# Created by Martin Kupec

EAPI=5

AUTOTOOLS_IN_SOURCE_BUILD=1

PYTHON_COMPAT=( python2_7 )
inherit eutils python-single-r1 autotools-utils

DESCRIPTION="Cloud file syncing software"
HOMEPAGE="http://www.seafile.com"
SRC_URI="https://github.com/haiwen/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="${PYTHON_DEPS}
	net-misc/seafile[client,${PYTHON_USEDEP}]
	dev-libs/jansson"

RDEPEND=""

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

src_configure() {
	:
}

src_compile() {
	cmake . || die "src_compile failed"
	emake -j1 || die "emake failed"
}
