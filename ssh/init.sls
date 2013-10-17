/root/.ssh/known_hosts:
    file.managed:
        - user: root
        - group: root
        - mode: 700
        - makedirs: True
