common_packages:
  pkg.installed:
    - pkgs:
        - software-properties-common

galera_repo:
  pkgrepo.managed:
    - name: deb http://ftp.hosteurope.de/mirror/mariadb.org/repo/10.1/debian jessie main
    - file: /etc/apt/sources.list.d/galera.list
    - key_url: salt://galera_gpg
