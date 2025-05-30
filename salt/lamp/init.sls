apache2:
  pkg.installed
curl:
  pkg.installed
postgresql:
  pkg.installed
php:
  pkg.installed
libapache2-mod-php:
  pkg.installed
php-pgsql:
  pkg.installed
/var/www/html/index.html:
  file.managed:
    - source: salt://lamp/apache2/index.html
/var/www/html/info.php:
  file.managed:
    - source: salt://lamp/apache2/info.php
/var/www/html/items.php:
  file.managed:
    - source: salt://lamp/apache2/items.php
/home/vagrant/demo.sql:
  file.managed:
    - source: salt://lamp/psql/demo.sql
'sudo -u postgres psql -a -f /home/vagrant/demo.sql;sudo systemctl restart apache2':
  cmd.run:
    - unless: sudo -u postgres psql -lqt | grep demo
