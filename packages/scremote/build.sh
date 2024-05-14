# http(s) link to package home page.
TERMUX_PKG_HOMEPAGE=https://scremote.local

# One-line, short package description.
TERMUX_PKG_DESCRIPTION="scremote lib"

# License.
# Use SPDX identifier: https://spdx.org/licenses/
#TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_LICENSE_FILE="mylic.lic"
# Who cares about package.
# Specify yourself (Github nick, or name + email) if you wish to maintain the
# package, fix its bugs, etc. Otherwise specify "@termux".
# Please note that unofficial repositories are not allowed to reference @termux
# as their maintainer.
TERMUX_PKG_MAINTAINER="normtut@yandex.ru"

# Version.
TERMUX_PKG_VERSION=1.0

# URL to archive with source code.
TERMUX_PKG_SRCURL=http://192.168.1.189:8000/scremote.tar.gz

# SHA-256 checksum of the source code archive.
TERMUX_PKG_SHA256=553d340c6092a14bfa70d60d50a84b07369b21ffbabe3e4b1546b86af9f1a2ea

TERMUX_PKG_EXTRA_MAKE_ARGS="scremote"

TERMUX_CMAKE_BUILD="Unix Makefiles"
termux_step_make_install() {
	mkdir -p $TERMUX_PREFIX/etc/reader.conf.d
	SCREMOTE_READER_FNAME=$TERMUX_PREFIX/etc/reader.conf.d/scremote
	cat > $SCREMOTE_READER_FNAME <<- EOM
DEVICENAME        /dev/null
FRIENDLYNAME      "scremote_reader"
LIBPATH           $TERMUX_PREFIX/opt/utmlibs/libscremote.so

EOM

	mkdir -p  $TERMUX_PREFIX/opt/utmlibs/
	cp $TERMUX_PKG_BUILDDIR/libscremote.so $TERMUX_PREFIX/opt/utmlibs/
}

# TERMUX_CMAKE_BUILD="Ninja"
# TERMUX_PKG_EXTRA_CONFIGURE_ARGS="VERBOSE=1"
