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
    - key_url: salt://percona_gpg
    - file: /etc/apt/sources.list.d/xtrabackup.list
