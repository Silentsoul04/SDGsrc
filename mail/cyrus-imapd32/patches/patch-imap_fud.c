$NetBSD$

--- imap/fud.c.orig	2020-11-29 23:52:47.000000000 +0000
+++ imap/fud.c
@@ -60,6 +60,7 @@
 #include <netdb.h>
 #include <errno.h>
 #include <pwd.h>
+#include <limits.h>
 
 #include "acl.h"
 #include "mboxlist.h"
@@ -97,7 +98,11 @@ static void send_reply(struct sockaddr *
 static int soc = 0; /* inetd (master) has handed us the port as stdin */
 
 #ifndef MAXLOGNAME
+#  ifdef LOGIN_NAME_MAX
+#define MAXLOGNAME (LOGIN_NAME_MAX - 1)
+#  else
 #define MAXLOGNAME 16           /* should find out for real */
+#  endif
 #endif
 #ifndef MAXDOMNAME
 #define MAXDOMNAME 20           /* should find out for real */
