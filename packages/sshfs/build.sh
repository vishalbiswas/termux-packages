TERMUX_PKG_HOMEPAGE="https://github.com/libfuse/sshfs"
TERMUX_PKG_MAINTAINER="Vishal Biswas @vishalbiswas"
TERMUX_PKG_VERSION=3.3.1
TERMUX_PKG_DESCRIPTION="A network filesystem client to connect to SSH servers"
TERMUX_PKG_SRCURL=https://github.com/libfuse/sshfs/releases/download/sshfs-$TERMUX_PKG_VERSION/sshfs-$TERMUX_PKG_VERSION.tar.xz
TERMUX_PKG_SHA256=de13bfe0eb5821a7d878f8dea3dc815edaee734418e0950c2732399acd4fb443
TERMUX_PKG_DEPENDS="libfuse, glib"

termux_step_pre_configure () {
	termux_setup_meson
	termux_setup_ninja
}

termux_step_make () {
	ninja
}
