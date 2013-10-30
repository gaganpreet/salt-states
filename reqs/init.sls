swap:
    cmd.run:
        - name: |
            dd if=/dev/zero of=/swap bs=1024 count=786432
            mkswap /swap
            chown root:root /swap
            chmod 600 /swap
            swapon /swap
        - unless: test -e /swap

/etc/fstab:
    file.append:
        - text:
            - "/swap swap swap defaults 0 0"

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
            - libxml2-devel
            - libxslt-devel
            - openssl-devel

pip:
    cmd.run:
        - name: easy_install-2.7 pip

virtualenv:
    cmd.run:
        - name: pip-2.7 install virtualenv virtualenvwrapper
        - onlyif: test -e /usr/bin/pip-2.7
