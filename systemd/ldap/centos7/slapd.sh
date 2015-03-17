#! /bin/sh
#
# slapd.sh
# Copyright (C) 2015 Hannes
#
set -eu
status() {
    echo "---> ${@}" >&2
}

#set -x
#: LDAP_ROOTPASS=${LDAP_ROOTPASS}
#: LDAP_DOMAIN=${LDAP_DOMAIN}
#: LDAP_ORGANISATION=${LDAP_ORGANISATION}

# Domain is actually nas.com and the manager pw is Passw0rd

if [ ! -e /var/lib/ldap/docker_bootstrapped ]; then
        status "configuring slapd for first run"
        echo 'olcRootPW: {SSHA}LpOnFguyBLlueeMV3mMRQYzEZ3+n74WL' >>   '/etc/openldap/slapd.d/cn=config/olcDatabase={2}hdb.ldif'
        sed -i 's/dc=my-domain,dc=com/dc=nas,dc=com/'                 '/etc/openldap/slapd.d/cn=config/olcDatabase={2}hdb.ldif'
        sed -i 's/dc=my-domain,dc=com/dc=nas,dc=com/'                 '/etc/openldap/slapd.d/cn=config/olcDatabase={1}monitor.ldif'
        sed -i 's/Require local/Require all granted/'                 '/etc/httpd/conf.d/phpldapadmin.conf'
        sed -i s/",'uid')"/",'dn')"/                                  '/etc/phpldapadmin/config.php'
        touch /var/lib/ldap/docker_bootstrapped
      else
          status "found already-configured slapd"
fi
