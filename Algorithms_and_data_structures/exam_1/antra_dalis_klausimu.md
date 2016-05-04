# Antra dalis klausimu

## Variantų perrinkimas

Sprendžiami uždaviniai:

* Kaip padalinti uždavinį į baigtinį skaičių mažesnių užduočių (variantų)
* Kaip sumažinti nagrinėjamų variantų skaičių, nes tiesioginis visų variantų patikrinimas gali būti neįvykdomas net su greičiausiais super-kompiuteriais;

Antrąją problemą sprendžiame taikydami dinaminio programavimo, šakų ir rėžių metodus.

Nagrinėkime, kai svarbiausia yra sudaryti visų variantų aibę, o variantai perrenkami greitai

* Variantu perrinkimas grįžtant atgal – vienas iš sprendimo paieškos būdu. Sudėtingumas labai priklauso nuo variantų išrinkimo tvarkos
* Svarbu, kad pakartotiniai netikriname jau peržiūrėtus variantus, kurių skaičius greitai didėja, kai didiname parametrą n, kuris charakterizuoja uždavinio dydį
* Kai visų variantų perrinkimas neįmanomas dėl per daug didelio jų skaičiaus, naudojame euristikas, t. y. algoritmus, leidžiančius greitai patikrinti perspektyvius variantus, bet negarantuojančius tikslaus sprendinio radimo
* Kiekvieną kartą renkamės tą variantą ar paieškos kryptį, kuri šiuo žingsniu atneša didžiausią pelną


## Rekursijos metodas

Objektas apibrėžtas rekursijos būdu, jei apibrėžime vėl naudojamas tas pats objektas

Objektas, priklausantis nuo parametro, yra apibrėžiamas naudojant tą patį objektą ar objektus, tik su kitomis parametro reikšmėmis. Nurodoma rekursijos pabaiga ir nustatomos pradinės sąlygos, šių sąlygų skaičius sutampą su rekursijos gyliu.

Rekursiją naudosime sudarydami duomenų rūšiavimo, informacijos paieškos algoritmus, ja grindžiami dinaminių duomenų struktūrų pagrindiniai metodai. Rekursija patogu kontroliuoti užduočių atlikimo eiliškumą, kai dalies užduočių vykdymą atidedame vėlesniam laikui. Rekursija nebūtina, kai užduočių medyje vykdome tik vieną iš jo šakų, nors tai, kuris pomedis reikalingas, paaiškėja tik vykdant algoritmą.

* ``Prefix`` - algoritme pirmiausia išspausdiname šakninėje viršūnėje saugomą informaciją, o paskui aplankome kairiąją ir dešiniąją šakas.
* ``Infix``, arba vidiniame, algoritme primiausia aplankome kairiąją medžio šaką, paskui spausdiname šaknies informaciją ir galiausiai aplankome dešiniąją šaką
* ``Postfix``, arba atvirkštiniame, algoritme pirmiausia aplankome kairiąją medžio šaką, paskui – dešiniąją šaką ir galiausiai spausdiname šaknies informaciją

## Skaldyk ir valdyk metodas

Daugelį uždavinių efektyvius sprendimo algoritmus sudarome tokiu metodu:

* Uždavinį skaidome į kelis mažesnius uždavinius
* Randame šių uždavinių sprendinius
* Iš jų sudarome viso uždavinio sprendinį

Dalinius uždavinius vėl galime spręsti tokiu pačiu metodu, taip skaidome tol, kol gautieji uždaviniai yra lengvai išsprendžiami. Pažymėtina, kad dažnai tam pačiam uždaviniui skaldyk ir valdyk metodu galime sudaryti kelis skirtingus sprendimo algoritmu

Dažniausiai uždavinį skaidome į du mažesnius uždavinius. Šiuo žingsniu siekiame visą uždavinį padalinti į vienodos apimties dalis. Skaidymo subalansuotumo principą nesunku pagrįsti taikant variacinio skaičiavimo metodus.

## Šakų ir rėžių metodas

Pagrindiniai šakų ir rėžių metodo žingsniai yra šie:

* Skaidymo žingsnis
* Rėžių skaičiavimas

### Skaidymo žingsnis

* Leistinųjų sprendinių aibę skaidome į baigtinį skaičių mažesnių aibių
* Tada funkcijos ``f(X)`` minimumo paieškos algoritmą patogu vaizduoti medžio duomenų struktūroje
* Medžio šaknyje užrašome uždavinį ``P(f,D)``, šaknies ``m`` vaikai apibrėžia uždavinius ``P(f,Di)``, t. y. funkciją ``f(X)`` minimizuojame srityse ``Di``.
* Toks skaidymo procesas tęsiamas, kol nesunkiai apskaičiuojame gautojo uždavinio sprendinį.

### Rėžių skaičiavimas

* Algoritme turi egzistuoti galimybė efektyviai apskaičiuoti funkcijos ``f(X)`` reikšmių apatinius ``LB(f,Di)`` ir viršutinių ``UB(f,Di)`` rėžius
* Tada žinodami ``UB(f,Di)``, galime apskaičiuoti minimalios reikšmės ``f(X0)`` viršutinį rėžį ``UB(f,D)`` visoje aibėje ``D``
* Žinodami šiuos rėžius, dažnai galime gerokai sumažinti nagrinėjamų sričių skaičių
* Jeigu srityje ``Di`` apatinis ``f(X)`` reikšmių rėžis ``LB(f,Di)`` yra didesnis už ``UB(f,D)``
* Tai tokios srities toliau nebetiriame, nes joje tikrai nėra optimalaus sprendinio
* Visos užduotys saugomos sąraše ``L``, o sąraše ``S`` saugome uždavinio sprendinius
* Naują užduotį išimame iš sąrašo ``L``, naudodami parinkimo taisyklę

Dažniausiai pasitaiko šios taisyklės:

* Naujausia užduotis. Tiriame užduoti, kurią vėliausiai sugeneravome. Naudodami tokią strategiją, greitai judame į variantų medžio gilumą ir minimizuojame užduočių skaičių. Sąrašą ``L`` realizuojame naudodami dėklo duomenų struktūrą
* Perspektyviausia užduotis. Tiriame užduotį ``P(f,Di)``, kurios sprendinių apatinis įvertis ``LB(f, Di)`` yra mažiausias. Tikimės, kad skaidydami užduotį, greičiau rasime gerus sprendinio artinius arba pavyks iš esmės sumažinti viršutinį sprendinio įvertį ``UB(f,D)``. Tada smarkiai sumažės ir nagrinėjamų variantų skaičius. Sąrašą ``L`` realizuojame naudodami piramidės duomenų struktūrą
* Mažiausio lygio užduotis. Tiriame užduotį ``P(f,Di)``, kurios lygis medyje yra mažiausias. Naudodami šią strategiją, tolygiai nagrinėjame visą leistinųjų sprendinių aibę, t. y. tikimės išvengti detalaus nereikalingų lokaliųjų minimumų nagrinėjimo. Sąrašą ``L`` realizuojame naudodami eilės struktūrą

## Dinaminio programavimo metodas

Taikytinas tada, kai tenkinamos tokios sąlygos:

* Algoritmo vykdymo metu generuojamos užduočių aibės esmingai persidengia, todėl daug kartų sprendžiame tas pačias užduotis. Dinaminio programavimo metode įsimename jau spręstų užduočių sprendinius ir sprendžiame tik naujus uždavinius
* Uždavinys tenkina Belmano sąlyga, kad optimalus sprendinys yra sudarytas iš atskirų mažesnių užduočių optimalių sprendinių. Šią sąlygą užrašome rekurentinės lygybės forma, ji smarkiai sumažina nagrinėjamų variantų skaičių

Skaldyk ir valdyk algoritme užduotys generuojamos iš viršaus į apačią, t. y. pradinis uždavinys skaidomas į kelias mažesnes užduotis, kurios toliau dalijamos į mažesnes

Dinaminio programavimo metode uždavinį pradedame spręsti nuo mažiausių ir lengvai išsprendžiamų užduočių, jų rezultatus naudojame spręsdami didesnes užduotis ir taip surandame viso uždavinio sprendinį.

Nagrinėjame tik tuos variantus, kurių gali prireikti optimaliai strategijai sudaryti

Tokios strategijos pranašumus jau matėme nagrinėdami kai kuriuos rekursinius algoritmus, pvz., Fibonačio skaičius



