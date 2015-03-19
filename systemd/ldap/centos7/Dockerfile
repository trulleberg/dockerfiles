# Added LDAP and phpldapadmin by Hannes "git@bellmer.org"
#   https://github.com/trulleberg/dockerfiles/tree/master/systemd/ldap/centos7

# "ported" by Adam Miller <maxamillion@fedoraproject.org> from
#   https://github.com/fedora-cloud/Fedora-Dockerfiles
#
# Originally written for Fedora-Dockerfiles by
#   scollier <scollier@redhat.com>

FROM centos7-systemd
MAINTAINER Hannes  <git@bellmer.org>

# Install Openldap & add the epel repository and install phplapadmin
RUN rpm -ivh http://mirrors.ukfast.co.uk/sites/dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
RUN yum -y update; yum -y install openldap openldap-servers openldap-clients phpldapadmin ;
RUN yum clean all ; systemctl enable slapd.service ; systemctl enable httpd.service


# Configuring slapd
# https://wiki.debian.org/LDAP/OpenLDAPSetup#For_SAMBA_LDAP_support for details.
#
# Add the samba schema:
COPY samba.schema /etc/openldap/schema/samba.schema
# Cleanup the installed schema
RUN rm -rf /etc/openldap/slapd.d/cn=config/cn=schema/*.ldif
# Create temporary schema folders
RUN mkdir -p /tmp/slapd/slapd.d
# Copy the samba configuration config (see the above link for details)
COPY samba.conf /tmp/slapd/samba.conf
# Create the config
RUN slaptest -f /tmp/slapd/samba.conf -F /tmp/slapd/slapd.d/
# Copy the config to the proper path and adjust the ownership
RUN cp -f /tmp/slapd/slapd.d/cn\=config/cn\=schema/*.ldif /etc/openldap/slapd.d/cn\=config/cn\=schema/
RUN chown ldap: /etc/openldap/slapd.d/cn\=config/cn\=schema/*.ldif

# Add the slapd.sh file to the container
COPY slapd.sh /
RUN chmod +x /slapd.sh
# Create the initial config based on slapd.sh
RUN /slapd.sh


EXPOSE 80
EXPOSE 389
CMD ["/usr/sbin/init"]
# Default Config //TODO
#ENV LDAP_ROOTPASS "geheim"
#ENV LDAP_ORGANISATION "Acme inc"
#ENV LDAP_DOMAIN "acme.corp"

