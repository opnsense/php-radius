dnl $Id$
dnl config.m4 for extension radius

PHP_ARG_ENABLE(radius, whether to enable radius support,
dnl Make sure that the comment is aligned:
[  --enable-radius           Enable radius support])

PHP_ARG_ENABLE(openssl, for OpenSSL support,
[  --enable-openssl   Include OpenSSL support])

if test "$PHP_RADIUS" != "no"; then

  AC_TRY_COMPILE([
#include <sys/types.h>
  ], [
u_int32_t ulongint;
ulongint = 1;
  ], [
    AC_DEFINE(HAVE_U_INT32_T, 1, [ ])
  ])

 PHP_NEW_EXTENSION(radius, radius.c radlib.c, $ext_shared)
fi

if test "$PHP_OPENSSL" != "no"; then
  AC_CHECK_LIB([crypto], [EVP_md5], [
    AC_DEFINE(HAVE_OPENSSL, 1, [ ])
    PHP_ADD_LIBRARY(crypto,, EXT_SHARED_LIBADD)
    PHP_ADD_INCLUDE(/usr/include/openssl)
  ], [
    AC_MSG_ERROR([OpenSSL (libcrypto) not found])
  ])
fi
