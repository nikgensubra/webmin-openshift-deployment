FROM centos:7

# Aggiungi un utente non root per OpenShift
RUN useradd -r -u 1001 -g 0 webminuser

# Installa dipendenze e Webmin
RUN yum -y update &&     yum -y install wget perl perl-Net-SSLeay openssl &&     wget http://prdownloads.sourceforge.net/webadmin/webmin-2.103-1.noarch.rpm &&     yum -y install ./webmin-2.103-1.noarch.rpm &&     rm -f webmin-2.103-1.noarch.rpm &&     yum clean all

# Imposta i permessi per l'utente non root
RUN chown -R 1001:0 /etc/webmin /var/webmin

# Imposta l'utente
USER 1001
EXPOSE 10000

CMD ["/etc/webmin/start"]
