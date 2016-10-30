TERMUX_PKG_HOMEPAGE=https://www.archlinux.org/pacman/
TERMUX_PKG_DESCRIPTION="A library-based package manager with dependency support"
# TERMUX_PKG_MAINTAINER="Francisco Demartino @franciscod" #original maintainer
TERMUX_PKG_MAINTAINER="Vishal Biswas <vshlbiswas@ymail.com>"

# HEAVILY adapted from archlinux PKGBUILD
TERMUX_PKG_VERSION=5.0.1
TERMUX_PKG_BUILD_REVISION=4
#FIXME: fakechroot/fakeroot
TERMUX_PKG_DEPENDS="bash, libarchive, curl, gpgme, python2, libandroid-glob, libandroid-support, openssl-tool, pacman-mirrorlist"
TERMUX_PKG_CONFLICTS="pacman-contrib"
TERMUX_PKG_REPLACES="pacman-contrib"
TERMUX_PKG_SRCURL="https://sources.archlinux.org/other/pacman/pacman-${TERMUX_PKG_VERSION}.tar.gz"
TERMUX_PKG_SHA256="8BD5F407CE8E05C4BE8F1C4BE4D8DCC8550EA5E494937DA5220EA2C23CBB8E04"

# if it is ever implemented
TERMUX_PKG_MD5="377a2664d6007d72d6d8a126add83bcf"
TERMUX_PKG_MAKE_DEPENDS="asciidoc"
TERMUX_PKG_CHECK_DEPENDS="python2, fakechroot"
TERMUX_PKG_KEEP_EMPTY=true
TERMUX_PKG_LICENSE=GPL
TERMUX_PKG_GROUPS="base, base-devel"

TERMUX_PKG_EXTRA_CONFIGURE_ARGS=" --prefix=${TERMUX_PREFIX} --sysconfdir=${TERMUX_PREFIX}/etc"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS+=" --localstatedir=${TERMUX_PREFIX}/var --enable-doc "
TERMUX_PKG_EXTRA_CONFIGURE_ARGS+=" --with-scriptlet-shell=${TERMUX_PREFIX}/bin/bash "
TERMUX_PKG_EXTRA_CONFIGURE_ARGS+=" --disable-shared --enable-static "
TERMUX_PKG_EXTRA_CONFIGURE_ARGS+=" --with-pkg-ext=.pkg.tar.xz --with-openssl --with-gpgme --with-libcurl "

TERMUX_PKG_CLANG=no
TERMUX_PKG_CONFFILES="etc/pacman.conf etc/makepkg.conf"

termux_step_pre_configure() {
  LDFLAGS="$LDFLAGS -llog -landroid-glob"
  CFLAGS="$CFLAGS -DLINE_MAX=_POSIX2_LINE_MAX -Wl,-pie"
  
  # required in makepkg
  export DUPATH="$TERMUX_PREFIX/bin/du"
}

termux_step_make () {
  make V=1
  make -C contrib
}

termux_step_check () {
#  make -C "pacman-${TERMUX_PKG_VERSION}" check
  return
}

termux_step_make_install () {

  make install
  make -C contrib install

  # install Arch specific stuff
  install -dm755 "${TERMUX_PREFIX}/etc"
  install -m644 "${TERMUX_PKG_BUILDER_DIR}/pacman.conf" "${TERMUX_PREFIX}/etc/pacman.conf"
  sed -i "s#@TERMUX_PREFIX@#${TERMUX_PREFIX}#g" "$TERMUX_PREFIX/etc/pacman.conf"

  mycarch="${TERMUX_ARCH}"
  mychost="${TERMUX_HOST_PLATFORM}"
  myflags=" -march=${TERMUX_ARCH}"


  # set things correctly in the default conf file
  install -m644 "${TERMUX_PKG_BUILDER_DIR}/makepkg.conf" "${TERMUX_PREFIX}/etc/makepkg.conf"
  sed -i "${TERMUX_PREFIX}/etc/makepkg.conf" \
    -e "s|@CARCH[@]|$mycarch|g" \
    -e "s|@CHOST[@]|$mychost|g" \
    -e "s|@CARCHFLAGS[@]|$myflags|g" \
    -e "s|@TERMUX_PREFIX@|$TERMUX_PREFIX|g"
  sed -i "${TERMUX_PREFIX}/etc/pacman.conf" -e "s|@CARCH[@]|$mycarch|g"

  # put bash_completion in the right location
  install -dm755 "${TERMUX_PREFIX}/share/bash-completion/completions"
  mv "${TERMUX_PREFIX}/etc/bash_completion.d/pacman" "${TERMUX_PREFIX}/share/bash-completion/completions"
  rmdir "${TERMUX_PREFIX}/etc/bash_completion.d" || true

  for f in makepkg pacman-key; do
    test -e "$TERMUX_PREFIX/share/bash-completion/completions/$f" || ln -s pacman "${TERMUX_PREFIX}/share/bash-completion/completions/$f"
  done

  install -Dm644 ${TERMUX_PKG_SRCDIR}/contrib/PKGBUILD.vim "${TERMUX_PREFIX}/share/vim/vimfiles/syntax/PKGBUILD.vim"

  # pacman does not automatically create var/lib/pacman
  install -dm755 ${TERMUX_PREFIX}/var/lib/pacman/
}
