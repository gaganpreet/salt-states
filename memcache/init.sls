memcached:
    pkg.installed:
        - name: memcached
    file.managed:
        - name: /etc/memcached.conf
        - source: salt://memcache/memcached.conf
    service.running:
        - enable: true
        - watch: 
            - file: /etc/memcached.conf

python-memcached:
    cmd.run:
        - name: pip-2.7 install python-memcached
