#! /bin/sh
#
# slapd.sh
# Copyright (C) 2015 Hannes
#
#

set -eu
status() {
    echo "---> ${@}" >&2
}

#set -x
#: LDAP_ROOTPASS=${LDAP_ROOTPASS}
#: LDAP_DOMAIN=${LDAP_DOMAIN}
#: LDAP_ORGANISATION=${LDAP_ORGANISATION}

if [ ! -e /var/lib/ldap/docker_bootstrapped ]; then
        status "configuring slapd for first run"
        echo 'olcRootPW: {SSHA}MgK38HL8XMp0d95f6BR7TTlNe3IGf5xJ' >> '/etc/openldap/slapd.d/cn=config/olcDatabase={2}hdb.ldif'
        sed -i 's/dc=my-domain,dc=com/dc=nas,dc=l3/'                 '/etc/openldap/slapd.d/cn=config/olcDatabase={2}hdb.ldif'
        sed -i 's/dc=my-domain,dc=com/dc=nas,dc=l3/'                '/etc/openldap/slapd.d/cn=config/olcDatabase={1}monitor.ldif'
        touch /var/lib/ldap/docker_bootstrapped
      else
          status "found already-configured slapd"
fi

status "starting slapd"
set -x
exec /usr/sbin/slapd -h "ldap:///" -u ldap -g ldap -d 3

