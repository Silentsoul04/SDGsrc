# $NetBSD: Makefile,v 1.33 2020/08/31 18:08:40 wiz Exp $

DISTNAME=	Path-Class-0.37
PKGNAME=	p5-${DISTNAME}
PKGREVISION=	4
CATEGORIES=	devel perl5
MASTER_SITES=	${MASTER_SITE_PERL_CPAN:=../../authors/id/K/KW/KWILLIAMS/}

MAINTAINER=	bad@NetBSD.org
HOMEPAGE=	https://metacpan.org/release/Path-Class
COMMENT=	Cross-platform path specification manipulation
LICENSE=	${PERL5_LICENSE}

PERL5_MODULE_TYPE=	Module::Build
PERL5_PACKLIST=		auto/Path/Class/.packlist

#DEPENDS+=	{perl>=5.10.0,p5-PathTools>=3.19}:../../devel/p5-PathTools

.include "../../lang/perl5/module.mk"
.include "../../mk/bsd.pkg.mk"
