# **Palvelinten hallinnan kurssin loppuprojekti**

Kurssin loppuprojektina päätin tehdä salt modulin/tilan, jolla pystytetään web-kehitysympäristö modifioitua LAMP-stack:ia (Linux, Apache, MySQL & PHP) käyttäen. Aloin tekemään projektia alkuperäisen mukaan käyttäen MySQL:ää tietokantana, mutta sen asennus osoittautui turhan työlääksi ja hankalaksi joten päätin korvata MySQL:n PostgreSQL:llä. Projektin ympäristönä käytin Vagrantilla pystyttämääni kahden Fedora-linux koneen ympäristöä.
Aloitin projektin asentamalla tarvittavat komponentit manuaalisesti 'master'-palvelimelle käyttäen seuraavia komentoja:
- sudo apt-get install apache2
- sudo apt-get install curl (testausta varten)
- sudo apt-get install postgresql
- sudo apt-get install php libapache2-mod-php php-pgsql

Tämän jälkeen muokkasin apachen testisivun /var/www/html/index.html yksinkertaisemmaksi palauttaen vain tekstin "Test site!!". Todettuani apachen toimivaksi uudella testisivullani loin hakemistoon /var/www/html/ sivun info.php joka palauttaa runsaasti tietoa PHP ja Apache ympäristöstä.

<img width="731" alt="kuva3" src="https://github.com/user-attachments/assets/2c733654-8688-4aac-a35b-4b64eddb1c48" />

Todettuani PHP asennuksen toimivaksi siirryin PostgreSQL tietokannan pariin ja loin demo.sql skriptin ja luo tietokannan nimeltä 'demo', sinne taulun 'items', ja luo tauluun 4 riviä. Tämän lisäksi skripti asettaa salasanan postgres käyttäjällä. Kun tietokanta oli kunnossa oli aika tehdä PHP-sivu joka hyödyntää tietokannassa olevia tietoja, eli loin hakemistoon /var/www/html/ tiedoston items.php joka listaa kannassa olevat ToDo itemit.

<img width="340" alt="kuva4" src="https://github.com/user-attachments/assets/a6a95c99-7630-435e-8538-6b69779497a2" />

Nyt kun paikallinen stack oli kunnossa oli aika lähteä tekemään näistä salt-moduli joka asentaa tämän kaiken kerralla. Olin tätä varten luonut github:iin repositoryn 'PH_projekti', aloitin salt säätämisen kloonaamalla tämän repositoryn vagrant-käyttäjän kotihakemistoon. Seuraava kuva kertoo projektin hakemistorakenteen.

  PH_projekti/
  
  └── salt
  
      └── lamp
      
          ├── apache2
          
          └── psql

Tämän jälkeen tein symbolisella linkillä linkityksen master palvelimen /srv/-hakemiston alle seuraavasti 'sudo ln -s /home/vagrant/PH_projekti/salt/ /srv/', tämä siksi että salt:lla pystyy ajamaan modulin suoraan orjille (ja git:n kanssa pelaaminen on mielestäni näin helpompaa). Hakemistorakenteen luotuani ja symbolisen linkin tehtyäni lisäsin edellisessä vaiheessa tekemäni tiedostot hakemistorakenteeseen:

- cp /var/www/html/* ~/PH_projekti/salt/lamp/apache2/
- cp ~/demo.sql ~/PH_projekti/sal/lamp/psql/

Kun tiedostot ovat paikallaan aloin rakentamaan init.sls tiedostoa kansioon ~/PH_projekti/salt/lamp/. Ensin asennetaan tarvittavat paketit salt:in tilalla pkg.installed:

<img width="137" alt="kuva5" src="https://github.com/user-attachments/assets/27dc8d6b-5511-4a0e-a1b0-6e35db86771b" />

Kun tarvittavat paketit on asennettu on aika siirtää uusi index.html ja PHP-sivut sekä demo.sql skripti palvelimelle salt:in tilalla file.managed jotta saadaan tietokanta luotua ja koko homman valmistuttua voidaan helposti testata onnistuminen:

<img width="302" alt="kuva6" src="https://github.com/user-attachments/assets/6f4b7ea2-ebb9-43e9-9b26-037250f69c02" />

Tämän modulin/tilan loppuhuipennuksena ajetaan salt:in tilalla cmd.run komento joka luo tietokannan demo.sql-skriptin avulla ja uudelleen käynnistää apachen jotta PHP:n PostgreSQL client tulee käyttöön. Tässä loppuhuipennuksessa on mukana salt:in 'unless', joka tarkistaa ettei tietokanta ole olemassa ennekuin komento ajetaan, mikäli tietokanta on jo olemassa ei tätä vaihetta ajeta, näin tilasta saatiin tehtyä **idempotentti!!**

<img width="556" alt="kuva7" src="https://github.com/user-attachments/assets/b3037e69-c163-4ab4-a901-354924d773fb" />

Tämän jälkeen ajoin tämän modulin/tilan orja palvelimelle komennolla 'sudo salt '*' state.apply lamp', käyttämässäni ympäristössä voin käyttää kohteena '*' eli kaikki salt masterin tuntemat palvelimet koska ympäristössäni ei ole kuin yksi orja, laajemmissa ympäristöissä kohdetta/kohteita olisi syytä tarkentaa jotta asennus osuu vain tarvittaviin palvelimiin.

<img width="742" alt="kuva1" src="https://github.com/user-attachments/assets/544d39ef-a914-4435-a2eb-1ac5affc64dc" />

Ensimmäisen ajon jälkeen testasin että kaikki kolme asettamaani sivua vastaavat, jolloin asennus on onnistunut:

1. index.html
   
   <img width="329" alt="image" src="https://github.com/user-attachments/assets/f3bddeb8-1e1d-4f85-a6fa-07516122e135" />

2. info.php
   
   <img width="731" alt="kuva3" src="https://github.com/user-attachments/assets/64854c4e-9732-408d-b81a-3f2bf81a44a3" />

3. items.php, tämän sivun toiminta todistaa että apachessa oleva php-sivu ja PostgreSQL-tietokanta toimivat yhdessä.
   
   <img width="340" alt="kuva4" src="https://github.com/user-attachments/assets/58b671cc-efc3-4e8d-aa30-35c3199b9317" />

Pelkän 3. kohdan testaaminen olisi riittänyt asennuksen testaamiseen sillä siinä on mukana kaikki asennetut komponentit, ja tämä on helppo testata myös curl-työkalulla master palvelimelta, 'curl http://192.168.88.102/items.php'.

<img width="637" alt="kuva9" src="https://github.com/user-attachments/assets/33976ed8-8c67-412f-b7c5-ce79ca96caae" />

Lopuksi todistin vielä modulini/tilani idempotenttiuden ajamalla se uudelleen, komennon 'sudo salt '*' state.apply lamp' uudelleen ajaminen ei tuottanut muutoksia orja palvelimelle kuten alla olevasta kuvasta voidaan havaita.

<img width="672" alt="kuva2" src="https://github.com/user-attachments/assets/cd709e98-55b1-4da2-b796-31f864ba356c" />

Toivottavasti tämä salt:lla automatisoitu LAPP-stack (Linux, Apache, PostgreSQL & PHP) helpottaa ja nopeuttaa kehitysympäristöjen pystyttämistä tulevaisuuden PHP-projekteissa. Tähän moduliin/tilaan on helppo lisätä muiden mahdollisten softaprojektin kehitystyökalujen asennuksia, esim. git version hallintaan.

## **Lähteet:**
1. Karvinen T., 2025 https://terokarvinen.com/palvelinten-hallinta/#laksyt Luettu 4.5.2025
2. Digitalocean, 2025 https://www.digitalocean.com/community/tutorials/how-to-install-lamp-stack-on-ubuntu Luettu 4.5.2025
3. Salt Project, https://docs.saltproject.io/en/master/ref/states/all/salt.states.cmd.html Luettu 4.5.2025
