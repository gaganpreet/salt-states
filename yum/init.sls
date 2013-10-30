{% if grains['os_family']=="RedHat" %}
postgres:
    cmd.run:
        - name: rpm -Uvh http://yum.postgresql.org/9.2/redhat/rhel-6-x86_64/pgdg-redhat92-9.2-7.noarch.rpm 
        - unless: test -e /etc/yum.repos.d/pgdg-92-centos.repo

epel:
    cmd.run:
        - name: rpm -Uvh http://ftp.osuosl.org/pub/fedora-epel/6/i386/epel-release-6-8.noarch.rpm
        - unless: test -e /etc/yum.repos.d/epel.repo

nginx:
    cmd.run:
        - name: rpm -Uvh http://nginx.org/packages/centos/6/noarch/RPMS/nginx-release-centos-6-0.el6.ngx.noarch.rpm
        - unless: test -e /etc/yum.repos.d/nginx.repo

ius:
    cmd.run:
        - name: rpm -Uvh http://dl.iuscommunity.org/pub/ius/stable/CentOS/6/x86_64/ius-release-1.0-11.ius.centos6.noarch.rpm
        - unless: test -e /etc/yum.repos.d/ius.repo
{% endif %}
