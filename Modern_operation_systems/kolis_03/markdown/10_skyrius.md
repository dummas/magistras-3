 # 10 skyrius

## Išvardinkite ir glaustai aptarkite penkias grūdėtumo kategorijas

Grūdėtumas -- sinchronizavimo tarp procesų dažnumas;

* Fine -- lygiagretumas pasiekiamas per vieną instrukcijų seką
* Medium -- lygiagretus apdorojimas arba daugelio darbų aplinka yra atliekama vienoje programoje
* Coarse -- multiprocessing vienu metu vykdomų procesų multiprogramming aplinkoje
* Very coarse -- paskirstytas apdorojimas tarp tinklo mazgų formuojant vieną kompiuterinę aplinką
* Independent -- daugelis nepriklausomų procesų

## Išvardinkite ir glaustai aptarkite keturis gijų planavimo metodus

* Load sharding -- procesai nėra priskiriami tam tikram procesoriui. Formuojam globali eilė iš pasirengusių gijų ir kiekvienas laukiantis procesorius pasiima darbą iš eilės
* Gang scheduling -- susijusių gijų rinkinys yra parenkamas dirbti ant kelių procesorių vienu metu
* Dedikuotas procesų priskyrimas -- kiekviena programa gauna keletą procesorių, lygių gijų skaičiui programoje, visam programos darbo laikui.
* Dinaminis planavimas -- gijų skaičius programoje gali būti keičiamas programos vykdymo metu;

## Išvardinkite ir glaustai aptarkite tris apkrovos padalijimo versijas

* First Come First Served -- kai darbas ateina, visos jo gijos yra sukraunamos į bendrą eilę; kai tik procesorius tampa laisvas, jis pasiima sekančią gija apdorojimui;
* Pirmiausiai su mažiausių gijų -- bendra eilė yra suformuojama kaip prioriteto eilė, kur didžiausią prioritetą gauna programa, kuri turi mažiausiai gijų;
* Preemptive mažiausias skaičius gijų -- tas pats, kas ir aukščiau, tik kai ateina procesas su mažiau gijų, negu šiuo metu yra vykdomas -- procesas yra nutraukiamas ir vykdomas naujas procesas.

## Kuo skiriasi griežtosios ir negriežtosios realiojo laiko sistemos?

Griežtos realiojo laiko sistemos yra tokios sistemos, kurios turi tilpti į planuotą laiko intervalą, kitaip bus padaryta didelė žala arba klaida;
Negriežtos realiojo laiko sistemos taip pat turi laiko intervalą, per kurį turi pateikti atsakymą, tačiau jeigu jos ir pavėluos jį pateikti -- nieko blogo nebus;

## Kuo skiriasi periodinės ir neperiodinės realiojo laiko sistemos?

Neperiodinės laiko sistemos turi ribojimą kada procesas gali startuoti arba baigtis, arba gali turėti ribojimų ant startavimo ar baigimo laikų;
Periodinės laiko sistemos turi atlikti tam tikrą darbą tam tikru periodu;

## Išvardinkite ir glaustai apibūdinkite penkis bendrojo pobūdžio reikalavimus, keliamus realiojo laiko operacinėms sistemoms.

* Determinizmas - operacinė sistema yra deterministinė, jeigu ji atlieka operacijas tam tikru laiko momentu arba per nustatytą laiko intervalą
* Atsakomumas -- nusakoma per kiek laiko operacinė sistema atlieka pertrauktį, po operacijos priėmimo
* Naudotojo kontrolė -- naudotojas turi būti skirstomas tarp giežtų ir negriežtų darbų ir skirti prioritetus norimiems darbams
* Patikimumas -- patikimumas turi būti užtikrinamas tokia prasme, kad sistema ir toliau pateikia atsakymą numatytuose laiko rėžiuose
* Saugios klaidos režimas -- tai yra klaidos strategija, kuomet įvykus nenumatytoms aplinkybėms sistema ir toliau lieka ribojamai pasiekiama;

## Išvardinkite ir glaustai apibūdinkite keturis realiojo laiko planavimo algoritmų klases

* Statinių lentelių pagrįstas planavimas; Atliekama statinė analizė tarp atliekamų darbų; Darbo rezultatas yra atsakymas kada koks darbas turi būti atliekamas sistemos veikimo metu;
* Statinių prioritetų stabdomų darbų planavimas; Atliekama statinė analizė, kuri paskirsto kuris darbas turi būti aukštesnio prioriteto; 
* Dinaminis planavimas; Atėjęs į eilę darbas yra atliekamas, jeigu jis atitinka laiko reikalavimus;
* Dinaminis geriausias planavimas; Sistema stengiasi patenkinti laiko reikalavimus ir nutraukia bet kokius darbus, kurie trukdo užtikrinti tokius reikalavimus;

## Kokia informacija apie užduotį (procesą) taikytina planuojant realiuoju laiku?

* Laukimo laikas -- laikas, kiek procesas jau yra pasirengęs vykdymui
* Paleidimo terminas -- laikas, kuomet procesas turi būti paleistas
* Pabaigimo terminas -- laikas, kuomet procesas turi būti pabaigtas
* Darbo laikas -- laikas, kuris pažymi kiek procesui reiks laiko praleisti vykdymo būsenoje
* Resursų reikalavimas -- sąrašas cpu resursų, kurių reikia programai vykdymo metu
* Prioritetas