common_packages:
  pkg.installed:
    - pkgs:
      - htop
      - strace
      - vim
      - ntpdate
      - ntp
      - make
      - python-virtualenv
      - python-pip
      - python2.7-dev
      - supervisor
      - python-mysqldb


/usr/sbin/policy-rc.d:
  file.managed:
    - user: root
    - group: root
    - mode: 755
    - template: jinja
    - source: salt://common/files/policy-rc.d
