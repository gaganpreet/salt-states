include: 
    - reqs
    - nginx

uwsgi: 
    cmd.run:
        - name: pip-2.7 install uwsgi

uwsgi-service:
    service.running:
        - enable: True
        - name: uwsgi
        - require:
            - file: /etc/init/uwsgi.conf


/etc/init/uwsgi.conf:
    file.managed:
        - source: salt://uwsgi/uwsgi.conf
        - temlpate: jinja
        - require:
            - cmd: uwsgi


/var/log/uwsgi:
    file:
        - directory
        - user: nginx
        - group: nginx
        - makedirs: true
        - require: 
            - cmd: uwsgi
            - pkg: nginx

/var/log/uwsgi/app:
    file:
        - directory
        - user: nginx
        - group: nginx
        - makedirs: true
        - require:
            - cmd: uwsgi
            - pkg: nginx

/var/log/uwsgi/emperor.log:
    file:
        - managed
        - user: nginx
        - group: nginx
        - require:
            - cmd: uwsgi
            - pkg: nginx

