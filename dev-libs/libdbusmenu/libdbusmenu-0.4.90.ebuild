# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libdbusmenu/libdbusmenu-0.3.16-r2.ebuild,v 1.1 2011/02/07 09:56:46 tampakrap Exp $

EAPI=3

inherit autotools eutils versionator virtualx

MY_MAJOR_VERSION="$(get_version_component_range 1-2)"
if version_is_at_least "${MY_MAJOR_VERSION}.50" ; then
	MY_MAJOR_VERSION="$(get_major_version).$(($(get_version_component_range 2)+1))"
fi

DESCRIPTION="Library to pass menu structure across DBus"
HOMEPAGE="https://launchpad.net/dbusmenu"
SRC_URI="http://launchpad.net/dbusmenu/${MY_MAJOR_VERSION}/${PV}/+download/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk +introspection test vala"

RDEPEND="dev-libs/glib:2
	dev-libs/dbus-glib
	dev-libs/libxml2:2
	gtk? ( x11-libs/gtk+:2 )"
DEPEND="${RDEPEND}
	introspection? ( >=dev-libs/gobject-introspection-0.6.7 )
	test? (
		>=dev-libs/json-glib-0.13.4[introspection=]
		dev-util/dbus-test-runner
	)
	vala? ( dev-lang/vala:0.12 )
	dev-util/intltool
	dev-util/pkgconfig"

pkg_setup() {
	if use vala && use !introspection ; then
		eerror "Vala bindings (USE=vala) require introspection support (USE=introspection)"
		die "Vala bindings (USE=vala) require introspection support (USE=introspection)"
	fi
}

src_prepare() {
	# Make Vala bindings optional, launchpad-bug #713685
	epatch "${FILESDIR}/${PN}-0.3.16-optional-vala.patch"
	# Make tests optional, launchpad-bug #552526
	epatch "${FILESDIR}/${PN}-0.3.16-optional-tests.patch"
	# Make libdbusmenu-gtk library optional, launchpad-bug #552530
	epatch "${FILESDIR}/${P}-optional-gtk.patch"
	# Decouple testapp from libdbusmenu-gtk, launchpad-bug #709761
	epatch "${FILESDIR}/${PN}-0.3.94-decouple-testapp.patch"
	# Make dbusmenudumper optional, launchpad-bug #643871
	epatch "${FILESDIR}/${PN}-0.3.14-optional-dumper.patch"
	# Fixup undeclared HAVE_INTROSPECTION, launchpad-bug #552538
	epatch "${FILESDIR}/${PN}-0.3.14-fix-aclocal.patch"
	# Drop -Werror in a release
	sed -e 's:-Werror::g' -i libdbusmenu-glib/Makefile.am libdbusmenu-gtk/Makefile.am || die "sed failed"
	eautoreconf
}

src_configure() {
	VALA_API_GEN=$(type -p vapigen-0.12) \
		econf \
		$(use_enable gtk) \
		$(use_enable gtk dumper) \
		$(use_enable introspection) \
		$(use_enable test tests) \
		$(use_enable vala)
}

src_test() {
	Xemake check || die "testsuite failed"
}

src_install() {
	emake DESTDIR="${ED}" install || die "make install failed"
	dodoc AUTHORS || die "dodoc failed"
}
