# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

AUTOTOOLS_AUTORECONF=1
AUTOTOOLS_IN_SOURCE_BUILD=1

PYTHON_COMPAT=( python2_7 )
inherit eutils autotools-utils python-single-r1

DESCRIPTION="Networking library for Seafile"
HOMEPAGE="http://www.seafile.com"
SRC_URI="https://github.com/haiwen/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
IUSE="client server python cluster ldap"

CDEPEND="${PYTHON_DEPS}
	=net-libs/libsearpc-${PV}[${PYTHON_USEDEP}]
	dev-libs/glib:2
	>=dev-lang/vala-0.8
	dev-db/libzdb
	dev-libs/libevent"

DEPEND="${CDEPEND}
	virtual/pkgconfig"

RDEPEND="${CDEPEND}"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

src_configure() {
	local mycmakeargs=(
		$(use_enable server)
		$(use_enable client)
		$(use_enable python)
		$(use_enable cluster)
		$(use_enable ldap)
		--enable-console
	)
	autotools-utils_src_configure
}

src_compile() {
	# dev-lang/vala does not provide a valac symlink
	mkdir "${S}"/tmpbin || die
	ln -s $(echo $(whereis valac-) | grep -oE "[^[[:space:]]*$") "${S}"/tmpbin/valac
	PATH="${S}/tmpbin/:$PATH" emake -j1 || die "emake failed"
}
