# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR=KAZEBURO
DIST_VERSION=0.25
DIST_EXAMPLES=( "eg/*" )
inherit perl-module

DESCRIPTION="PSGI compliant HTTP Entity Parser"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~arm64 ~ia64 ppc ppc64 ~riscv sparc x86"
IUSE="+xs"

RDEPEND="
	virtual/perl-Encode
	virtual/perl-File-Temp
	dev-perl/HTTP-MultiPartParser
	dev-perl/Hash-MultiValue
	>=dev-perl/JSON-MaybeXS-1.3.7
	virtual/perl-Module-Load
	dev-perl/Stream-Buffered
	>=dev-perl/WWW-Form-UrlEncoded-0.230.0
	xs? ( >=dev-perl/WWW-Form-UrlEncoded-XS-0.230.0 )
"
BDEPEND="${RDEPEND}
	>=dev-perl/Module-Build-Tiny-0.35.0
	test? (
		virtual/perl-File-Spec
		>=dev-perl/HTTP-Message-6
		>=virtual/perl-Test-Simple-0.980.0
	)
"
