TERMUX_PKG_HOMEPAGE=https://www.softether.org/
TERMUX_PKG_DESCRIPTION="An open-source cross-platform multi-protocol VPN program"
TERMUX_PKG_LICENSE="Apache-2.0"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=(5.02.5184)
TERMUX_PKG_REVISION=4
TERMUX_PKG_VERSION+=(1.0.19)
TERMUX_PKG_SRCURL=(https://github.com/SoftEtherVPN/SoftEtherVPN/releases/download/${TERMUX_PKG_VERSION}/SoftEtherVPN-${TERMUX_PKG_VERSION}.tar.xz
                   https://github.com/jedisct1/libsodium/archive/${TERMUX_PKG_VERSION[1]}-RELEASE.tar.gz)
TERMUX_PKG_SHA256=(7459f321ec957d160f95ccf5fccc46be6f2c26bd78f0bcdf03d53ae131d051f5
                   4fb996013283f482f46a457c8ff2c1495e797788e78e8ec56b1aa1b19253bf75)
TERMUX_PKG_AUTO_UPDATE=false
TERMUX_PKG_DEPENDS="libiconv, libsodium, ncurses, openssl, readline, resolv-conf, zlib"
TERMUX_PKG_FORCE_CMAKE=true
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DHAS_SSE2=OFF
"
TERMUX_PKG_HOSTBUILD=true
TERMUX_PKG_RM_AFTER_INSTALL="lib/systemd"

termux_step_post_get_source() {
	mv libsodium-${TERMUX_PKG_VERSION[1]}-RELEASE libsodium
}

termux_step_host_build() {
	LDFLAGS+=" -lm"
	local _PREFIX_FOR_BUILD=$TERMUX_PKG_HOSTBUILD_DIR/prefix
	mkdir -p $_PREFIX_FOR_BUILD
	mkdir -p libsodium
	pushd libsodium
	$TERMUX_PKG_SRCDIR/libsodium/configure --prefix=$_PREFIX_FOR_BUILD
	make -j $TERMUX_MAKE_PROCESSES
	make install
	popd

	export PKG_CONFIG_PATH=$_PREFIX_FOR_BUILD/lib/pkgconfig

	termux_setup_cmake
	cmake $TERMUX_PKG_SRCDIR
	make -j $TERMUX_MAKE_PROCESSES

	unset PKG_CONFIG_PATH
}

termux_step_post_configure() {
	export PATH=$TERMUX_PKG_HOSTBUILD_DIR/src/hamcorebuilder:$PATH
}
