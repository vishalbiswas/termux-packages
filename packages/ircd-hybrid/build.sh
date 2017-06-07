TERMUX_PKG_HOMEPAGE=http://www.ircd-hybrid.org
TERMUX_PKG_VERSION=8.2.22
TERMUX_PKG_SRCURL=http://prdownloads.sourceforge.net/ircd-hybrid/ircd-hybrid-$TERMUX_PKG_VERSION.tgz
TERMUX_PKG_SHA256=d7d8df4524d088132e928d3685f2f65bb7b1bf6c1f855fc9e16a3dc460d9b1c4
TERMUX_PKG_DESCRIPTION="High-performance secure IRC server"
TERMUX_PKG_MAINTAINER="Vishal Biswas @vishalbiswas"
TERMUX_PKG_DEPENDS="openssl, libcrypt, libgnutls"
TERMUX_PKG_CONFFILES="etc/ircd.conf"
# needs *.la for loading modules
TERMUX_PKG_KEEP_STATIC_LIBRARIES=true
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="--enable-gnutls"

termux_step_post_make_install () {
	mv $TERMUX_PREFIX/etc/reference.conf $TERMUX_PREFIX/etc/ircd.conf
}

termux_step_post_massage () {
	mkdir -p ${TERMUX_PKG_MASSAGEDIR}/${TERMUX_PREFIX}/var/log/ircd
}
