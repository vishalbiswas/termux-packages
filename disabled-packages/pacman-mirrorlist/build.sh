TERMUX_PKG_VERSION=20161017
TERMUX_PKG_HOMEPAGE=https://www.archlinux.org/mirrorlist/
TERMUX_PKG_DESCRIPTION="Arch Linux mirror list for use by pacman"
TERMUX_PKG_BUILD_REVISION=1
TERMUX_PKG_PLATFORM_INDEPENDENT=true
TERMUX_PKG_CONFFILES="etc/pacman.d/mirrorlist"
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_make_install() {
	mkdir -p ${TERMUX_PREFIX}/etc/pacman.d
	install -m644 ${TERMUX_PKG_BUILDER_DIR}/mirrorlist ${TERMUX_PREFIX}/etc/pacman.d/
}
