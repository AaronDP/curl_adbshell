#!/bin/sh
SOFTWARE=curl
SOFTEXT=
if [ 0 -eq 1 ]; then
git clone https://github.com/${SOFTWARE}/${SOFTWARE}
cd ${SOFTWARE}
fi
export DEV_PREFIX=/opt
export ANDROID_NDK=${DEV_PREFIX}/ndk
export CROSS_COMPILE=arm-linux-androideabi
export ANDROID_PREFIX=/tmp/chain
export SYSROOT=${ANDROID_NDK}/platforms/android-17/arch-arm
export CROSS_PATH=${ANDROID_PREFIX}/bin/arm-linux-androideabi
export CPP=${CROSS_PATH}-cpp
export AR=${CROSS_PATH}-ar
export AS=${CROSS_PATH}-as
export NM=${CROSS_PATH}-nm
export CC=${CROSS_PATH}-gcc
export CXX=${CROSS_PATH}-g++
export LD=${CROSS_PATH}-ld
export RANLIB=${CROSS_PATH}-ranlib
export PREFIX=/data/local/tmp
export PKG_CONFIG_PATH=${PREFIX}/lib/pkgconfig
CFLAGS="\
-UHAVE_LOCALE_H 
-fno-exceptions \
-Wno-multichar \
-mthumb \
-mthumb-interwork \
-nostdlib \
--sysroot=${SYSROOT} \
-I${SYSROOT}/usr/include \
-I${ANDROID_PREFIX}/include \
-I${DEV_PREFIX}/android/bionic \
"
CPPFLAGS="${CFLAGS}"
LDFLAGS="\
${LDFLAGS} \
-L${SYSROOT}/usr/lib \
-L${ANDROID_PREFIX}/lib\
"
export ARCH_FLAGS="-march=armv7-a -mfloat-abi=softfp -mfpu=vfpv3-d16"
export ARCH_LINK="-march=armv7-a -Wl,--fix-cortex-a8"
export CFLAGS=" ${ARCH_FLAGS} -fpic -ffunction-sections -funwind-tables -fstack-protector -fno-strict-aliasing -finline-limit=64 "
export CPPFLAGS=" ${ARCH_FLAGS} -fpic -ffunction-sections -funwind-tables -fstack-protector -fno-strict-aliasing -finline-limit=64 "
export CXXFLAGS=" ${ARCH_FLAGS} -fpic -ffunction-sections -funwind-tables -fstack-protector -fno-strict-aliasing -finline-limit=64 -frtti -fexceptions "
export LDFLAGS=" ${ARCH_LINK} "
# $NDK/ndk-build 
if [ 1 -eq 1 ]; then
CROSS_COMPILE=arm-eabi- \
CPPFLAGS="${CPPFLAGS}" \
LDFLAGS="${LDFLAGS}" \
LIBS="-lc -ldl -lm" \
CFLAGS="${CFLAGS}" \
./configure \
CC="${CC}" \
CPPFLAGS="${CPPFLAGS}" \
--with-modified-by="Aaron D. Pierce" \
--with-compiledby="Aaron D. Pierce" \
--with-local-dir=/data/local/tmp/lib/share.curl \
--bindir=/data/local/tmp/xbin \
--disable-nls \
--disable-acl \
--with-sysroot=${SYSROOT} \
--host=arm-linux \
--disable-tftp \
--disable-sspi \
--disable-ipv6 \
--disable-ldaps \
--disable-ldap \
--disable-telnet \
--disable-pop3 \
--disable-ftp \
--disable-imap \
--disable-smtp \
--disable-pop3 \
--disable-rtsp \
--disable-ares \
--without-ca-bundle \
--disable-warnings \
--disable-manual \
--without-nss \
--enable-shared \
--with-zlib=/data/local/tmp/lib \
--with-ssl \
--with-ssl=/data/local/tmp \
--with-ca-path=/data/local/tmp/ssl/certs \
--with-ca-bundle=/data/local/tmp/ssl/certs/ca-bundle.crt \
--without-random \
--includedir=/data/local/tmp/lib/include \
--oldincludedir=/data/local/tmp/lib/include \
--prefix=/data/local/tmp &&  make && make install
# --openssldir=/data/local/tmp/lib \
fi
# ------------------------
#--with-ssl=/data/local/tmp/lib 
#--without-ssl
#--without-zlib
# ------------------------
#cd .. && echo Done
#   -h, --help              display this help and exit
#       --help=short        display options specific to this package
#       --help=recursive    display the short help of all the included packages
#   -V, --version           display version information and exit
#   -q, --quiet, --silent   do not print \`checking ...' messages
#       --cache-file=FILE   cache test results in FILE [disabled]
#   -C, --config-cache      alias for \`--cache-file=config.cache'
#   -n, --no-create         do not create output files
#       --srcdir=DIR        find the sources in DIR [configure dir or \`..']
#   --prefix=PREFIX         install architecture-independent files in PREFIX
#   --exec-prefix=EPREFIX   install architecture-dependent files in EPREFIX
# an installation prefix other than \`$ac_default_prefix' using \`--prefix',
# for instance \`--prefix=\$HOME'.
#   --bindir=DIR            user executables [EPREFIX/bin]
#   --sbindir=DIR           system admin executables [EPREFIX/sbin]
#   --libexecdir=DIR        program executables [EPREFIX/libexec]
#   --sysconfdir=DIR        read-only single-machine data [PREFIX/etc]
#   --sharedstatedir=DIR    modifiable architecture-independent data [PREFIX/com]
#   --localstatedir=DIR     modifiable single-machine data [PREFIX/var]
#   --libdir=DIR            object code libraries [EPREFIX/lib]
#   --includedir=DIR        C header files [PREFIX/include]
#   --oldincludedir=DIR     C header files for non-gcc [/usr/include]
#   --datarootdir=DIR       read-only arch.-independent data root [PREFIX/share]
#   --datadir=DIR           read-only architecture-independent data [DATAROOTDIR]
#   --infodir=DIR           info documentation [DATAROOTDIR/info]
#   --localedir=DIR         locale-dependent data [DATAROOTDIR/locale]
#   --mandir=DIR            man documentation [DATAROOTDIR/man]
#   --docdir=DIR            documentation root [DATAROOTDIR/doc/curl]
#   --htmldir=DIR           html documentation [DOCDIR]
#   --dvidir=DIR            dvi documentation [DOCDIR]
#   --pdfdir=DIR            pdf documentation [DOCDIR]
#   --psdir=DIR             ps documentation [DOCDIR]
#   --program-prefix=PREFIX            prepend PREFIX to installed program names
#   --program-suffix=SUFFIX            append SUFFIX to installed program names
#   --program-transform-name=PROGRAM   run sed PROGRAM on installed program names
#   --build=BUILD     configure for building on BUILD [guessed]
#   --host=HOST       cross-compile to build programs to run on HOST [BUILD]
#   --disable-option-checking  ignore unrecognized --enable/--with options
#   --disable-FEATURE       do not include FEATURE (same as --enable-FEATURE=no)
#   --enable-FEATURE[=ARG]  include FEATURE [ARG=yes]
#   --enable-maintainer-mode  enable make rules and dependencies not useful
#   --enable-silent-rules          less verbose build output (undo: `make V=1')
#   --disable-silent-rules         verbose build output (undo: `make V=0')
#   --enable-debug          Enable debug build options
#   --disable-debug         Disable debug build options
#   --enable-optimize       Enable compiler optimizations
#   --disable-optimize      Disable compiler optimizations
#   --enable-warnings       Enable strict compiler warnings
#   --disable-warnings      Disable strict compiler warnings
#   --enable-werror         Enable compiler warnings as errors
#   --disable-werror        Disable compiler warnings as errors
#   --enable-curldebug      Enable curl debug memory tracking
#   --disable-curldebug     Disable curl debug memory tracking
#   --enable-symbol-hiding  Enable hiding of library internal symbols
#   --disable-symbol-hiding Disable hiding of library internal symbols
#   --enable-hidden-symbols To be deprecated, use --enable-symbol-hiding
#   --disable-hidden-symbols
#                           To be deprecated, use --disable-symbol-hiding
#   --enable-ares[=PATH]    Enable c-ares for DNS lookups
#   --disable-ares          Disable c-ares for DNS lookups
#   --disable-rt            disable dependency on -lrt
#   --disable-dependency-tracking  speeds up one-time build
#   --enable-dependency-tracking   do not reject slow dependency extractors
#   --disable-largefile     omit support for large files
#   --enable-shared[=PKGS]  build shared libraries [default=yes]
#   --enable-static[=PKGS]  build static libraries [default=yes]
#   --enable-fast-install[=PKGS]
#   --disable-libtool-lock  avoid locking (might break parallel builds)
#   --enable-http           Enable HTTP support
#   --disable-http          Disable HTTP support
#   --enable-ftp            Enable FTP support
#   --disable-ftp           Disable FTP support
#   --enable-file           Enable FILE support
#   --disable-file          Disable FILE support
#   --enable-ldap           Enable LDAP support
#   --disable-ldap          Disable LDAP support
#   --enable-ldaps          Enable LDAPS support
#   --disable-ldaps         Disable LDAPS support
#   --enable-rtsp           Enable RTSP support
#   --disable-rtsp          Disable RTSP support
#   --enable-proxy          Enable proxy support
#   --disable-proxy         Disable proxy support
#   --enable-dict           Enable DICT support
#   --disable-dict          Disable DICT support
#   --enable-telnet         Enable TELNET support
#   --disable-telnet        Disable TELNET support
#   --enable-tftp           Enable TFTP support
#   --disable-tftp          Disable TFTP support
#   --enable-pop3           Enable POP3 support
#   --disable-pop3          Disable POP3 support
#   --enable-imap           Enable IMAP support
#   --disable-imap          Disable IMAP support
#   --enable-smb            Enable SMB/CIFS support
#   --disable-smb           Disable SMB/CIFS support
#   --enable-smtp           Enable SMTP support
#   --disable-smtp          Disable SMTP support
#   --enable-gopher         Enable Gopher support
#   --disable-gopher        Disable Gopher support
#   --enable-manual         Enable built-in manual
#   --disable-manual        Disable built-in manual
#   --enable-libcurl-option Enable --libcurl C code generation support
#   --disable-libcurl-option
#                           Disable --libcurl C code generation support
#   --enable-libgcc         use libgcc when linking
#   --enable-ipv6           Enable IPv6 (with IPv4) support
#   --disable-ipv6          Disable IPv6 support
#   --enable-versioned-symbols
#   --disable-versioned-symbols
#   --enable-threaded-resolver
#   --disable-threaded-resolver
#   --enable-verbose        Enable verbose strings
#   --disable-verbose       Disable verbose strings
#   --enable-sspi           Enable SSPI
#   --disable-sspi          Disable SSPI
#   --enable-crypto-auth    Enable cryptographic authentication
#   --disable-crypto-auth   Disable cryptographic authentication
#   --enable-ntlm-wb[=FILE] Enable NTLM delegation to winbind's ntlm_auth
#   --disable-ntlm-wb       Disable NTLM delegation to winbind's ntlm_auth
#   --enable-tls-srp        Enable TLS-SRP authentication
#   --disable-tls-srp       Disable TLS-SRP authentication
#   --enable-unix-sockets   Enable Unix domain sockets
#   --disable-unix-sockets  Disable Unix domain sockets
#   --enable-cookies        Enable cookies support
#   --disable-cookies       Disable cookies support
#   --enable-soname-bump    Enable enforced SONAME bump
#   --disable-soname-bump   Disable enforced SONAME bump
#   --with-PACKAGE[=ARG]    use PACKAGE [ARG=yes]
#   --without-PACKAGE       do not use PACKAGE (same as --with-PACKAGE=no)
#   --with-pic[=PKGS]       try to use only PIC/non-PIC objects [default=use
#   --with-gnu-ld           assume the C compiler uses GNU ld [default=no]
#   --with-sysroot=DIR Search for dependent libraries within DIR
#   --with-zlib=PATH        search for zlib in PATH
#   --without-zlib          disable use of zlib
#   --with-ldap-lib=libname Specify name of ldap lib file
#   --with-lber-lib=libname Specify name of lber lib file
#   --with-gssapi-includes=DIR
#   --with-gssapi-libs=DIR  Specify location of GSS-API libs
#   --with-gssapi=DIR       Where to look for GSS-API
#   --with-winssl           enable Windows native SSL/TLS
#   --without-winssl        disable Windows native SSL/TLS
#   --with-darwinssl        enable iOS/Mac OS X native SSL/TLS
#   --without-darwinssl     disable iOS/Mac OS X native SSL/TLS
#   --with-ssl=PATH         Where to look for OpenSSL, PATH points to the SSL
#   --without-ssl           disable OpenSSL
#   --with-egd-socket=FILE  Entropy Gathering Daemon socket pathname
#   --with-random=FILE      read randomness from FILE (default=/dev/urandom)
#   --with-gnutls=PATH      where to look for GnuTLS, PATH points to the
#   --without-gnutls        disable GnuTLS detection
#   --with-polarssl=PATH    where to look for PolarSSL, PATH points to the
#   --without-polarssl      disable PolarSSL detection
#   --with-mbedtls=PATH     where to look for mbedTLS, PATH points to the
#   --without-mbedtls       disable mbedTLS detection
#   --with-cyassl=PATH      where to look for CyaSSL, PATH points to the
#   --without-cyassl        disable CyaSSL detection
#   --with-nss=PATH         where to look for NSS, PATH points to the
#   --without-nss           disable NSS detection
#   --with-axtls=PATH       Where to look for axTLS, PATH points to the axTLS
#   --without-axtls         disable axTLS
#   --with-ca-bundle=FILE   Path to a file containing CA certificates (example:
#   --without-ca-bundle     Don't use a default CA bundle
#   --with-ca-path=DIRECTORY
#   --without-ca-path       Don't use a default CA path
#   --with-ca-fallback      Use the built in CA store of the SSL library
#   --without-ca-fallback   Don't use the built in CA store of the SSL library
#   --without-libpsl        disable support for libpsl cookie checking
#   --with-libmetalink=PATH where to look for libmetalink, PATH points to the
#   --without-libmetalink   disable libmetalink detection
#   --with-libssh2=PATH     Where to look for libssh2, PATH points to the
#   --without-libssh2       disable LIBSSH2
#   --with-librtmp=PATH     Where to look for librtmp, PATH points to the
#   --without-librtmp       disable LIBRTMP
#   --with-winidn=PATH      enable Windows native IDN
#   --without-winidn        disable Windows native IDN
#   --with-libidn=PATH      Enable libidn usage
#   --without-libidn        Disable libidn usage
#   --with-nghttp2=PATH     Enable nghttp2 usage
#   --without-nghttp2       Disable nghttp2 usage
#   --with-zsh-functions-dir=PATH
#   --without-zsh-functions-dir
