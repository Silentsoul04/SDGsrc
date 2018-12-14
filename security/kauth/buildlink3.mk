# $NetBSD: buildlink3.mk,v 1.12 2018/12/09 18:52:07 adam Exp $

BUILDLINK_TREE+=	kauth

.if !defined(KAUTH_BUILDLINK3_MK)
KAUTH_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.kauth+=	kauth>=5.19.0
BUILDLINK_ABI_DEPENDS.kauth?=	kauth>=5.47.0nb4
BUILDLINK_PKGSRCDIR.kauth?=	../../security/kauth
BUILDLINK_CONTENTS_PATTERNS.kauth+=	^qt5/mkspecs/
BUILDLINK_CONTENTS_PATTERNS.kauth+=	^libexec/kauth/

.include "../../devel/kcoreaddons/buildlink3.mk"
.include "../../security/polkit-qt5/buildlink3.mk"
.include "../../x11/qt5-qtbase/buildlink3.mk"
.endif	# KAUTH_BUILDLINK3_MK

BUILDLINK_TREE+=	-kauth
