include:
    - postgresql
    - nginx
    - uwsgi
    - ssh

djangouser:
    postgres_user.present:
        - name: {{ pillar['dbuser'] }}
        - password: {{ pillar['dbpassword'] }}
        - runas: postgres
        - require:
            - service: postgresql-9.2

djangodb:
    postgres_database.present:
        - name: {{ pillar['dbname'] }}
        - encoding: UTF8
        - lc_ctype: en_US.UTF8
        - lc_collate: en_US.UTF8
        - template: template0
        - owner: {{ pillar['dbuser'] }}
        - runas: postgres
        - require:
            - postgres_user: {{ pillar['dbuser'] }}

project-root:
    file:
        - directory
        - name: {{ pillar['project_root'] }}
        - user: nginx
        - group: nginx
        - recurse:
            - user
            - group
        - mode: 755
        - makedirs: true
        - require:
            - pkg: nginx

project-git:
    git.latest:
        - name: {{ pillar['git'] }}
        - rev: master
        - target: {{ pillar['project_root'] }}
        - force: true
        - force_checkout: true
        - user: root
        - require:
            - pkg: git
            - ssh_known_hosts: bitbucket.org


site-root:
    file:
        - directory
        - name: {{ pillar['site_root'] }}
        - user: nginx
        - group: nginx
        - recurse:
            - user
            - group
        - mode: 755
        - require:
            - file: project-root

{{ pillar['project_root'] }}/venv:
    virtualenv.manage:
        - requirements: {{ pillar['project_root'] }}/requirements.txt
        - clear: false
        - python: /usr/bin/python2.7
        - env: {'PATH': '/usr/pgsql-9.2/bin/'}
        - require:
            - file: project-root

uwsgi-app:
    file.managed:
        - name: /etc/uwsgi/apps-available/project1.ini
        - source: salt://project1/web-site.ini
        - template: jinja
        - user: nginx
        - group: nginx
        - mode: 755
        - require:
            - cmd: uwsgi 

uwsgi-directory:
    file:
        - directory
        - name: /etc/uwsgi/apps-enabled/
        - user: root
        - group: root
        - recurse:
            - user
            - group
        - mode: 755

nginx-directory:
    file:
        - directory
        - name: /etc/nginx/sites-enabled/
        - user: root
        - group: root
        - recurse:
            - user
            - group
        - mode: 755

enable-uwsgi-app:
    file.symlink:
        - name: /etc/uwsgi/apps-enabled/project1.ini
        - target: /etc/uwsgi/apps-available/project1.ini
        - force: false
        - require:
            - file: uwsgi-app

nginx-conf:
    file.managed:
        - name: /etc/nginx/sites-available/project1.conf
        - source: salt://project1/project1.conf
        - template: jinja
        - user: nginx
        - group: nginx
        - mode: 755
        - require:
            - pkg: nginx

enable-nginx-site:
    file.symlink:
        - name: /etc/nginx/sites-enabled/project1.conf
        - target: /etc/nginx/sites-available/project1.conf
        - force: false
        - require:
            - file: nginx-conf

