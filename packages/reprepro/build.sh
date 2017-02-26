TERMUX_PKG_VERSION=5.1.1
TERMUX_PKG_SRCURL=https://alioth.debian.org/frs/download.php/file/4207/reprepro_$TERMUX_PKG_VERSION.orig.tar.gz
TERMUX_PKG_MAINTAINER="Vishal Biswas @vishalbiswas"
TERMUX_PKG_HOMEPAGE=https://mirrorer.alioth.debian.org
TERMUX_PKG_DESCRIPTION="Tool to handle local repositories of debian packages"
TERMUX_PKG_SHA256=fbf1b632e33096845febc6dcb278c4e946272cb6692e2d6c86ca35bb5b1758fc
TERMUX_PKG_FOLDERNAME=reprepro-$TERMUX_PKG_VERSION
TERMUX_PKG_DEPENDS="libdb, libbz2, liblzma, libarchive, pinentry, libgpg-error, gpgme (>= 1.8.0)"
TERMUX_PKG_CLANG=no
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="--with-libgpgme --with-libbz2 --with-liblzma --with-libarchive"

termux_step_pre_configure () {
	CPPFLAGS="$CPPFLAGS -Dindex=strchr -Drindex=strrchr"
	cp $TERMUX_PKG_BUILDER_DIR/netbsd_getpass.c $TERMUX_PKG_SRCDIR/
}
