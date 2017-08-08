TERMUX_PKG_HOMEPAGE=https://www.mongodb.com
TERMUX_PKG_DESCRIPTION="A high-performance, open source, schema-free document-oriented database"
TERMUX_PKG_VERSION=3.4.6
TERMUX_PKG_SRCURL=https://fastdl.mongodb.org/src/mongodb-src-r$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_SHA256=8170360f6dfede9c19c131f3d76831e952b3f1494925aa7e2a3a2f95b58ad901
TERMUX_PKG_DEPENDS="boost, pcre, openssl, libicu"
TERMUX_PKG_MAINTAINER="Vishal Biswas @vishalbiswas"
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_pre_configure () {
	CPPFLAGS="$CPPFLAGS -D__ELF_NATIVE_CLASS=$TERMUX_ARCH_BITS -DTERMUX_EXPOSE_FILE_OFFSET64=1"
	LDFLAGS="$LDFLAGS -llog"
	local RELEASE="--release --opt=on"
	test -n "$TERMUX_DEBUG" && RELEASE=""
	export _SCONS_ARGS=( --prefix=$TERMUX_PREFIX
		$RELEASE
		--endian=little
		-j $TERMUX_MAKE_PROCESSES
		--ssl
		--use-system-boost
		--use-system-pcre
		--use-system-zlib
		--use-system-icu
		--allocator=system
		--wiredtiger=off
		--mmapv1=on
		--disable-warnings-as-errors )
}

termux_step_make () {
	scons core tools ${_SCONS_ARGS[@]} \
		CC="$TERMUX_STANDALONE_TOOLCHAIN/bin/$CC" \
		CXX="$TERMUX_STANDALONE_TOOLCHAIN/bin/$CXX" \
		CFLAGS="$CPPFLAGS $CFLAGS" \
		CXXFLAGS="$CPPFLAGS $CXXFLAGS" \
		LINKFLAGS="$LDFLAGS" \
		HOST_ARCH="$TERMUX_ARCH" \
		TARGET_ARCH="$TERMUX_ARCH"
}

termux_step_make_install () {
	scons install ${_SCONS_ARGS[@]} \
		CC="$TERMUX_STANDALONE_TOOLCHAIN/bin/$CC" \
		CXX="$TERMUX_STANDALONE_TOOLCHAIN/bin/$CXX" \
		CFLAGS="$CPPFLAGS $CFLAGS" \
		CXXFLAGS="$CPPFLAGS $CXXFLAGS" \
		LINKFLAGS="$LDFLAGS" \
		HOST_ARCH="$TERMUX_ARCH" \
		TARGET_ARCH="$TERMUX_ARCH"
}

termux_step_post_massage () {
	mkdir -p $TERMUX_PKG_MASSAGEDIR/$TERMUX_PREFIX/var/log/mongodb $TERMUX_PKG_MASSAGEDIR/$TERMUX_PREFIX/var/lib/mongodb/{db,configdb}
}
