#!@RCD_SCRIPTS_SHELL@
#
# $NetBSD: nlnsd.sh,v 1.1 2019/01/29 14:54:03 ryoon Exp $
#
# PROVIDE: nlnsd
# REQUIRE: NETWORKING SERVERS
# BEFORE: DAEMON
#

. /etc/rc.subr

name="nlnsd"
rcvar=${name}

command=@PREFIX@/sbin/nsd
pidfile=@VARBASE@/run/nsd/nsd.pid
required_files="@PKG_SYSCONFDIR@/nsd.conf"
start_precmd="nsd_precmd"
extra_commands="reload"

nsd_precmd()
{
	if [ ! -d @VARBASE@/run/nsd ]; then
		@MKDIR@ @VARBASE@/run/nsd
		@CHMOD@ 0750 @VARBASE@/run/nsd
		@CHOWN@ @NSD_USER@:@NSD_GROUP@ @VARBASE@/run/nsd
	fi
}

nsd_flags=${nsd_flags:-""}

if [ -f /etc/rc.subr ]; then
	load_rc_config ${name}
	run_rc_command "$1"
else
	echo -n " ${name}"
	${command} ${nsd_flags}
fi
