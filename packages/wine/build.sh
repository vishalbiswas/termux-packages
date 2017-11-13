TERMUX_PKG_HOMEPAGE=https://www.winehq.org/
TERMUX_PKG_DESCRIPTION="Windows API implementation"
TERMUX_PKG_VERSION=2.0.3
TERMUX_PKG_SRCURL=https://dl.winehq.org/wine/source/2.0/wine-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=a811c664f870a3a01449443a93a6fcee41aea2e912e58f72742eb7924962be56
TERMUX_PKG_DEPENDS="ncurses, libpng"
TERMUX_PKG_MAINTAINER="Pierre Rudloff <contact@rudloff.pro>"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="--disable-tests --with-wine-tools=${TERMUX_PKG_HOSTBUILD_DIR} --without-x --without-freetype --without-pcap ac_cv_header_resolv_h=no"
TERMUX_PKG_HOSTBUILD="yes"
TERMUX_PKG_EXTRA_HOSTBUILD_CONFIGURE_ARGS="--disable-tests --without-alsa --without-capi --without-cms --without-coreaudio --without-cups --without-curses --without-dbus --without-fontconfig --without-freetype --without-gettext --without-gphoto --without-glu --without-gnutls --without-gsm --without-gstreamer --without-hal --without-jpeg --without-ldap --without-mpg123 --without-netapi --without-openal --without-opencl --without-opengl --without-osmesa --without-oss --without-pcap --without-png --without-pthread --without-pulse --without-sane --without-tiff --without-v4l --without-xcomposite --without-xcursor --without-xinerama --without-xinput --without-xinput2 --without-xml --without-xrandr --without-xrender --without-xshape --without-xshm --without-xslt --without-xxf86vm --without-zlib"

termux_step_host_build () {
	$TERMUX_PKG_SRCDIR/configure ${TERMUX_PKG_EXTRA_HOSTBUILD_CONFIGURE_ARGS}
	for tool in tools/*; do make -j ${TERMUX_MAKE_PROCESSES} $tool; done
}
