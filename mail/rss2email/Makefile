# $NetBSD: Makefile,v 1.52 2020/12/04 20:45:28 nia Exp $

DISTNAME=		rss2email-3.12.2
PKGREVISION=		1
CATEGORIES=		mail python
MASTER_SITES=		${MASTER_SITE_GITHUB:=rss2email/}
GITHUB_TAG=		v${PKGVERSION_NOREV}
DIST_SUBDIR=		${PKGNAME_NOREV}

MAINTAINER=		schmonz@NetBSD.org
HOMEPAGE=		https://github.com/rss2email/rss2email/
COMMENT=		Get RSS feeds emailed to you
LICENSE=		gnu-gpl-v2

DEPENDS+=		${PYPKGPREFIX}-expat-[0-9]*:../../textproc/py-expat
DEPENDS+=		${PYPKGPREFIX}-feedparser>=5.0.1<=6.0.0:../../textproc/py-feedparser5
DEPENDS+=		${PYPKGPREFIX}-html2text>=2014.4.5:../../textproc/py-html2text

PYTHON_VERSIONS_INCOMPATIBLE=	27

REPLACE_PYTHON=		test/test.py

INSTALLATION_DIRS=	${PKGMANDIR}/man1

do-test:
	cd ${WRKSRC} && env PYTHONPATH=.:${PREFIX}/share/html2text ./test/test.py

post-install:
	set -e; cd ${WRKSRC};						\
	${INSTALL_MAN} r2e.1 ${DESTDIR}${PREFIX}/${PKGMANDIR}/man1

.include "../../lang/python/application.mk"
.include "../../lang/python/egg.mk"
.include "../../mk/bsd.pkg.mk"
