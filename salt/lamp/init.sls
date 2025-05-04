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
php-pqsql:
  pkg.installed
/var/www/html/index.html:
  file.managed:
    - source: salt://lamp/apache2/index.html
/etc/apache2/mods-enabled/dir.conf:
  file.managed:
    - source: salt://lamp/apache2/dir.conf
