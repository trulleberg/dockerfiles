FROM centos7-systemd
RUN yum -y install openssh-server passwd sudo; systemctl enable sshd.service ; yum clean all
RUN systemctl set-default multi-user.target
ADD ./start.sh /start.sh

#RUN echo "root:Passw0rd" | chpasswd

RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N '' 

RUN chmod 755 /start.sh
RUN ./start.sh

EXPOSE 22
#ENTRYPOINT ["/usr/sbin/sshd", "-D"]
CMD ["/usr/sbin/init"]
