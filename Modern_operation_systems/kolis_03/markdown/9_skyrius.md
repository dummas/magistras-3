# 9 skyrius

## Glaustai aptarkite tris CPU darbo laiko planavimo tipus

* Pirmas atėjo -- pirmas apdorotas; Pats paprasčiausias procesų planavimo laiko planavimo tipas; Yra viena procesų eilė; Kai pirmas darbas ateina į sistemą iš išorės -- jis nedelsiant pradedamas atlikti ir jis dirba tiek, kiek jam reikia; Kai tik ateina nauji darbai -- jie statomi į eilės galą ir laukia savo cpu eilės;
* Pirmiausiai apdorojamas trumpiausias darbas; Jeigu iš anksto yra žinoma kiek kiekvienas procesas eilėje gali užimti -- cpu duodamas tam, kuris dirbs mažiausiai; Taip sumažėja kiekvieno proceso laukimo laikas;
* Trumpiausias baigties laikas pirmas; Kai ateina naujas darbas, jo darbo laikas yra lyginamas su tik ką pasibaigusio proceso laiku, ir jeigu jis yra trumpesnis, negu to proceso -- tas procesas gauna cpu, o kiti, didesni, laukia. Tokia schema leidžia naujesniems trumpiems darbams gauti greičiau cpu laiko;


## Nurodykite našumo kriterijų interaktyviųjų operacinių sistemų atveju

Proceso pakeitimo laikas yra našumo kriterijus;

## Koks skirtumas tarp apyvartos (turnaround) ir atsako (response) trukmės sąvokų?

Apyvartos trukmė yra laikas, nuo proceso priėmimo, jo apdorojimas ir rezultato atidavimo;
Atsako trukmė yra laikas, nuo proceso priėmimo ir pirmo atsako gavimas iš jo;

## Planavimo pagal prioritetus atveju mažas skaičius, žymintis proceso prioritetą, reiškia, jog procesas yra aukšto ar žemo prioriteto?

Žemo prioriteto.

## Aptarkite skirtumą tarp išstumiančiosios (preemptive) ir neišstumiančiosios (nonpreemptive) planavimo algoritmo įgyvendinimo schemos?

Preemptive -- vykdomą procesą OS gali pristabdyti ir perkelti į parengtųjų procesų eilę;
Nonpreemptive -- procesas gavę procesorių yra vykdomas kol nesibaigs arba jam neprireiks Į/I operacijos;

## Glaustai aptarkite planavimo strategiją "pirmas atėjo -- pirmas aptarnautas"

Visi procesai išdėstyti parengtųjų eilėje. Esamam procesui paliekant vykdomo būklę, iš parengtųjų eilės pasirenkamas seniausias procesas. Trumpam procesui gali teikti laukti pernelyg ilgai kol gaus CPĮ.

## Glaustai aptarkite ciklinę planavimo strategiją

Periodiškai generuojamos laikrodžio pertrauktys; Atsiradus pertraukčiai, procesas grąžinamas į parengtųjų eilę -- pasirenkamas kitas parengtas darbas; Tokio pobūdžio planavimas dar vadinamas laiko kvantavimo;

## Glaustai aptarkite planavimo strategiją "trumpiausias procesas -- sekantis"

Įgyvendinimo schema yra be pralenkimų. Pasirenkamas procesas, su trumpiausia numatoma apdorojimo trukme. Trumpesnieji procesai aptarnaujami prieš ilguosius; Mažinama ilgųjų procesų pirmenybė; Galimas ilgų procesų badavimas; 

## Glaustai aptarkite planavimo strategiją "aukščiausias atsako santykis -- sekantis"

Pasirenkamas procesas su didžiausiu santykiu tarp proceso laukimo laiko ir darbo laiku per darbo laiką;

## Glaustai aptarkite planavimo strategiją "grįžtamasis ryšys" (feedback)

Procesai gauna laiko kvantus ir vėliau išstumiami iš eilės į žemesniojo rango eilę, jeigu neužbaigiami per gautą kvantą; 

## Užduotis 9.1

Tarkime, kompiuterizuotoje sistemoje vykdomi žemiau lentelėje pateikti procesai

| Procesas | CPI paketo trukmė | Prioritetas | Atsiradimo momentas |
| - | - | - | - |
| P1 | 50 ms | 4 | 0 ms |
| P2 | 20 ms | 1 | 20 ms |
| P3 | 100 ms | 3 | 40 ms |
| P4 | 40 ms | 2 | 60 ms |

* Sukurkite laiko diagramas, iliustruojančias CPU darbo laiko planavimą pagal strategijas:
    * shortest-remaining-time SRT
    * prioritetinis planavimas
    * ciklinę planavimo strategiją, kai laiko kvantas -- 30 ms
* Apskaičiuokite vidutinę laukimo ir apyvartos trukmes kiekvienai punkte nurodytai strategijai;

## Užduotis 9.2
