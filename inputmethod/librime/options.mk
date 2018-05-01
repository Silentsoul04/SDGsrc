# $NetBSD: options.mk,v 1.1 2014/11/29 09:31:49 obache Exp $
#

PKG_OPTIONS_VAR=		PKG_OPTIONS.librime
PKG_SUPPORTED_OPTIONS=		tests

.include "../../mk/bsd.options.mk"

.if !empty(PKG_OPTIONS:Mtests)
.include "../../devel/googletest/buildlink3.mk"
CMAKE_ARGS+=	-DBUILD_TEST:BOOL=ON
TEST_TARGET=	test
.else
CMAKE_ARGS+=	-DBUILD_TEST:BOOL=OFF
.endif
