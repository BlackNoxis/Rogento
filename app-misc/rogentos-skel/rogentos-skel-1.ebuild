# Copyright 1999-2012 Sabayon Linux and Rogentos Linux
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
EGIT_REPO_URI="git://github.com/BlackNoxis/roskel.git"

inherit eutils git-2 fdo-mime

DESCRIPTION="Rogentos Linux skel tree"
HOMEPAGE="http://www.rogentos.ro/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""
RDEPEND=""

src_install () {
	dodir /etc/xdg/menus
	cp "${S}"/* "${D}"/etc/ -Ra
	chown root:root "${D}"/etc/skel -R

	insinto /etc/bash/ || die "Failed to insinto"
	doins "${S}"/skel/.bash/bashrc /etc/bash/ || die "Cannot copy bashrc"

	insinto /etc/grub.d/ || die "Failed to insinto"
	doins "${S}"/skel/.grub.d/10_linux /etc/grub.d/ || die "Cannot copy 10 linux"

	insinto /etc/default/ || die "Failed to insinto"
	doins "${S}"/skel/.default/grub /etc/default/grub || die "Cannot copy grub"
}
