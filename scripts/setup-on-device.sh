#!/data/data/com.termux/files/usr/bin/bash
set -e -u

PACKAGES=""
#PACKAGES+=" ant" # Used by jack and aptsigner.
#PACKAGES+=" asciidoc"
PACKAGES+=" automake"
PACKAGES+=" bison"
PACKAGES+=" clang" # Used by golang, useful to have same compiler building.
PACKAGES+=" curl" # Used for fetching sources.
PACKAGES+=" flex"
#PACKAGES+=" gettext" # Provides 'msgfmt' which the apt build uses.
PACKAGES+=" git" # Used by the neovim build.
#PACKAGES+=" help2man"
#PACKAGES+=" intltool" # Used by qalc build.
PACKAGES+=" gdk-pixbuf-dev" # Provides 'gkd-pixbuf-query-loaders' which the librsvg build uses.
PACKAGES+=" glib-dev" # Provides 'glib-genmarshal' which the glib build uses.
PACKAGES+=" libtool"
PACKAGES+=" lzip"
PACKAGES+=" python"
PACKAGES+=" subversion" # Used by the netpbm build.
PACKAGES+=" tar"
PACKAGES+=" unzip"
PACKAGES+=" m4"
#PACKAGES+=" openjdk-8-jdk" # Used for android-sdk.
PACKAGES+=" pkg-config"
#PACKAGES+=" python-docutils" # For rst2man, used by mpv.
#PACKAGES+=" scons"
PACKAGES+=" texinfo"
#PACKAGES+=" xmlto"
#PACKAGES+=" xutils-dev" # Provides 'makedepend' which the openssl build uses.

# some of these commands are available in busybox, but they are insufficient
PACKAGES+=" patch"
PACKAGES+=" findutils"
PACKAGES+=" coreutils"
PACKAGES+=" autoconf"
PACKAGES+=" sed"
PACKAGES+=" make"
PACKAGES+=" curl"
PACKAGES+=" jack"
PACKAGES+=" grep"
PACKAGES+=" proot" # for termux-chroot

DEBIAN_FRONTEND=noninteractive apt-get install -yq $PACKAGES
pip3 install docutils

mkdir -p /data/data/com.termux/files/usr/local
