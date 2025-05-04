apache2:
  pkg.installed
curl:
  pkg.installed
/var/www/html/index.html:
  file.managed:
    - source: salt://lamp/apache2/index.html
