mariadb_repo:
  pkrepo.managed:
    - humanname: MariaDB repo
    - name: deb http://ftp.hosteurope.de/mirror/mariadb.org/repo/10.1/debian jessie main
    - dist: jessie
    - file: /etc/apt/sources.list.d/mariadb.list
    - key_url: salt://repositories/keys/mariadb.gpg


percona_repo:
  pkrepo.managed:
    - humanname: Xtrabackup repo
    - name: deb http://repo.percona.com/apt jessie main
    - dist: jessie
    - file: /etc/apt/sources.list.d/xtrabackup.list
    - key_url: salt://repositories/keys/percona.gpg
