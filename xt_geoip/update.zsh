#!/bin/zsh
#
# This script will update the files in this directory.

typeset -U missing_packages
for i in libtext-csv-xs-perl libnet-cidr-lite-perl; do
	if ! dpkg -s $i >/dev/null 2>/dev/null; then
		missing_packages=($missing_packages $i)
	fi
done
if [[ -n "$missing_packages" ]]; then
	echo "Error: the following package(s) must be installed but apparently aren't: $missing_packages"
	exit 1
fi

[[ -x /usr/bin/chronic ]] && chronic=chronic

echo "Running xt_geoip_dl..."
$chronic /usr/libexec/xtables-addons/xt_geoip_dl

echo "Running xt_geoip_build..."
$chronic /usr/libexec/xtables-addons/xt_geoip_build
