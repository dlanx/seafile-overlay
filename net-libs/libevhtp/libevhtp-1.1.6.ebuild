# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# Created by Martin Kupec

EAPI=5

inherit eutils cmake-utils


DESCRIPTION="Flexible replacement for libevent's httpd API"
HOMEPAGE="https://github.com/ellzey/libevhtp/"
SRC_URI="https://github.com/ellzey/libevhtp/archive/${PV}.zip"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="+defer_accept +threads +regex +ssl"

DEPEND="dev-libs/libevent
	threads? ( dev-libs/libevent[threads] )
	ssl? ( dev-libs/libevent[ssl] )"

RDEPEND=""

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_useno defer_accept EVHTP_USE_DEFER_ACCEPT)
		$(cmake-utils_useno threads EVHTP_DISABLE_THREADS)
		$(cmake-utils_useno regex EVHTP_DISABLE_REGEX)
		$(cmake-utils_useno ssl EVHTP_DISABLE_SSL)
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	# prevent collision with oniguruma
	if use regex && has_version dev-libs/oniguruma ; then
		rm ${D}/usr/include/onigposix.h || die
	fi
}
