# 8 skyrius

## Kuo skiriasi įprasto padalinimo į puslapius atminties valdymo schema {pagging} ir virtualioji atmintis?

Paprastas puslapiavimas -- visi proceso puslapiai turi būti pagrindinėje atmintyje, kad procesas dirbtų, nebent naudojamas perdengimas; Virtualioji atmintis -- ne visi proceso atminties puslapiai turi būti atmintyje, kad procesas dirbtų; puslapiai gali būti nuskaityti reikalui esant;

## Paaiškinkite tuščios eigos {trashing} veikimo efektą

Veikimas tuščiąja eiga - procesas užimtas vien puslapių iškėlimu ir įkėlimu, t.y. aptarnauja pertrauktį `page_fault`. Neigiamam poveikiui sumažinti naudotinas lokalusis kadrų skyrimo algoritmas.

## Kodėl lokalumo principas ypatingai svarbus virtualiosios atminties koceptui?

Lokalumo principas gali būti panaudotas įgyvendinant programas, taip išvengiant tuščios eigos veikimo efektą.

## Iš kurių elementų sudaryta puslapių lentelė? Trumpai aptarkite kiekvieną elementą

Puslapių lentelė sudaryta iš:
 
* Page frame number; jis nusako poslinkį atmintyje;
* Present/absent bit; jeigu jis yra 1, įrašas yra validus ir gali būti naudojamas; 0, įrašas nėra atmintyje;
* Protection bit; nusako kokie veiksmai yra galimi;
* Modified ir Referenced bit; yra naudojimo skaitikliai;

## Kokia yra transliacijos peržiūros iš šalies buferio {translation look aside buffer -- TLB} paskirtis?

Saugoti neseniai naudotų puslapių lentelių įrašus;

## Glaustai aptarkite kiekvieną puslapių keitimo algoritmą

* Optimali keitimo politika:
    * Keitimui pasirenkamas puslapis, į kurį bus nesikreipiama ilgiausiai
    * Žinoti ateities neįmanoma
* Keičiamas seniausiai naudotas
    * Keičiamas puslapis, į kurį nebuvo kreipiamasi ilgiausiai
    * Daroma prielaida, kad į tokį puslapį neturi būti kreipiamasi netolimoje ateityje
    * Sudėtingas įgyvendinti;
* Pirmas įėjo -- pirmas išėjo
    * Procesui skirti kadrai traktuojami kaip ciklinis buferis
    * Puslapiai keičiami cikliniu būdu; Paprasčiausias keitimo politikos įgyvendinimas;
    * Keičiami puslapiai, kurie atmintyje išbuvo ilgiausiai;
* Laikrodžio politika
    * Naudojamas papildomas bitas, kuris vadinamas naudojimo bitu
    * Kai puslapis įkeliamas į atmintį arba į jį pirmą kartą kreipiamasi, naudojimo butas nustatomas į 1 būsena.
    * Kai ateina laikas keisti puslapį, OS skenuoja visus atmintyje esančius puslapius, keičiant 1 į 0
    * Keičiamas turi būti tas puslapis, kurio bitas jau ankščiau buvo nustatytas į 0;

Visi puslapių keitimo algoritmai gali būti priskirti vienai iš dviejų kategorijų:

* Globalusis paskirstymas -- procesas keitimui pasirenka kadrą iš sąrašo visų įmanomų kadrų; šiuo atveju vienas procesas gali gauti kadrą iš kito proceso;
* Lokalusis paskirstymas -- procesai keitimui pasirenka kadrus tik iš "nuosavų" kadrų sąrašo;

## Užduotis 8.1

Tarkime, vykdymo proceso puslapio lentelė atrodo taip, kaip tai pateikta žemiau. Visi skaičiai lentelėje -- dešimtainiai, numeracija prasideda nuliu, o adresai atitinka baitų adresus atmintyje. Puslapio dydis lygus 1024 KB.

* Apibūdinkite, kaip virtualusis (loginis) adresas transliuojamas į fizinį
    * dvejetainis adresas yra skeliamas į puslapio numerį ir poslinkį; pasinaudojus lentele, surasti puslapio lentelę; sužinoti puslapio segmento numerį; sujungti su poslinkiu ir taip gauname fizinį adresą;
* Koks fizinis adresas (jei toks yra) atitinka pateiktus loginius adresus? (Pertraukties dėl puslapio nebuvimo atmintyje apdoroti nereikia)
    * 1052 = 1024 + 2
    * 2221 = 2 * 1024 + 173
    * 5499 = 5 & 1024 + 379

## Užduotis 8.2

Tarkime, procesui skirti keturi kadrai. Žemiau pateiktoje lentelėje pateikta: puslapio paskutinio įkėlimo į kadrą laikas, paskutinio kreipimosi į puslapį laikas, o taip pat kreipimosi {R} ir modifikavimo {M} bitai. Visi lentelėje nurodyti laikai skaičiuojami nuo proceso atlikimo pradžios. Šiuo momentu generuojamas kreipimasis į 4 puslapį. Kurio kadro turinys bus pakeistas, naudojant kiekvieną iš išvardintų strategijų? Atsakymą pagrįskite.

* Algoritmas "pirmas atėjo -- pirmas išėjo" {first in -- first out};
* Algoritmas "ilgiausiai nenaudotas" {least resently used -- lru};
* "Laikrodžio" algoritmas;
* Optimalusis algoritmas;

## Užduotis 8.3

Procesas kreipiasi į puslapius A, B, C, D ir E tokia tvarka: A B C D A B E A B C D E

Taikant algoritmą "pirmas atėjo -- pirmas išėjo" nustatykite, kiek kartų buvo sugeneruota pertrauktis `page_fault`, jeigu procesui buvo skirti 3 neužimti kadrai. Išspręskite užduotį esant 4 kadrams.

---

## Užduotis 8.4

Procesas turi 8 puslapius diskiniame kaupiklyje ir jam skirti 4 kadrai pagrindinėje atmintyje. Procesas kreipiasi į šiuos puslapius:

1 0 2 2 7 6 7 0 1 2 0 3 0 4 5 1 5 2 4 5 6 7 6 2 4 2 7 3 3 2 3

* Parodykite, kaip puslapiai buvo išdėstomi atmintyje pagal "ilgiausiai nenaudotas" algoritmą. Nustatykite kiek kartų buvo sugeneruota pertrauktis `page_fault`
* Pakartokite viską, taikant algoritmą "pirmas atėjo -- pirmas išėjo"
* Palyginkite ir pakomentuokite algoritmų veikimo, su pateikta kreipčių seka, efektyvumą.

---

## Užduotis 8.9

Aptarkime padalinimo į puslapius atminties valdymo technologiją. Tarkime, kad proceso puslapio lentelė išdėstyta pagrindinėje atmintyje.

* Jeigu kreipimasis į pagrindinę atmintį trunka 100 ns, kiek truks kreipimasis į proceso puslapį?
200 ns; 100 ns paimti puslapio lentelės įrašą, 100ns kreipitis į atmintį;

* Tarkime, dalis puslapių lentelės išdėstyta TLB buferyje, į kurį kreipimąsis trunka 10 ns. Padarius prielaidą, kad TLB efektyvumas yra 85 %, apskaičiuokite efektyviąją kreipties į atmintį trukmę.
(110 ns * 0.85) + (220 * 0.15) = 93.5 + 33 = 126.5 ns

* Paaiškinkite, kaip TLB efektyvumas įtakoja kreipties į atmintį trukmę
Kuo aukštesnis TLB efektyvumas, tuo mažesnis atminties į atmintį trukmė, kadangi 100ns bauda paimti įrašą iš atminties yra labai daug.

## Užduotis 8.15

Aptarkime padalinimo į puslapius atminties valdymo technologiją. Tarkime, kad procesas užima 32 puslapius, kurių kiekvieno dydis 2 KB. Kompiuterio fizinės atminties talpa -- 1 MB.

* Koks proceso loginio adreso formatas?
    * puslapio numeris 5 bitai
    * poslinkis 11 bitų

* Koks yra puslapių lentelės plotis ir ilgis (nevertinant kreipties leidimų bitų)?
    * 32 ilgio ir 9 pločio

* Kaip pasikeis proceso puslapių lentelės dydis, pagrindinės atminties talpa sumažėtų iki 512 KB?
    * Jeigu puslapių skaičius ir dydis nesikeičia, tuomet kiekvienas įrašas tampa 8 pločio.

## Užduotis 8.16

Kompiuteryje yra spartinančioji atmintis, pagrindinė atmintis ir diskinis kaupiklis, kurie kartu įgyvendina virtualiosios atminties koncepciją. Jeigu aktualus žodis yra spartinančiojoje atmintyje, tuomet kreipimasis į jį trunka 10 ns. Jeigu šio žodžio nėra spartinančiojoje atmintyje, tačiau yra pagrindinėje atmintyje -- įkėlimas žodžio į spartinančiąją atmintį užtruks 50 ns, po to kreipimąsi reikės kartoti. Jei ieškomo žodžio pagrindinėje atmintyje nėra -- iš diskinio kaupiklio jis bus nuskaitytas per 10 ms, po to 50 ns trunka žodžio įkėlimas į spartinančiąją atmintį ir vėl kreipimąsi reikės kartoti. Tarkime paieškos spartinančiojoje atmintyje efektyvumas siekia 90 %, o pagrindinėje atmintyje -- 60 %. Apskaičiuokite efektyviąją kreipties į žodį trukmę.

--