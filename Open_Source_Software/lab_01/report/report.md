# Atvirojo kodo įranga mokslui, verslui ir valdymui

#### Namų darbas 1, AKSfm-15, Maksim Norkin 

## Užduotis

Parinkti atviro kodo virtualią mašiną ir ją įdiegti. Virtualioje mašinoje įdiegti atviro kodo operacinę sistemą. Operacinėje sistemoje įdiegti git serverį.

## Atlikimo žingsniai

Norint taupyti laiką, diegimo žingsnis yra praleidžiamas ir startuojama iškarto su įdiegta sistema. Tokiu atveju, reikia tiesiog rasti norimos operacinės sistemos atvaizdą ir jį paleisti.

Darbo lengvinimui taip pat yra panaudotas ``Vagrant`` (programinė įranga yra platinama su MIT licencija, kas paprastai reiškia, kad sprendimą galime panaudoti bet kurioje srityje).

Darbas yra pradedamas inicializuojant projektą:

    $ vagrant init https://github.com/kraksoft/vagrant-box-debian/releases/download/7.8.0/debian-7.8.0-amd64.box
    
Inicializuojant projektą yra sugeneruojamas ``Vagrantfile``, kuris yra naudojamas virtualios sistemos sukūrimo metu.

Pirmiausiai reikia sukurti virtualų tinklą, tokiu atveju iš ``host`` bus lengviau pasiekti ``guest``. Reikia papildyti konfigūracijos bylą tokia eilute:

    config.vm.network "private_network", ip: "192.168.33.10"
    
Tolimesnis žingsnis yra uždrausti prisijungimą prie ``host`` bylų sistemos:

    config.vm.synced_folder ".", "/vagrant", disabled: true
    
Paruošiamieji darbai šioje vietoje yra baigti. Toliau seka git serverio diegimas. ``Vagrant`` sugeba atlikti instrukcijas po sistemos diegimo. Pasirinkta ``bash`` instrukcijos dėl jų paprastumo. Kadangi bendrai šiame žingsnyje nėra reikalaujama didelių pakeitimų operacinės sistemos lygmenyje.

Komandų seka yra pradedama

    config.vm.provision "shell", inline: <<-SHELL
    
baigiama

    SHELL
    
Visos sekančios komandos turi būti įrašytos tarp šitų kodo blokų.

Pirmas žingsnis yra atnaujinti sistemos paketų archyvą iki naujausios versijos

    sudo apt-get update
    
Toliau reikia įdiegti git programinį paketą

    sudo apt-get install git -y
    
Sukurti naują naudotoją, kuris bus naudojamas ``git`` sprendimui

    /usr/sbin/useradd git
    
Sukurti jam slaptažodį

    echo git:git | /usr/sbin/chpasswd
    
Namų direktoriją

    mkdir -p /home/git
    
Suteikti atitinkamas teises

    chown git:git /home/git
    
Sukurti demonstracinį projektą

    sudo -u git mkdir -p /home/git/open-lab-01.git
    
Maža git kliento konfigūracija

    sudo -u git git config --global user.email 'm.norkin@gmail.com'
    sudo -u git git config --global user.name 'm.norkin'
    
Inicializuojam projektą

    su git -c 'cd /home/git/open-lab-01.git; git init --bare'
    
Visi reikalingi žingsniai yra atlikti ir dabar galima naudotis ``git`` serveriu per ``ssh``:

    git remote set-url origin git@192.168.33.10:open-lab-01.git
    

## Virtuali mašina

Virtualios mašinos valdymo sprendimas pasirinktas ``VirtualBox`` programinis paketas, kurios licencija yra GPLv2. Licencija leidžia naudoti programinį paketą kaip norima, svarbiausia yra pažymėti kas yra naudojamos programinės įrangos autorius.

``VirtualBox`` yra galingas x86 ir AMD/Intel64 virtualizacijos produktas, kuris yra tinkamas tiek naudoti namie, tiek darbe. Sistema yra labai gausi funkcijomis, kurias galima naudoti darbo aplinkoje. Tai yra vienintelis tokio tipo atviro kodo sprendimas, kuris leidžiamas naudoti profesionalioje aplinkoje.

``VirtualBox`` sistema veikia ant Windows, Linux, Macintosh ir Solaris operacinių sistemų.Naudojantis sprendimu, galima paleisti didelį spektrą operacinių sistemų, įtraukiant Windows, DOS/Windows 3.1, Linux, Solaris, OpenSolaris, OS/2 ir OpenBSD.
VirtualBox yra aktyviai vystomas ir dažnai išleidžiami atnaujinimai.
Jo funkcijų skaičius pastoviai yra didinamas. Taip pat yra atliekami darbai prie didesnio palaikomų operacinių sistemų palaikymo.

Sprendimas vystomas bendruomenės, tačiau yra palaikomas ir poros įmonių. 
Kiekvienas yra agituojamas prisidėti prie šito produkto vystymo, o Oracle pasirūpina, kad produktas atitiktų profesionalios aplinkos keliamus reikalavimus.

## Operacinė sistema

Pasirinkta Debian operacinė sistema, dėl distribucijos stabilumo. Operacinė sistema yra Unix tipo kompiuterinė operacinė sistema, kuri visiškai susideda iš nemokamų programų, daugelis kurių yra licencijuoti pagal ``GNU GPL``. Programinės įrangos sudėliojimu rūpinasi individų grupė, kuri formuoja ``Debian Project``. Egzistuoja trys pagrindinės sistemos atšakos: stabili, testuojama ir nestabili. Debian stabili atšaka yra viena populiariausių operacinių sistemų, kuri yra naudojamas asmeniniuose kompiuteriuose ir serveriuose. Jinai yra naudojama kaip bazė daugelio kitų distribucijų.

## Išvados

Darbo metu buvo paleista atviro kodo Debian operacinė sistema, naudojantis ``VirtualBox`` programiniu paketu, įdiegtas git serveris. Visi paleidimo ir diegimo žingsniai yra pilnai automatizuoti ir gali būti iškviesti po kiekvieno diegimo. Nenorint atlikinėti papildomų žingsnių kiekvieną kartą, visos mašinos ūseną galima nuimti ir sukurti virtualų jos atvaizdą:

    $ vagrant package --base open-source-lab-01

Tokiu norint paleisti dar vieną git serverį, teliks paleisti dvi komandas

    $ vagrant init open-source-lab-01
    $ vagrant up
    


