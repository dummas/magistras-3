# 7 skyrius

## Išvardinkite ir trumpai aptarkite reikalavimus, kuriuos turi tenkinti atminties valdymas.

* Perkėlimo galimybė {Reloaction}
    * Programuotojas nežino, kur programa bus išdėstyta atmintyje vykdymo metu
    * Programa vykdymo metu gali būti grąžinama į diskinį kaupiklį, o vėliau vėl keliama į atmintį jau kitoje vietoje
    * Taigi, besikreipiant į atmintį turi būti užtikrinta galimybė transliuoti loginius adresus į fizinius atminties adresus
* Apsauga {Protection}
    * Procesas be specialaus leidimo neturi turėti galimybės kreiptis į kito proceso erdvę
    * Tikrinti absoliučius adresus programos kompiliavimo metu neįmanoma; procesas gali būti perkeltas į kitą vietą;
    * Adresai turi būti tikrinami vykdymo metu; OS negali tikrinti kiekvienos proceso kreipties į atmintį (ilgiau trunka); Apsauga turi būti įgyvendinta aparatinėmis priemonėmis;
* Kolektyvusis naudojimas {Sharding}
    * Apsaugos mechanizmas turi turėti galimybę leisti procesams kreiptis į tam tikras atminties sritis
    * Geriau leisti procesams (naudotojams) kreiptis į tą pačią proceso kopiją (nepažeidžiant apsaugos reikalavimų), nei kurti atskiras kopijas;
    * Perkėlimo mechanizmai papildomai užtikrina ir saugųjį bendrą atminties naudojimą
* Loginė sandara {Logical organization}
    * Fizinė atminties organizuota kaip žodžių (baitų) vienmatis masyvas {linearly}
    * Loginiu požiūriu programos rašomos kaip modulių visuma. Dvimatis (daugiamatis) masyvas;
    * Aparatinės įrangos ir OS gebėjimas dirbti su moduliais pateiktomis programomis turi daug privalumų:
        * Moduliai gali būti kuriami ir kompiliuojami nepriklausomai vienas nuo kit;
        * Nuorodos iš vieno modulio š kitą suderinamos programos vykdymo metu;
        * Moduliai gali turėti skirtingo lygio apsaugą;
        * Kolektyvusis modulių naudojimas;
        * Modulinę sandarą palaiko padalinimo į segmentus technologija;
* Fizinė sandara {Physical organization}
    * Kompiuterio atminties sistemą yra dviejų lygmenų: pagrindinė, antrinė;
    
    
## Kodėl yra pageidautina užtikrinti proceso perkėlimo atmintyje galimybę?

* Programuotojas nežino, kur programa bus išdėstyta atmintyje vykdymo metu
* Programa vykdymo metu gali būti grąžinama į diskinį kaupiklį, o vėliau vėl keliama į atmintį jau kitoje vietoje
* Taigi, besikreipiant į atmintį turi būti užtikrinta galimybė transliuoti loginius adresus į fizinius atminties adresus


## Nurodykite priežasties dėl kurių keliems procesams gali prireikti kreiptis į tą pačią atminties sritį

* Apsaugos mechanizmas turi turėti galimybę leisti procesams kreiptis į tam tikras atminties sritis
* Geriau leisti procesams (naudotojams) kreiptis į tą pačią proceso kopiją (nepažeidžiant apsaugos reikalavimų), nei kurti atskiras kopijas;
* Perkėlimo mechanizmai papildomai užtikrina ir saugųjį bendrą atminties naudojimą


## Aptarkite privalumus naudoti skirtingo dydžio skyrius fiksuoto atminties paskirstymo schemoje.

* Fiksuoto vienodo dydžio skyrių problemos:
    *  Procesas gali netilpti skyriuje
    * Pagrindinė atmintis naudojama neefektyviai
* Skirtingo dydžio skyriai iš dalies sprendžia abi problemas:
    * Stambus procesas gali būti išdėstytas atmintyje be perdangų;
    * Mažesnio dydžio procesai gali būti išdėstyti mažesniuose skyriuose, mažinant vidinę fragmentaciją
    
## Kuo skiriasi vidinė ir išorinė fragmentacija?

* Vidinė fragmentacija -- atminties erdvės praradimas, kuris nėra fiksuojamas operacinės sistemos (atminties erdvės fragmentai pernelyg maži);
* Išorinė fragmentacija -- atminties erdvės fragmentai "nesiliečia" vienas su kitu ir juose nepavyksta išdėstyti stambaus proceso

## Kuo skiriasi loginiai ir fiziniai kreipimosi į atmintį adresai?

Loginis adresas atitinka tam tikrą procesą, mažiausia loginio adreso reikšmė -- 0, o didžiausia priklauso nuo proceso dydžio.

Fizinis adresas atitinka tam tikrą atminties ląstelę. Fizinio adreso skaitinė reikšmė gaunama iš loginio adreso atsižvelgus į atminties valdymo technologiją;

## Kuo skiriasi puslapis ir kadras?

Puslapis -- fiksuoto dydžio proceso (loginės atminties) dalis;
Kadras -- tokio pats dydžio fizinės atminties dalis;

## Kuo skiriasi puslapis ir segmentas?

Visi puslapiai yra vienodo fiksuoto dydžio, tuo tarpu segmento dydis priklauso nuo programos tam tikros dalies (modulio) pradinio kodo dydžio. 


## Užduotis 7.2

Tarkime, daugelio programų sistemoje naudojama atminties padalinimo į fiksuoto dydžio skyrius schema, kurių dydžiai yra: 1 skyrius -- 20KB, 2 skyrius -- 30 KB, 3 skyrius -- 50 KB. Tarime lentelėje pateikti procesai turi būti išdėstyti atmintyje. Darom prielaidą, kad visi procesai atsirado kompiuteryje vienu metu eilės tvarka. Laikas, nurodytas lentelėje, atitinka proceso atlikimo laiką (planavimas, vykdymas, kaitaliojimas ir laukimas). Gavus atminties skyrių procesas jame išbūna kol nebus baigtas.

### Kiek užtruks kiekvieno proceso atlikimas, jeigu naudojama ''Geriausiai tinkanti'' {best - fit} paieškos strategija?
### Kiek užtruks kiekvieno proceso atlikimas, jei naudojama ''pirma tinkanti'' {first - fit} paieškos strategija?
### Kiek užtruks kiekvieno proceso atlikimas, jei naudojama ''prasčiausiai tinkanti'' {worst - fit} paieškos strategija?

## Užduotis 7.5

Tarkime, kad OS atminties erdvę valdo pagal ``antrininkų'' schemą. Kompiuterio pagrindinės atminties talpa -- 1MB. Pavaizduoti tokių užklausimų apdorojimo rezultatą:

* Užklausimas A = 70 KB;
* Užklausimas B = 35 KB;
* Užklausimas C = 80 KB;
* Atlaisvinamas A;
* Užklausimas D = 60 KB;
* Atlaisvinamas B;
* Atlaisvinamas D;
* Atlaisvinamas C;

## Užduotis 7.6

Tarkime, atminties valdymui naudojama dinaminė skyrių skirstymo schema ir duotam laiko momentui atminties padalinta taip:

... grafikas ..


Tamsesnės vietos žymi užimtus skyrius, baltos -- laisvus blokus. Užklausimai iš procesų atminties sritims atsirado tokia tvarka: 40 MB, 20 MB ir 10 MB. Nurodykite pradinį fizinį kiekvieno proceso, jeigu taikomos tokios neužimtų blokų paieškos strategijos:

* "pirma -- tinkanti" {first - fit};
* "geriausiai tinkanti" {best - fit};
* "prasčiausiai tinkanti" {worst fit}

## Užduotis 7.13

Virtualusis (loginis) adresas a padalinimo į puslapius {paging} atminties valdymo schemoje yra sudarytas iš dviejų dalių: p - puslapio numeris ir d - poslinkis puslapyje. Tarkime, puslapio dydis - z baitų. Išveskite formulę, vaizduojančią sąryšį tarp p ir d, kaip funkcija z ir a.

## Užduotis 7.14

Tarkime, atminties yra valdoma pagal padalinimo į segmentus schemą. Segmentų lentelė atrodo taip:

| Segmento pradinis adresas | Segmento ilgis, baitais |
| 660 | 248 |
| 1752 | 422 |
| 222 | 198 | 
| 996 | 604 |

Nustatykite fizinį adresą, kiekvienam loginiam adresui, arba pažymėkite klaidos atvejį:

* 0, 198;
* 2, 156;
* 1, 530;
* 3, 444;
* 0, 222;