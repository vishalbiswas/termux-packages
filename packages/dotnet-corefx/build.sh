TERMUX_PKG_HOMEPAGE=https://www.microsoft.com/net/core
TERMUX_PKG_VERSION=2.1.0
TERMUX_PKG_DESCRIPTION=".NET Core foundational libraries, called CoreFX. It includes classes for collections, file systems, console, XML, async and many others"
TERMUX_PKG_SRCURL=https://github.com/dotnet/corefx/archive/v$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_SHA256=524dd0625cc0852111c066ccd395f3f87c18fc51e3365e485e5cd49a89562570
TERMUX_PKG_FOLDERNAME=corefx-$TERMUX_PKG_VERSION
TERMUX_PKG_DEPENDS="openssl, krb5, libcurl, libunwind"
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DCLR_CMAKE_PLATFORM_ANDROID=Android
-DCMAKE_BUILD_TYPE=Release
-DHAVE_CLOCK_MONOTONIC_EXITCODE=0
-DHAVE_CLOCK_REALTIME_EXITCODE=0
-DCLR_CMAKE_PLATFORM_UNIX=1
"

termux_step_pre_configure () {
	echo "static char sccsid[] __attribute__((used)) = \"@(#)No version information produced\";" > $TERMUX_PKG_SRCDIR/src/version.c

	CFLAGS+=" -fintegrated-as"
	CXXFLAGS+=" -I$TERMUX_STANDALONE_TOOLCHAIN/include/c++/4.9.x/ -I$TERMUX_STANDALONE_TOOLCHAIN/include/c++/4.9.x/$TERMUX_HOST_PLATFORM -fintegrated-as"

	TERMUX_PKG_SRCDIR+="/src/Native/Unix"
	TERMUX_PKG_BUILDDIR=$TERMUX_PKG_SRCDIR
}
