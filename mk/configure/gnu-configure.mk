# $NetBSD: gnu-configure.mk,v 1.22 2019/10/06 09:44:41 rillig Exp $
#
# Package-settable variables:
#
# GNU_CONFIGURE
#	Whether the package has a GNU-style configure script as the
#	primary means of configuring itself to the platform.
#
#	Possible: yes no
#	Default: undefined
#
# GNU_CONFIGURE_STRICT
#	Whether unknown --enable/--disable/--with/--without options make
#	the package fail immediately.
#
#	Command line options that are unknown for all configure scripts
#	of a package are effectively ignored and should be replaced with
#	their current equivalent (in case they have been renamed), or
#	otherwise be removed.
#
#	This check may incorrectly report unknown options for packages
#	that have multiple configure scripts, when one of these scripts
#	recognizes the option and some other doesn't. To check this, run
#	"bmake show-unknown-configure-options" after the package failed.
#
#	Possible: yes no warn
#	Default: no
#	See also: configure-help show-unknown-configure-options
#
# Keywords: configure configure_args gnu strict enable disable

_VARGROUPS+=			gnu-configure
_USER_VARS.gnu-configure=	# none
_PKG_VARS.gnu-configure=	\
	GNU_CONFIGURE GNU_CONFIGURE_STRICT GNU_CONFIGURE_PREFIX \
	SET_LIBDIR GNU_CONFIGURE_LIBSUBDIR \
	GNU_CONFIGURE_LIBDIR GNU_CONFIGURE_INFODIR GNU_CONFIGURE_MANDIR \
	CONFIGURE_HAS_LIBDIR CONFIGURE_HAS_MANDIR CONFIGURE_HAS_INFODIR \
	OVERRIDE_DIRDEPTH.configure \
	USE_GNU_CONFIGURE_HOST

HAS_CONFIGURE=			defined
OVERRIDE_GNU_CONFIG_SCRIPTS=	defined
INSTALL_SH_OVERRIDE?=		# empty

CONFIGURE_ENV+=	CONFIG_SHELL=${CONFIG_SHELL:Q}
CONFIGURE_ENV+=	LIBS=${LIBS:M*:Q}
CONFIGURE_ENV+=	ac_given_INSTALL=${INSTALL:Q}\ -c\ -o\ ${BINOWN}\ -g\ ${BINGRP}

.if (defined(USE_LIBTOOL) || !empty(PKGPATH:Mdevel/libtool-base)) && \
    defined(_OPSYS_MAX_CMDLEN_CMD)
CONFIGURE_ENV+=	lt_cv_sys_max_cmd_len=${_OPSYS_MAX_CMDLEN_CMD:sh}
.endif

.if ${OPSYS} == "MirBSD"
CONFIGURE_ENV+=	lt_cv_deplibs_check_method='match_pattern /lib[^/]+(\.so\.[0-9]+\.[0-9]+|\.so|_pic\.a)$$'
.endif

GNU_CONFIGURE_PREFIX?=	${PREFIX}
CONFIGURE_ARGS+=	--prefix=${GNU_CONFIGURE_PREFIX:Q}

.if (defined(SET_LIBDIR) && !empty(SET_LIBDIR)) || \
	(defined(GNU_CONFIGURE_LIBDIR) && !empty(GNU_CONFIGURE_LIBDIR)) || \
	(defined(GNU_CONFIGURE_LIBSUBDIR) && !empty(GNU_CONFIGURE_LIBSUBDIR))
CONFIGURE_HAS_LIBDIR=	yes
.else
CONFIGURE_HAS_LIBDIR?=	no
.endif
.if defined(GNU_CONFIGURE_LIBSUBDIR) && !empty(GNU_CONFIGURE_LIBSUBDIR)
GNU_CONFIGURE_LIBDIR?=	${GNU_CONFIGURE_PREFIX}/lib/${GNU_CONFIGURE_LIBSUBDIR}
.else
GNU_CONFIGURE_LIBDIR?=	${GNU_CONFIGURE_PREFIX}/lib
.endif
.if !empty(CONFIGURE_HAS_LIBDIR:M[Yy][Ee][Ss])
CONFIGURE_ARGS+=	--libdir=${GNU_CONFIGURE_LIBDIR}
.endif

USE_GNU_CONFIGURE_HOST?=	yes
.if !empty(USE_GNU_CONFIGURE_HOST:M[yY][eE][sS])
.  if !empty(USE_CROSS_COMPILE:M[yY][eE][sS])
CONFIGURE_ARGS+=	--build=${NATIVE_MACHINE_GNU_PLATFORM:Q}
.  else
CONFIGURE_ARGS+=	--build=${MACHINE_GNU_PLATFORM:Q}
.  endif
CONFIGURE_ARGS+=	--host=${MACHINE_GNU_PLATFORM:Q}
.endif

# PKGINFODIR is the subdirectory of ${PREFIX} into which the info
# files are installed unless the software was configured with an
# installation prefix other than ${PREFIX}.
#
CONFIGURE_HAS_INFODIR?=	yes
.if ${GNU_CONFIGURE_PREFIX} == ${PREFIX}
GNU_CONFIGURE_INFODIR?=	${GNU_CONFIGURE_PREFIX}/${PKGINFODIR}
.else
GNU_CONFIGURE_INFODIR?=	${GNU_CONFIGURE_PREFIX}/info
.endif
.if defined(INFO_FILES) && !empty(CONFIGURE_HAS_INFODIR:M[yY][eE][sS])
CONFIGURE_ARGS+=	--infodir=${GNU_CONFIGURE_INFODIR:Q}
.endif

# PKGMANDIR is the subdirectory of ${PREFIX} into which the man and
# catman pages are installed unless the software was configured with
# an installation prefix other than ${PREFIX}.
#
CONFIGURE_HAS_MANDIR?=	 yes
.if ${GNU_CONFIGURE_PREFIX} == ${PREFIX}
GNU_CONFIGURE_MANDIR?=	${GNU_CONFIGURE_PREFIX}/${PKGMANDIR}
.else
GNU_CONFIGURE_MANDIR?=	${GNU_CONFIGURE_PREFIX}/man
.endif
.if !empty(CONFIGURE_HAS_MANDIR:M[yY][eE][sS])
CONFIGURE_ARGS+=	--mandir=${GNU_CONFIGURE_MANDIR:Q}
.endif

# prevent to invoke unwanted autoheader with patched configure.ac
.if empty(USE_TOOLS:Mautoheader*)
MAKE_FLAGS+=	am__configure_deps=
.endif

GNU_CONFIGURE_STRICT?=	warn
.if ${GNU_CONFIGURE_STRICT:M[yY][eE][sS]}
CONFIGURE_ARGS+=	--enable-option-checking=fatal
.elif ${GNU_CONFIGURE_STRICT} == warn
CONFIGURE_ARGS+=	--enable-option-checking=yes
.endif

# Inspects the configure scripts of a package to see whether there are
# multiple configure scripts, and one of them reports an option as
# unrecognized while some other still needs it.
#
# This target is expected to be called manually, after a package failed
# to configure because of the GNU_CONFIGURE_STRICT check.
#
# See also: GNU_CONFIGURE_STRICT configure-help
#
# Keywords: GNU_CONFIGURE_STRICT configure-help
show-unknown-configure-options: .PHONY
	${RUN} ${MAKE} patch
	${RUN} ${RM} -f ${_COOKIE.configure}
	@${STEP_MSG} "Running configure scripts silently"
	${RUN} ${MAKE} configure GNU_CONFIGURE_STRICT=warn 2>&1		\
	| ${AWK} -f ${PKGSRCDIR}/mk/configure/gnu-configure-unknown.awk
	${RUN} ${RM} -f ${_COOKIE.configure}
