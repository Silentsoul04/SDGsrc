$NetBSD$

--- lib/DtSvc/DtEncap/local.c.orig	2018-07-06 18:05:20.000000000 +0000
+++ lib/DtSvc/DtEncap/local.c
@@ -202,7 +202,7 @@ void local_channel_object_input_handler(
   timeout.tv_sec = 0;
   timeout.tv_usec = 0;
   
-#if defined(SVR4) || defined(__hpux) || defined(__OpenBSD__) || defined(__linux__)
+#if defined(SVR4) || defined(__hpux) || defined(__OpenBSD__) || defined(__linux__) || defined(__NetBSD__)
   select(max_fds, (fd_set*)&read_fd_vect, NULL, (fd_set*)&except_fd_vect, &timeout);
 #else
   /* UX has select defined with int*, not fd_set* parms */
