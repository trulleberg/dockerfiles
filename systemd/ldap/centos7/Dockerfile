# Added LDAP and phpldapadmin by Hannes "git@bellmer.org"
#  ----  

# "ported" by Adam Miller <maxamillion@fedoraproject.org> from
#   https://github.com/fedora-cloud/Fedora-Dockerfiles
#
# Originally written for Fedora-Dockerfiles by
#   scollier <scollier@redhat.com>

FROM systemd
MAINTAINER Hannes  <git@bellmer.org>

# Install Openldap!
RUN yum -y update; yum -y install openldap openldap-servers openldap-clients ; yum clean all

# Add the samba schema:
COPY samba.schema /etc/openldap/schema/samba.schema

# Copy the samba LDIF, see
# https://wiki.debian.org/LDAP/OpenLDAPSetup#For_SAMBA_LDAP_support
# for details.
COPY samba.ldif /etc/openldap/slapd.d/cn=config/cn=schema/cn={4}samba.ldif
RUN chown ldap: /etc/openldap/slapd.d/cn=config/cn=schema/cn={4}samba.ldif

# Add the slapd.sh file to the container
COPY slapd.sh /
RUN chmod +x /slapd.sh
ENTRYPOINT ["/slapd.sh"]



# Defaul Config //TODO
#ENV LDAP_ROOTPASS "geheim"
#ENV LDAP_ORGANISATION "Acme inc"
#ENV LDAP_DOMAIN "acme.corp"

EXPOSE 389
