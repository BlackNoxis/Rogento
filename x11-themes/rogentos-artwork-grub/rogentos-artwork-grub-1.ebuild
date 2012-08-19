# Copyright 2004-2012 Sabayon
# Copyright 2012 Rogentos
# Distributed under the terms of the GNU General Public License v2
# Maintainer BlackNoxis <stefan.cristian at rogentos.ro>

EAPI=4

inherit base mount-boot

DESCRIPTION="Rogentos GRUB2 Images"
HOMEPAGE="http://www.rogentos.ro"
SRC_URI="http://dl.dropbox.com/u/1338709/${CATEGORY}/${PN}/${PN}-${PVR}.tar.gz"
LICENSE="CCPL-Attribution-ShareAlike-3.0"
SLOT="0"

KEYWORDS="~amd64 ~x86"
IUSE=""
RDEPEND=""

S="${WORKDIR}"

src_install () {
	dodir /usr/share/grub
	insinto /usr/share/grub
	doins default-splash.png
}

pkg_postinst() {
	local dir="${ROOT}"boot/grub
	cp "${ROOT}/usr/share/grub/default-splash.png" "${dir}/default-splash.png" || \
		ewarn "cannot install default splash file!"
}
