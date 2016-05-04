# Pirma dalis klausimu

## Paprasčiausios duomenų struktūros ir jų skirtumai

* Masyvas;
    * Visi masyvo lementai yra to pačio tipo
    * Masyvo elementų skaičius yra fiksuotas ir jo negalima keisti
    * Masyvo elementus išrenkame tiesiogiai, naudodami indeksus
	
* Įrašas
    * Tai yra duomenų tipas, kuris turi savybe grupę kitų duomenų tipų, kurios kartu sudaro vieno objekto aprašymą.
	
* Dėklas
    * Dėklą apibūdina principas "paskutinis įeina, pirmas išeina". Elementai įrašomi ir šalinami iš sąrašo pradžios.
    * Dėklo veiksmai: sukurti tuščią dėklą, įterpti elementą, patikrinti ar dėklas tuščias, perskaityti pirmojo elemento reikšmę, išimti pirmąjį elementą iš dėklo.

* Eilė
    * Apibūdina principas "kas pirmas įeina, tas pirmas išeina", FIFO;
    * Elementai įrašomi į tiesioginio sąrašo pradžią, o šalinami iš jo galo;
    * Galimi veiksmai: sukurti tuščią eilę, įterpti elementą į eilę, patikrinti ar eilė tuščia, perskaityti pirmojo elemento reikšmę, išimti pirmąjį elementą iš eilės;
    * Eilę apibrėžiama, naudodami įrašo duomenų struktūrą;
    * Įrašą sudaro trys laukai: elementų masyvas, pradžios rodyklėm, pabaigos rodyklė pradinės rodyklių reikšmės ir apibrėžia tuščią eilę;
    * Elementai įterpiami į eilės galą, o šalinami iš eilės pradžios, taigi eilė "juda" masyve;
    * Dvipusė eilė yra tokia duomenų struktūra, į kurią elementai įterpiami ir šalinami iš abiejų eilės galų.

	
## Tiesiniai sąrašai
	
* Vienakryptis tiesinis sąrašas
    * Kuriamas apibrėžus rodyklę, kuri rodo sąrašo pabaigą
    * Skiriame tik tiek atminties, kiek reikia sąrašo elementams saugoti;
    * Tiesinį sąrašą galima efektyviai įterpti naujus ir šalinti nereikalingus elementus
    * Bet kuris sąrašo elementas yra pasiekiamas tik iš sąrašo pradžios, paeiliui praėjus visus prieš jį esančius elementus
	
* Dvikryptis tiesinis sąrašas
    * Tiesioginis sąrašas, kuris turi dvi rodykles: pirmoji rodyklė nukreipia į kitą sąrašo elementą, o antroji - į prieš tai įrašytą elementą.
	
* Ciklinis sąrašas
    * Tai yra vienakrypčius tiesioginis sąrašas, kurio paskutinis elementas yra gretimas piramąjam.
    * Paskutinio elemento next rodyklė sutampa su sąrašo pradžios rodykle, tai yra sąrašo pabaigos požymis.
	
## Medžiai

### Dvejetainis medis

Dvejetainis medis -- tai tuščia aibė, turinti viršūnę a. Visos aibės sudarytos iš viršūnės a, sujungtos su surūšiuota pora (L, R) kur L ir R yra dvejetainiai medžiai. Tada a yra vadinama medžio šaknimi, o L ir R -- medžio kairiuoju ir dešiniuoju po-medžiais.

Medžio šaknis yra nulinio lygmens. Tada k-tojoi lygmens viršūnės vaiko lygmuo yra (k+1). Medžio aukštis yra lygus didžiausiam viršūnės lygmeniui.

Medžio briaunoms gali būti suteiktas svoris, toks medis vadinamas svertiniu.

Dvejetainis medis yra sutvarkytas, kai jo viršūnėms suteikti numeriai.

Pavyzdžiui, genealoginis medis -- T žymi tėvą, M -- motina.

## Medžių taikymas

### Dvejetainis paieškos medis

Vienas iš taikomų medžių yra dvejetainis paieškos medis, kuris naudojamas labai dažnai informacijai saugoti, rūšiuoti ir ieškoti. Tokio medžio kiekvienoje viršūnėje esantis elementas yra didesnis už kairiojo po-medžio elementus ir nedidesnis už dešiniojo po-medžio elementus.

Nesunku patikrinti, ar medyje yra saugoma reikalinga informacija, nes visada pasirenkamas tik vienas iš dviejų po-medžių. Jei tokio elemento medyje nėra, tai procedūra grąžiną nuorodą į tuščią viršūnę (NULL nuoroda).

Pagrindinis paieškos medžio trūkumas yra tas, kad blogiausiu atveju jis gali virsti tiesiniu sąrašu. Tada duomenų įterpimo, šalinimo ir paieškos veiksmai tampa labai neefektyvūs, jų sudėtingumas yra proporcingas medžio viršūnių skaičiui. Ši problema yra spendžiama, naudojant AVL medžius ir piramidės duomenų struktūras.

### AVL paieškos medis

Tai iš dalies subalansuotas dvejetainis medis, kurio bet kurios viršūnės kairiojo ir dešiniojo pomedžio aukščiai skiriasi ne daugiau nei vienetu. Šio medžio elemento paieškos, naujos viršūnės įterpimo ar pašalinimo sudėtingumas yra tik ``O(logN)``. Prie kiekvienos viršūnės nurodytas jos subalansuotumo faktorius. Faktorius gali būti lygus ``-1``, ``0`` ar ``1``:

* 1 suteikiamas tada, kai kairiojo pomedžio aukštis didesnis vienetu už dešiniojo pomedžio viršūnės aukštį;
* 0, kai pomedžiai yra subalansuoti
* -1, kai dešiniojo pomedžio aukštis yra vienetu didesnis už kairiojo pomedžio aukštį.

Jeigu įterpus ar pašalinus naują viršūnę, šis faktorius tampa lygus ``-2`` arba ``2``, tada papildomai balansuojame dvejetainį medį.


### B medžiai

Siekiant, kad paieška duomenų bazėse ir informacinėse sistemose būtų greitesnė, naudojami daugiataškiai medžiais, kurių viršūnės gali turėti daugiau negu dvi šakas. Šios struktūros skirtos labai didelėms duomenų bazėms sudaryti, kai informacija saugoma išorinėse laikmenose, o pagrindinis paieškos laikas sugaištamas kopijuojant informaciją iš lėtosios kompiuterio atminties į greitąją vidinę. Tam yra sudaromi specialūs jų formavimo, viršūnių įterpimo ir jų šalinimo algoritmai.

Visos B medžio viršūnės yra dalijamos į dalinius medžius, vadinamus puslapiais. Kiekviename puslapyje elementai išdėstomi didėjimo tvarka. Tada paieškai B medyje, sudarytame iš N elementų, užtenka ``lognN`` kreipinių. 

### Piramidė

Piramide vadinamas dvejetainis medis, kuris turi tokias savybes:
* Pilnas, subalansuotas medis: pirmiausiai užpildoma medžio šaknis, paskui pirmojo lygmens viršūnės, paskui antro ir t.t.. kiekvieną lygmenį užpildome iš kairės į dešinę
* Medis yra sutvarkytas taip, kad kiekvienos viršūnės vaikai yra nedidesni už pačią viršūnę.

Piramidės šakninėje viršūnėje saugomas didžiausias aibės elementas. Kadangi piramidė yra pilnas dvejetainis medis, tai jos aukštis yra nedidesnis už ``logN``. Dėl šitos priežasties kiekvienos elementų tvarkymo operacijos metu įvykdome ne daugiau kaip ``2logN`` elementų lyginimo veiksmų ir ``logN`` elementų sukeitimų.

## Algoritmų sudėtingumo nustatymas

Algoritmas yra tiksliai apibrėžta skaičiavimo procedūra, kuria, imdami pradinius duomenis ir atlikę baigtinį skaičių operacijų, gauname rezultatą.

Operacijų sudėtingumą galima vertinti naudodami kiekybinį matą -- aritmetinių veiksmų skaičių, tačiau duomenų rūšiavimo ir paieškos algoritmuose tai netinka, kadangi yra atliekami duomenų lyginimo ir sekos elementų keitimo vietomis veiksmai. Algoritmo sudėtingumas yra lygus atliekamų bazinių veiksmų skaičiui.

Jeigu algoritmo ``T``pradinių duomenų skaičius yra ``n``, tuomet sudėtingumą žymėsime ``T(n)``. Sudėtingumas priklauso ne tik nuo pradinių duomenų, tačiau ir nuo jų pasiskirstymo. 

``T(dn)`` algoritmo sudėtingumas, kai turime konkretų pradinių duomenų pasiskirstymą ``dn``.

Asimptotiniai įverčiai svarbūs, kai duomenų skaičius ``n`` yra didelis. Tokiu atveju renkamės algoritmą, kurio sudėtingumo funkcija didėja lėčiau. Jeigu duomenų nėra daug, tai spartesniu gali būti algoritmas, kurio asimptotinis įvertis yra blogesnis. Pagrindiniai asimptotiniai įverčiai:
* ``cnk=O(nr)``, kai ``k <= r``
* ``logn=O(nr)``, kai ``r>0``
* ``nk=O(an)``, kai ``a>1``
* ``log(n!)=O(nlogn)``

