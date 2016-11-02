common_packages:
  pkg.installed:
    - pkgs:
        - software-properties-common

mariadb_repo:
  pkgrepo.managed:
    - humanname: MariaDB repo
    - name: deb http://ftp.hosteurope.de/mirror/mariadb.org/repo/10.1/debian jessie main
    - dist: jessie
    - file: /etc/apt/sources.list.d/mariadb.list
    - key_url: salt://galera_gpg

percona_repo:
  pkgrepo.managed:
    - humanname: Xtrabackup repo
    - name: deb http://repo.percona.com/apt jessie main
    - dist: jessie
    - keyid: 8507EFA5
    - keyserver: keyserver.ubuntu.com
    - file: /etc/apt/sources.list.d/xtrabackup.list


mariadb-aux:
  pkg:
    - installed
    - names:
        - mariadb-client
        - percona-xtrabackup
        - percona-toolkit
        - rsync
        - python-mysqldb
        - xinetd
    - require:
        - pkgrepo: percona_repo


galera-conf:
  file.managed:
    - name: /etc/mysql/conf.d/galera.cnf
    - makedirs: True
    - source: salt://galera.cnf


mariadb:
  pkg:
    - installed
    - name: mariadb-server
    - hold: True

    - require:
        - file: galera-conf

mariadb_root_pass:
  cmd.wait:
    - name: mysqladmin -u root password "m6d9d9ta"
    - wait:
      - pkg: mariadb-server

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
