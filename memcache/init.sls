memcached:
    pkg.installed:
        - name: memcached
    file.managed:
        - name: /etc/sysconfig/memcached
        - source: salt://memcache/memcached
    service.running:
        - enable: true
        - watch: 
            - file: /etc/sysconfig/memcached

python-memcached:
    cmd.run:
        - name: pip-2.7 install python-memcached
