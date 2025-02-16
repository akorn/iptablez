prefix = /usr/local

all:
	

install:
	mkdir -p $(DESTDIR)$(prefix)/share/iptablez/
	mkdir -p $(DESTDIR)$(prefix)/share/iptablez/xt_geoip
	mkdir -p $(DESTDIR)$(prefix)/sbin
	mkdir -p $(DESTDIR)/etc/iptablez
	mkdir -p $(DESTDIR)/etc/iptablez/acl.d
	mkdir -p $(DESTDIR)/etc/iptablez/conf.d
	mkdir -p $(DESTDIR)/etc/iptablez/ipset.d
	mkdir -p $(DESTDIR)/etc/iptablez/post.d
	mkdir -p $(DESTDIR)/etc/iptablez/script.d

	install functions $(DESTDIR)$(prefix)/share/iptablez/
	install build-ipset-from-log $(DESTDIR)$(prefix)/share/iptablez/
	install build-ipset-of-legit-clients $(DESTDIR)$(prefix)/share/iptablez/
	install ipset-blacklist-using-blocklist-de $(DESTDIR)$(prefix)/share/iptablez/

	install iptablez $(DESTDIR)$(prefix)/sbin/

	install acl.d/martian $(DESTDIR)/etc/iptablez/acl.d/
	install acl.d/silentdrop-input $(DESTDIR)/etc/iptablez/acl.d/
	install acl.d/usefulicmp $(DESTDIR)/etc/iptablez/acl.d/

	install conf.d/antiportscan $(DESTDIR)/etc/iptablez/conf.d/
	install conf.d/ipset-max-timeout $(DESTDIR)/etc/iptablez/conf.d/
	install conf.d/limit-icmp-forward $(DESTDIR)/etc/iptablez/conf.d/
	install conf.d/limit-icmp-in $(DESTDIR)/etc/iptablez/conf.d/
	install conf.d/limit-icmp-out $(DESTDIR)/etc/iptablez/conf.d/
	install conf.d/limit-log $(DESTDIR)/etc/iptablez/conf.d/
	install conf.d/limit-tcp-rst-forward $(DESTDIR)/etc/iptablez/conf.d/
	install conf.d/limit-tcp-rst-out $(DESTDIR)/etc/iptablez/conf.d/
	install conf.d/reject $(DESTDIR)/etc/iptablez/conf.d/
	install conf.d/smtp_greylist_time $(DESTDIR)/etc/iptablez/conf.d/

	install ipset.d/blacklisted $(DESTDIR)/etc/iptablez/ipset.d/
	install ipset.d/private_nets $(DESTDIR)/etc/iptablez/ipset.d/

	install post.d/100-iptables-save $(DESTDIR)/etc/iptablez/post.d/

	install script.d/000restore-ipsets $(DESTDIR)/etc/iptablez/script.d/
	install script.d/050set-logtarget $(DESTDIR)/etc/iptablez/script.d/
	install script.d/100antiportscan $(DESTDIR)/etc/iptablez/script.d/
	install script.d/200blacklisted $(DESTDIR)/etc/iptablez/script.d/
	install script.d/200by-country $(DESTDIR)/etc/iptablez/script.d/
	install script.d/200icmp_forward $(DESTDIR)/etc/iptablez/script.d/
	install script.d/200icmp_input $(DESTDIR)/etc/iptablez/script.d/
	install script.d/200icmp_output $(DESTDIR)/etc/iptablez/script.d/
	install script.d/200log_accept $(DESTDIR)/etc/iptablez/script.d/
	install script.d/200log_drop $(DESTDIR)/etc/iptablez/script.d/
	install script.d/200martian $(DESTDIR)/etc/iptablez/script.d/
	install script.d/200silentdrop $(DESTDIR)/etc/iptablez/script.d/
	install script.d/200smtp $(DESTDIR)/etc/iptablez/script.d/

	install xt_geoip/README $(DESTDIR)$(prefix)/share/iptablez/xt_geoip/
	install xt_geoip/update.zsh $(DESTDIR)$(prefix)/share/iptablez/xt_geoip/

clean:
	
