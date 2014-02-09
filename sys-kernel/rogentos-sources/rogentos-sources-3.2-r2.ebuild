# Copyright 2004-2010 Kogaion, Argent and ArgOS Linux
# Distributed under the terms of the GNU General Public License v2

ETYPE="sources"
K_SABKERNEL_NAME="rogentos"
K_SABKERNEL_URI_CONFIG="yes"
K_SABKERNEL_SELF_TARBALL_NAME="rogentos"
K_ONLY_SOURCES="1"
K_SABKERNEL_FORCE_SUBLEVEL="0"
inherit rogentos-kernel
KEYWORDS="~amd64 ~x86"
DESCRIPTION="Official Kogaion, Argent and ArgOS Linux Standard kernel sources"
RESTRICT="mirror"
IUSE="sources_standalone"

DEPEND="${DEPEND}
	sources_standalone? ( !=sys-kernel/linux-rogentos-${PVR} )
	!sources_standalone? ( =sys-kernel/linux-rogentos-${PVR} )"

