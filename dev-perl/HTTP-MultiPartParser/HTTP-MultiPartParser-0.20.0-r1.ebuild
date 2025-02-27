# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR=CHANSEN
DIST_VERSION=0.02
DIST_EXAMPLES=("eg/*")
inherit perl-module

DESCRIPTION="Low Level MultiPart MIME HTTP parser"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~arm64 ~ia64 ppc ppc64 ~riscv sparc x86"

RDEPEND="
	virtual/perl-Carp
	virtual/perl-Scalar-List-Utils
"
BDEPEND="${RDEPEND}
	>=virtual/perl-ExtUtils-MakeMaker-6.590.0
	test? (
		dev-perl/Test-Deep
		>=virtual/perl-Test-Simple-0.880.0
	)
"
