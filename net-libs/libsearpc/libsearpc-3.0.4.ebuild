# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

AUTOTOOLS_AUTORECONF=1
AUTOTOOLS_IN_SOURCE_BUILD=1

PYTHON_COMPAT=( python2_7 )
inherit python-single-r1 autotools-utils

DESCRIPTION="RPC library for Seafile"
HOMEPAGE="http://www.seafile.com"
SRC_URI="https://github.com/haiwen/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
IUSE=""

CDEPEND="${PYTHON_DEPS}
	dev-libs/glib:2
	dev-libs/jansson"

DEPEND="${CDEPEND}
	virtual/pkgconfig"

RDEPEND="${CDEPEND}"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DOCS=( README.markdown ChangeLog AUTHORS NEWS)

src_install() {
	sed -i -e "s/(DESTDIR)//" "${S}"/libsearpc.pc || die
	default
}
