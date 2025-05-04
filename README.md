Modifioitu LAMP-stack asennus:

Pohjana asennukselle käytin Linuxin Fedora jakelua.

Komponentit:
- Apache2
- PHP
- Postgresql

Asennusohje:
Kloonaa git-repository Salt Master palvelimellesi, tee symbolinen linkki palvelimesi /srv/-kansiosta projektin /salt/-kansioon. Tämän jälkeen voit asentaa tämän modifioidun LAMP-stack:in Salt orja palvelimillesi komennolla 'sudo salt '<palvelin/palvelimet/*>' apply.state lamp'.

Asennuksen onnistumisen voit varmistaa esim. curl-työkalulla, 'curl <http://<palvelimen IP>:80/items.php'. Mikäli tuloste sisältää 4:n itemin listan on sekä apache, PHP ja Postgresql asentuneet onnistuneesti.
