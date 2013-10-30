pg_hba.conf:
    file.managed:
        - name: /etc/postgresql/9.2/main/pg_hba.conf
        - source: salt://postgresql/pg_hba.conf
        - user: postgres
        - group: postgres
        - mode: 644
        - require:
            - pkg: postgresql92-server

postgresql-9.2:
    pkg.installed:
        - names: 
            - postgresql92-server
            - postgresql92
            - postgresql92-devel
    service.running:
        - enable: True
        - watch: 
            - file: /etc/postgresql/9.2/main/pg_hba.conf
        - require: 
            - pkg: postgresql92-server

postgresql92-devel:
    pkg.installed:
        - name: postgresql92-devel

/etc/init.d/functions:
    file.append:
        - text:
            - "export PATH=$PATH:/usr/pgsql-9.2/bin/"
