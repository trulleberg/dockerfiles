# Added LDAP and phpldapadmin by Hannes "git@bellmer.org"
#  ----  

# "ported" by Adam Miller <maxamillion@fedoraproject.org> from
#   https://github.com/fedora-cloud/Fedora-Dockerfiles
#
# Originally written for Fedora-Dockerfiles by
#   scollier <scollier@redhat.com>

FROM centos7-systemd
MAINTAINER Hannes  <git@bellmer.org>

# Install Openldap!
RUN yum -y update; yum -y install openldap openldap-servers openldap-clients ;
RUN yum clean all ; systemctl enable slapd.service

# Add the samba schema:
COPY samba.schema /etc/openldap/schema/samba.schema

# Configuring slapd
# https://wiki.debian.org/LDAP/OpenLDAPSetup#For_SAMBA_LDAP_support
# for details.
# Cleanup the installed schema
RUN rm -rf /etc/openldap/slapd.d/cn=config/cn=schema/*.ldif
# Create temporary schema folders
RUN mkdir -p /tmp/slapd/slapd.d
# Copy the samba configuration config (see the above link for details)
COPY samba.conf /tmp/slapd/samba.conf
# Create the config
RUN slaptest -f /tmp/slapd/samba.conf -F /tmp/slapd/slapd.d/
# Copy the config to the proper path and adjust the ownership
#RUN cp -f /tmp/slapd/slapd.d/cn\=config/cn\=schema/*.ldif /etc/openldap/slapd.d/cn=config/cn=schema/
RUN cp -f /tmp/slapd/slapd.d/cn\=config/cn\=schema/*.ldif /etc/openldap/slapd.d/cn\=config/cn\=schema/
RUN chown ldap: /etc/openldap/slapd.d/cn\=config/cn\=schema/*.ldif

# Add the slapd.sh file to the container
COPY slapd.sh /
RUN chmod +x /slapd.sh
# Create the initial config based on slapd.sh
RUN /slapd.sh

EXPOSE 389
CMD ["/usr/sbin/init"]
# Default Config //TODO
#ENV LDAP_ROOTPASS "geheim"
#ENV LDAP_ORGANISATION "Acme inc"
#ENV LDAP_DOMAIN "acme.corp"

