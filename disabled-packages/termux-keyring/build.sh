TERMUX_PKG_HOMEPAGE='https://termux.com'
TERMUX_PKG_DESCRIPTION='Termux repository PGP keyring'
TERMUX_PKG_MAINTAINER="Vishal Biswas <vshlbiswas@ymail.com>"
TERMUX_PKG_VERSION=20161028
TERMUX_PKG_BUILD_REVISION=1
TERMUX_PKG_BUILD_IN_SRC=yes
TERMUX_PKG_HOOKSCRIPT_FILE=termux-keyring.install
TERMUX_PKG_ESSENTIAL=true

termux_step_make () {
    return
}

termux_step_make_install () {
    install -dm755 "$TERMUX_PREFIX/share/pacman/keyrings"
    install -m0644 "$TERMUX_PKG_BUILDER_DIR/termux.gpg" "$TERMUX_PREFIX/share/pacman/keyrings/"
    install -m0644 "$TERMUX_PKG_BUILDER_DIR/termux-trusted" "$TERMUX_PREFIX/share/pacman/keyrings/"
}
