# $NetBSD: Makefile,v 1.24 2020/09/04 10:13:40 wiz Exp $

DISTNAME=	Archive-Any-0.0946
PKGNAME=	p5-${DISTNAME}
PKGREVISION=	3
CATEGORIES=	archivers perl5
MASTER_SITES=	${MASTER_SITE_PERL_CPAN:=Archive/}

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	https://metacpan.org/release/Archive-Any
COMMENT=	Perl5 module with single interface to deal with archives
LICENSE=	${PERL5_LICENSE}

DEPENDS+=	p5-Archive-Zip>=0:../../archivers/p5-Archive-Zip
DEPENDS+=	p5-File-MMagic>=0:../../misc/p5-File-MMagic
DEPENDS+=	p5-MIME-Types>=0:../../mail/p5-MIME-Types
DEPENDS+=	p5-Module-Find>=0:../../devel/p5-Module-Find

BUILD_DEPENDS+=	p5-Test-Warn>0:../../devel/p5-Test-Warn

PERL5_PACKLIST=		auto/Archive/Any/.packlist

.include "../../lang/perl5/module.mk"
.include "../../mk/bsd.pkg.mk"
