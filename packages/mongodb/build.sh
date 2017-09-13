# Note: don't let the logfile reach >2GB on 32-bits as our off_t is 32-bits
# should probably add a warning on postinst
TERMUX_PKG_HOMEPAGE=https://www.mongodb.com
TERMUX_PKG_DESCRIPTION="A high-performance, open source, schema-free document-oriented database"
TERMUX_PKG_VERSION=3.4.9
TERMUX_PKG_SRCURL=https://fastdl.mongodb.org/src/mongodb-src-r$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_SHA256=2fd0f47a5f9175e71d3d381e81a1b6a2500c9c414dd6ae0940ad6194a0e85549
TERMUX_PKG_DEPENDS="boost, pcre, openssl, libicu"
TERMUX_PKG_MAINTAINER="Vishal Biswas @vishalbiswas"
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_pre_configure () {
	CPPFLAGS="$CPPFLAGS -D__ELF_NATIVE_CLASS=$TERMUX_ARCH_BITS -fdeclspec"
	LDFLAGS="$LDFLAGS -llog"
	local RELEASE="--release --opt=on"
	test -n "$TERMUX_DEBUG" && RELEASE="--dbg=on"
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
