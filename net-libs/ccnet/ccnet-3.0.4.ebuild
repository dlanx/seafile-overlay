# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

AUTOTOOLS_AUTORECONF=1
AUTOTOOLS_IN_SOURCE_BUILD=1

PYTHON_COMPAT=( python2_7 )
inherit eutils autotools-utils python-single-r1 vala

DESCRIPTION="Networking library for Seafile"
HOMEPAGE="http://www.seafile.com"
SRC_URI="https://github.com/haiwen/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
IUSE="client demo server python cluster ldap"

CDEPEND="${PYTHON_DEPS}
	~net-libs/libsearpc-${PV}[${PYTHON_USEDEP}]
	dev-libs/glib:2
	dev-lang/vala
	dev-db/libzdb
	dev-db/sqlite:3
	dev-libs/openssl
	dev-libs/libevent
	sys-apps/util-linux"

DEPEND="${CDEPEND}
	virtual/pkgconfig"

RDEPEND="${CDEPEND}"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

PATCHES=( "${FILESDIR}"/valac-fix.patch
	"${FILESDIR}"/make-fix-parallel.patch )

src_prepare() {
	vala_src_prepare
	autotools-utils_src_prepare
}

src_configure() {
	local myeconfargs=(
		$(use_enable server)
		$(use_enable client)
		$(use_enable python)
		$(use_enable cluster)
		$(use_enable demo compile-demo)
		$(use_enable ldap)
		--enable-console
		--disable-server-pkg
		--disable-static-build
	)
	autotools-utils_src_configure
}

pkg_postinst() {
	elog ""
	elog "Please install one of following packages if deploy ccnet locally"
	elog " virtual/mysql"
	elog " dev-db/postgresql-server"
}
