packages:
    pkg.installed:
        - names:
            - python27
            - python27-devel
            - python27-tools
            - python27-distribute
            - python27-libs
            - git
            - gcc
            - make

pip:
    cmd.run:
        - name: easy_install-2.7 pip

virtualenv:
    cmd.run:
        - name: pip-2.7 install virtualenv virtualenvwrapper
        - onlyif: test -e /usr/bin/pip-2.7

/etc/salt/minion:
    file.append:
        - text:
            - "postgres.user: 'postgres'"
            - "postgres.port: '5432'"
            - "postgres.host: 'localhost'"
            - "postgres.pass: ''"
            - "postgres.db: 'template0'"
