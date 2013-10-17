include:
    - reqs

nginx:
    pkg.latest:
        - name: nginx
    service.running:
        - enable: True

default-nginx:
    file.absent: 
        - name: /etc/nginx/sites-enabled/default
