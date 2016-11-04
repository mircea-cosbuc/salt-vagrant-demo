include:
  - base:
    - common.packages
    - repositories


mariadb_extra:
  pkg.installed:
    - names:
      - software-properties-common
      - mariadb-client
      - python-mysqldb
      - rsync
      - xinetd
      - percona-xtrabackup
      - percona-toolkit
    - require:
        - pkgrepo: mariadb_repo
        - pgkrepo: percona_repo


{% for node, node_info in pillar['galera']['nodes'].iteritems() %}
node_info['hostname']:
  host.present:
    - ip: node_info['ipaddr']
{% endfor %}


mariadb:
  pkg.installed:
    - name: mariadb-server
    - hold: True
    - require:
        - pkg: mariadb_extra


galera_config:
  file.managed:
    - name: /etc/mysql/conf.d/galera.cnf
    - user: root
    - group: root
    - mode: 644
    - makedirs: True
    - source: salt://galera/files/galera.cnf
    - require:
        - pkg: mariadb


mariadb_service:
  service.running:
    - name: mysql
    - enable: True
    - restart: False
    - reload: False
    - require:
      - file: galera_config


mariadb_root_pass:
  cmd.wait:
    - name: mysqladmin -u root password "m6d9d9ta"
    - wait:
      - service: mariadb_service


mysql_xtrabackup_account:
  mysql_user.present:
    - name: wsrep
    - host: '%'
    - password: "m6d9d9ta.wsrep"
    - connection_host: localhost
    - connection_user: root
    - connection_pass: "m6d9d9ta"
    - connection_charset: utf8
    - saltenv:
      - LC_ALL: "en_US.utf8"
    - require:
      - cmd: mariadb_root_pass


mysql_xtrabackup_grants:
  mysql_grants.present:
    - grant: all privileges
    - database: "*.*"
    - user: wsrep
    - host: '%'
    - connection_host: localhost
    - connection_user: root
    - connection_pass: "m6d9d9ta"
    - connection_charset: utf8
    - require:
      - mysql_user: mysql_xtrabackup_account
