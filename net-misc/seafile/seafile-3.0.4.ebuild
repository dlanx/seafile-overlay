# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

AUTOTOOLS_AUTORECONF=1
AUTOTOOLS_IN_SOURCE_BUILD=1

PYTHON_COMPAT=( python2_7 )
inherit eutils python-single-r1 autotools-utils vala

DESCRIPTION="Cloud file syncing software"
HOMEPAGE="http://www.seafile.com"
SRC_URI="https://github.com/haiwen/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="server client python riak fuse"

CDEPEND="${PYTHON_DEPS}
	dev-lang/python[sqlite]
	>=net-libs/ccnet-${PV}[python,${PYTHON_USEDEP}]
	net-libs/libevhtp
	sys-devel/gettext
	dev-libs/jansson
	dev-libs/libevent
	client? ( net-libs/ccnet[client] )
	server? ( 	>=net-libs/ccnet-${PV}[server]
				=dev-python/django-1.5*[${PYTHON_USEDEP}]
				www-servers/gunicorn[${PYTHON_USEDEP}]
				dev-python/simplejson[${PYTHON_USEDEP}]
				dev-python/mako[${PYTHON_USEDEP}]
				dev-python/webpy[${PYTHON_USEDEP}]
				dev-python/Djblets[${PYTHON_USEDEP}]
				dev-python/chardet[${PYTHON_USEDEP}] )"

DEPEND="${CDEPEND}
	virtual/pkgconfig"

RDEPEND="${CDEPEND}"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

PATCHES=( "${FILESDIR}"/vala-fix.patch
	"${FILESDIR}"/make-fix-parallel.patch )

src_prepare() {
	vala_src_prepare
	autotools-utils_src_prepare
}

src_configure() {
	local myeconfargs=(
		$(use_enable fuse)
		$(use_enable riak)
		$(use_enable client)
		$(use_enable server)
		$(use_enable python)
		--enable-server-pkg
		--enable-static-build
	)
	autotools-utils_src_configure
}

src_install() {
	emake DESTDIR="${D}" install
	SEAFILE_SHARE_PATH="/usr/share/seafile"
	insinto ${SEAFILE_SHARE_PATH}/${PV}
	doins -r "${S}"/scripts
	dodoc "${S}"/doc/cli-readme.txt
	doman "${S}"/doc/*.1
}
