iptablez
========

A collection of zsh functions and scriptlets to help build maintainable
iptables rulesets

The Problem
===========

iptables/netfilter is "procedural". You have to compile a ruleset adding
rules one by one.

There are several approaches:

 * Create the ruleset from the command line directly. Optionally save using
   iptables-save and restore on boot. Not really maintainable.

 * Write a script to set up the rules for you. Problems: firewall is in
   indeterminate state while rules are being added. Scripts have a tendency
   to become byzantine. There are lots of repetitive elements. No good
   separation of "code" and "configuration" (such as access control lists).

 * Use some frontend like shorewall that abstracts away the iptables syntax
   in favour of its own, declarative one. Problem: doesn't necessarily
   expose all the flexibility of iptables/netfilter.

My solution
===========

Using these zsh scripts, the firewall setup can be split into several small
files: you can have files that define access control lists, files that set
up configuration variables (such as symbolic names for IP addresses), and
files that set up the effective rules (e.g. one chain per file, or whatever
makes sense).

You can use (almost) the full power of the iptables command line, but
instead of invoking iptables(8) directly, the script wraps it in a shell
function; it builds a rule file loadable atomically by iptables-restore,
avoiding any indeterminate state during initialisation.

There are many helper functions for common tasks like granting access to a
service to a set of source IPs or ranges, denying others, and logging
refused attempts subject to a rate limit; or getting the IP of an interface;
etc. You're encouraged to browse the functions file.

Some example scriptlets are provided, for example to automatically block IPs
that try to connect to {IP, port, protocol} tuples you know don't host a
service.

Usage
=====

Create /etc/iptablez/{conf,acl,ipset,script,pre,post}.d directories.

Symlink iptablez and functions into /etc/iptablez.

Create scriptlets in conf.d, script.d and post.d (optional).

Create ACL files in acl.d (one entry per line; empty lines ignored; comments
starting with # supported; recursive includes supported: ". file" includes
"file"; shell variables will be expanded, so you can do "-s $MYSERVER").

In conf.d files, you can look up names in DNS and assign the IPs to names in
the following way:

```
get_ip_of some.hostname.here <default.ip> SHELL_VARIABLE
```

Example:

```
get_ip_of www.microsoft.com 2.17.245.133 WWW_MICROSOFT_COM
```

There is a disk-backed DNS cache with a configurable TTL; DNS lookups only
actually happen if your firewall config references the `SHELL_VARIABLE`
anywhere (so you can share conf.d snippets among hosts); and SHELL_VARIABLE
is guaranteed to contain an IP, because the default IP is assigned to it if
the lookup fails.

Call /etc/iptablez/iptablez to build and load your ruleset.

Dependencies
============

 * iptables (obviously).

 * zsh (obviously). Versions older than 5.0 may not work.

 * sed.

 * `tryto(1)` from the socklog package is used by some of the functions to
   enforce timeouts.

 * `dnsip(1)` from the djbdns package and `dig(1)` from the bind9-dnsutils
   package is needed by some of the functions.

 * installing the `moreutils` Debian package is recommended but not
   required (the `ifdata(8)` tool is used if it's available).

Limitations
===========

Adding rules that reference hostnames that resolve to more than one IP will
almost certainly not work at all (although the `get_ip_of() function will at
least return one of the IPs the name resolved to). Workaround: look up the
IPs beforehand and add rules using a loop.

TODO
====

 * Provide more and better examples, perhaps even a complete configuration.

 * Add ipv6 support (patches welcome).

 * Maybe add some helper functions for ip/tc?

 * Add support for tables other than filter, nat and mangle (probably not a
   big deal).

 * Review the code in functions. I wrote some of it in the early 2000's and
   would probably do it differently now.
 
   * Improve the matching in get_ports_of() (can currently match anywhere on
     line, not just process name).

-- 
András Korn, 2013-08-24
