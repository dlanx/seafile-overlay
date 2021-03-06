# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils cmake-utils

DESCRIPTION="Flexible replacement for libevent's httpd API"
HOMEPAGE="https://github.com/ellzey/libevhtp/"
SRC_URI="https://github.com/ellzey/libevhtp/archive/${PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="+defer_accept +threads +regex +ssl"

DEPEND="dev-libs/libevent
	>=dev-libs/oniguruma-5.9.2[static-libs]
	threads? ( dev-libs/libevent[threads] )
	ssl? ( dev-libs/libevent[ssl] )"

RDEPEND=""

PATCHES=( "${FILESDIR}"/oniguruma-unbundle.patch )

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_useno defer_accept EVHTP_USE_DEFER_ACCEPT)
		$(cmake-utils_useno threads EVHTP_DISABLE_THREADS)
		$(cmake-utils_useno regex EVHTP_DISABLE_REGEX)
		$(cmake-utils_useno ssl EVHTP_DISABLE_SSL)
	)
	cmake-utils_src_configure
}
