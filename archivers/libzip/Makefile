# $NetBSD: Makefile,v 1.52 2020/08/31 18:06:30 wiz Exp $

DISTNAME=		libzip-1.7.3
PKGREVISION=		1
CATEGORIES=		archivers devel
MASTER_SITES=		https://libzip.org/download/
MASTER_SITES+=		${MASTER_SITE_GITHUB:=nih-at/}
EXTRACT_SUFX=		.tar.xz
GITHUB_RELEASE=		v${PKGVERSION_NOREV}

MAINTAINER=		wiz@NetBSD.org
HOMEPAGE=		https://www.libzip.org/
COMMENT=		C library to manipulate zip archives
LICENSE=		modified-bsd

USE_CMAKE=		yes
USE_TOOLS+=		perl:build

TEST_TARGET=		test

.include "options.mk"

.include "../../devel/zlib/buildlink3.mk"
.include "../../archivers/bzip2/buildlink3.mk"
.include "../../archivers/xz/buildlink3.mk"
.include "../../mk/bsd.pkg.mk"
