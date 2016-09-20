common_packages:
  pkg.installed:
    - pkgs:
      - htop
      - strace
      {% if grains['os'] == 'CentOS' %}
      - vim-enhanced
      {% else %}
      - vim
      {% endif %}
