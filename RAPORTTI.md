**Palvelinten hallinnan kurssin loppuprojekti**

Kurssin loppuprojektina päästin tehdä salt modulin/tilan pystytetään web-kehitysympäristö modifioitua LAMP-stack:ia (Linux, Apache, MySQL & PHP) käyttäen. Aloin tekemään projektia alkuperäisen mukaan käyttäen MySQL:ää tietokantana, mutta sen asennus osoittautui turhan työlääksi ja hankalaksi joten päätin korvata MySQL:n PostgreSQL:llä. Projektin ympäristönä käytin Vagrantilla pystyttämääni kahden Fedora-linux koneen ympäristöä.
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
- 


