TERMUX_PKG_HOMEPAGE="https://github.com/libfuse/libfuse"
TERMUX_PKG_MAINTAINER="Vishal Biswas @vishalbiswas"
TERMUX_PKG_VERSION=3.2.0
TERMUX_PKG_DESCRIPTION="The reference implementation of the Linux FUSE (Filesystem in Userspace) interface"
TERMUX_PKG_SRCURL=https://github.com/libfuse/libfuse/releases/download/fuse-$TERMUX_PKG_VERSION/fuse-$TERMUX_PKG_VERSION.tar.xz
TERMUX_PKG_SHA256=d11913032cbeaa40c80830bee97a6e7d0d9b1b9a5fbd58b0e4cee51bc19d848c

termux_step_pre_configure () {
	termux_setup_meson
	termux_setup_ninja
}

termux_step_make () {
	ninja
}
