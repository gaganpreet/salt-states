iptables:
    file.managed:
        - name: /etc/sysconfig/iptables
        - source: salt://iptables/iptables
        - template: jinja
    service.running:
        - enable: true
        - watch: 
            - file: /etc/sysconfig/iptables
