# Atvirojo kodo įranga mokslui, verslui ir valdymui

#### Namų darbas 2, AKSfm-15, Maksim Norkin 

## Užduotis

Atlikti praktinę dalį su git repozitorija.

# Repozitorijos sukūrimas

Po serverio paleidimo reikia sukurti git serverį, į kurį galima būtų įkelti visus projekto pakeitimus.

Pirmiausiai reikia sukurti ``git``naudotoją

    /usr/sbin/useradd git
    
Toliau paskiriam jam slaptažodį

    echo git:git | /usr/sbin/chpasswd
    
Sukuriam namų direktoriją

    mkdir -p /home/git
    
Ir suteikiam naujai sukurto naudotojo teises į namų direktoriją

    chown git:git /home/git
    
Taip pabaigiama ``git`` naudotojo sukūrimas. Po to, kai mes turime naudotoją, su kuriuo galėsim kreiptis į serverį, reikia sukurti patį projektą, su kuriuo bus dirbama.

Projektas yra paprasta direktorija, kurioje yra saugomos bylos. Nuo direktorijos reikia ir pradėti
    
    sudo -u git mkdir -p /home/git/open-lab-01.git
    
Komanda ``sudo`` pradžioje leidžia pakeisti naudotoją į kitą naudotoją. Šiuo atveju kitas naudotojas yra ``git`` ir pakeitę naudotoją mes sukuriam naują direktoriją ``git``naudotojo namų direktorijoje.

Toliau seka tam tikri konfigūracijos žingsniai, kurie leis dirbti su ``git`` ir lokaliam serveryje.

    sudo -u git git config --global user.email 'm.norkin@gmail.com'
    sudo -u git git config --global user.name 'm.norkin'
    
Paskutinis žingsnis yra inicijuoti patį projektą

    su git -c 'cd /home/git/open-lab-01.git; git init --bare'
    
Šį kartą naudotojo pakeitimui buvo panaudota ne ``sudo``, o ``su`` komanda. Komanda buvo pakeista tik iliustracijai, kad naudotoją galima pakeisti ne tik naudojant ``sudo`` komanda.

# Duomenų gavimas iš repozitorijos ir pakeitimų atlikimas

Projekto parsiuntimas iš ``git`` repozitorijos yra labai paprastas žingsnis, tai atlieka viena komanda
    
    git clone git@192.168.33.10:open-lab-01.git open-lab-01
    
Atliekam viso projekto ``open-lab-01.git`` parsiuntimą į ``open-lab-01`` direktoriją. Kadangi bus reikalinga du projekto katalogai, tai atliksime šitą operaciją dar kartą, tik į kitą katalogą

    git clone git@192.168.33.10:open-lab-01.git open-lab-02    

Sukursime pirmos direktorijos projekte naują bylą
    
    cd open-lab-01; touch text.txt
    
Ir pakeisime naujai sukurtą failą

    echo "Text file created by the first user. \
    Line added by the second user." >> text.txt     
    
Atliktus pakeitimus reikia įkelti į serverį
    
    git add text.txt
    
Ir juos įrašyti į istoriją

    git commit -m "pirmas pakeitimas"
    
Bei sukelti į centrinį ``git`` serverį

    git push origin master
    
Norint gauti atliktus pakeitimus projekto kitoje direktorijoje, reikia tiesiog atlikti

    cd open-lab-02; git pull
    
Operacija partrauks visus pakeitimus.


# Konfliktų sprendimas

Konfliktų sprendimas yra toks scenarijus, kuomet toje pačioje byloje ir toje pačioje eilutėje pakeitimus atliko skirtingi įrašai istorijoje (``commit``). Tokiu atveju reikia pasileisti kokį nors konfliktų sprendimo įrankį, ir per trijų panelių vaizdą sujungti pakeitimus.

    git mergetool
    
Trijų panelių vaizdą sudaro trys vaizdai į konfliktuojančią bylą -- pirmas vaizdas yra centrinio serverio bylos versija, antras vaizdas yra konflikto rezultatas, ir trečias vaizdas ir lokalios bylos versija.

# Išvados

Praktinio darbo metu buvo sukurta repozitorija lokaliam serveryje. Visas darbas buvo atliktas automatizuotai vagrant pagalba. Atlikti pakeitimai lokalioje mašinoje ir sukelti į git serverį. Paskui buvo partraukti visi pakeitimai iš git serverio kitoje direktorijoje.
