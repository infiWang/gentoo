# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="${PN}"-core
MY_P="${MY_PN}"-"${PV}"

inherit cmake

DESCRIPTION="High-performance, full-featured text search engine based off of lucene in C++"
HOMEPAGE="http://clucene.sourceforge.net/"
SRC_URI="mirror://sourceforge/clucene/${MY_P}.tar.gz"

LICENSE="|| ( Apache-2.0 LGPL-2.1 )"
SLOT="1"
KEYWORDS="~alpha amd64 arm arm64 ~hppa ~ia64 ~mips ppc ppc64 ~riscv sparc x86 ~amd64-linux ~x86-linux ~ppc-macos"

IUSE="debug doc static-libs"

BDEPEND="
	doc? ( >=app-doc/doxygen-1.4.2 )
"

RESTRICT="test"

DOCS=(AUTHORS ChangeLog README README.PACKAGE REQUESTS)

S="${WORKDIR}/${MY_PN}-${PV}"

PATCHES=(
	"${FILESDIR}"/clucene-2.3.3.4-fix-clang.patch
	"${FILESDIR}/${P}-contrib.patch"
	"${FILESDIR}/${P}-pkgconfig.patch"
	"${FILESDIR}/${P}-gcc6.patch"
	"${FILESDIR}/${P}-gmtime.patch"
	"${FILESDIR}/${P}-musl-pthread.patch"
)

src_prepare() {
	cmake_src_prepare

	# patch out installing bundled boost headers, we build against system one
	sed -i \
		-e '/ADD_SUBDIRECTORY (src\/ext)/d' \
		CMakeLists.txt || die
	rm -rf src/ext || die
}

src_configure() {
	# Disabled threads: see upstream bug
	# https://sourceforge.net/p/clucene/bugs/197/
	local mycmakeargs=(
		-DENABLE_ASCII_MODE=OFF
		-DENABLE_PACKAGING=OFF
		-DDISABLE_MULTITHREADING=OFF
		-DBUILD_CONTRIBS_LIB=ON
		"-DLIB_DESTINATION=${EPREFIX}/usr/$(get_libdir)"
		-DENABLE_DEBUG=$(usex debug)
		-DENABLE_CLDOCS=$(usex doc)
		-DBUILD_STATIC_LIBRARIES=$(usex static-libs)
	)

	cmake_src_configure
}
