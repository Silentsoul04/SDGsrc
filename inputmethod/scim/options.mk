# $NetBSD: options.mk,v 1.2 2017/09/26 10:02:21 wiz Exp $
#

PKG_OPTIONS_VAR=		PKG_OPTIONS.scim
PKG_OPTIONS_NONEMPTY_SETS=	gtk
PKG_OPTIONS_SET.gtk=		gtk2 gtk3
PKG_SUPPORTED_OPTIONS=		qt4
PKG_SUGGESTED_OPTIONS=		gtk2 gtk3

PLIST_VARS+=	gtk2 gtk3 qt4

.include "../../mk/bsd.options.mk"

.if !empty(PKG_OPTIONS:Mgtk2)
GTK2_IMMODULES=		yes
.include "../../x11/gtk2/modules.mk"
CONFIGURE_ARGS+=	--enable-gtk2-immodule
PLIST.gtk2=		yes
.else
CONFIGURE_ARGS+=	--enable-gtk2-immodule=no
.endif

.if !empty(PKG_OPTIONS:Mgtk3)
GTK3_IMMODULES=		yes
.include "../../x11/gtk3/modules.mk"
CONFIGURE_ARGS+=	--enable-gtk3-immodule
PLIST.gtk3=		yes
.else
CONFIGURE_ARGS+=	--enable-gtk3-immodule=no
.endif

.if !empty(PKG_OPTIONS:Mqt4)
.include "../../x11/qt4-libs/buildlink3.mk"
CONFIGURE_ARGS+=	--enable-qt4-immodule
CONFIGURE_ARGS+=	--with-qt4-im-module-dir=${QTDIR}/plugins/inputmethods
PLIST.qt=		yes
.else
CONFIGURE_ARGS+=	--disable-qt4-immodule
.endif

.if !empty(PKG_OPTIONS:Mgtk3)
CONFIGURE_ARGS+=	--with-gtk-version=3
.include "../../x11/gtk3/buildlink3.mk"
.else
CONFIGURE_ARGS+=	--with-gtk-version=2
.include "../../x11/gtk2/buildlink3.mk"
.endif
