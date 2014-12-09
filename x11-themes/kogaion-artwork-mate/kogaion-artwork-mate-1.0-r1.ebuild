# Copyright 1999-2012 Sabayon
# Distributed under the terms of the GNU General Public License v2
# Header: $

EAPI=4

inherit gnome2-utils

DESCRIPTION="Kogaion Linux Official MATE artwork"
HOMEPAGE="http://www.rogentos.ro/"
SRC_URI="http://pkg.rogentos.ro/~rogentos/distro/${CATEGORY}/${PN}/"${PN}"-${PV}.tar.gz"
LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""
RDEPEND=">=x11-themes/kogaion-artwork-core-2
	x11-themes/kogaion-light-theme
	x11-themes/kogaion-dark-theme
	x11-themes/faenza-kupertino-icons
	!x11-themes/sabayon-artwork-mate"

S="${WORKDIR}/"

src_install() {
	# Doing overrides. Because we can!
	dodir /usr/share/glib-2.0/schemas
	insinto /usr/share/glib-2.0/schemas
	doins "${FILESDIR}/org.mate.kogaion.gschema.override"
}

pkg_preinst() {
	# taken from gnome2_schemas_savelist
	has ${EAPI:-0} 0 1 2 && ! use prefix && ED="${D}"
	pushd "${ED}" &>/dev/null
	export GNOME2_ECLASS_GLIB_SCHEMAS="/usr/share/glib-2.0/schemas/org.mate.kogaion.gschema.override"
	popd &>/dev/null
}

pkg_postinst() {
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_schemas_update --uninstall
}
