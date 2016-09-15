# Išvardinkite ir trumpai aptarkite 3 pagrindinius operacinių sistemų projektavimo aspektus, susietus su vienalaikiu procesų (gijų) vykdymu.

OS turi:

* Sekti procesų vykdymą, naudojant procesų valdymo blokus
* Skirstyti ir laisvinti išteklius: CPĮ laikas, atminties erdvė; failai; Į-I įrenginiai;
* Apsaugoti proceso duomenis ir išteklius nuo kitų procesų poveikio
* Proceso vykdymo rezultatas neturi priklausyti nuo kitų lygiagrečiai vykdomų procesų spartos

# Išvadinkite ir trumpai aptarkite 3 viena-laiko propcesų (gijų) vykdymo apraiškas

Daugelio procesų ir gijų vykdymo apraiškos:

* Daugiaprogramis režimas -- aplikacijos kartu vartoja CPĮ darbo laiką;
* Multiprocessing -- aplikacijos naudoja daugiau negu vieną CPĮ;
* Distributed Processing -- aplikacija naudoja daugiau negu vieną fizinę mašiną;

# Apibūdinkite pagrindinius reikalavimus, keliamus procesams, vykdomiems vienu metu.

Trys esminiai reikalavimai procesams:

* Turi turėti tarpusavio atmetimą, taip valdant kritines sekcijos priėjimą;
* Neturi blokuoti vienas kito;
* Neturi badauti -- keli procesai aktyvūs, tuo tarpu keli laukimo būsenoje;

# Aptarkite tris galimus sąveikos tarp procesų scenarijus.

* Procesai nieko nežino apie kitą; Konkurencinis išteklių naudojimas
    * Rungtyniavimo situacija
    * Vieno proceso rezultatai neturi įtakos kitiems procesams
    * Galima įtaka proceso vykdymo trukmei
* Procesai netiesiogiai informuoti apie kitus procesus;
    * Sąveika kartu naudojant bendrąjį objektą
    * Vieno proceso rezultatai gali priklausyti nuo informacijos, gautos iš kitų procesų
    * Galima įtaka proceso vykdymo trukmei
* Procesai tiesiogiai informuoti apie kitus procesus;
    * Sąveika komunikavimo priemonėmis
    * Vieno proceso rezultatai gali priklausyti nuo informacijos, gautos iš kitų procesų
    * Galima įtaka proceso vykdymo trukmei

# Nurodykite skirtumus tarp izoliuotų procesų vykdomų vienu metu ir sąveikaujančių procesų.

Izoliuoti procesai nenaudoja tų pačių išteklių ir jiems visiškai nerūpi kitų procesų gautas rezultatas, tuo tarpu sąveikaujantys procesai naudoja bendrus sistemos išteklius ir jiems rūpi vienas kito rezultatas.

# Apibūdinkite procesų rungtyniavimo (angl. concurrency) sąvoką.

Situacija, kuomet kelios gijos arba procesų skaito ir rašo kolektyviai naudojamus duomenis, o galutinis rezultatas priklauso nuo santykinės gijų vykdymo trukmės (nuo vykdymo eiliškumo)

# Išvardinkite tris vienalaikio procesų vykdymo problemas ir trumpai aptarkite jas.

* Kritinė sekcija -- programinio kodo dalis, kurioje procesas kreipiasi į kolektyviai naudojamus išteklius (duomenis) ir kuri negali būti vykdoma, kol koks nors kitas procesas veikia savo analogiškoje programinio kodo dalyje;
* Aklavietė -- situacija, kai du ar daugiau procesų negali būti vykdomi, kadangi vienas iš kito kažko laukia;
* Nestabilus blokavimas -- situacija, kai du ar daugiau procesų nuolat keičia savo būseną kaip atsakas į kito proceso keitimus, nevykdant nieko naudingo;

# Išvardinkite tarpusavio atmetimo reikalavimus.

Reikalavimas, kad, kai vienas procesas dirba sekcijoje, kurioje manipuliuojama kolektyviai naudojamais ištekliais, joks kitas procesas negali būti savo kritinėje sekcijoje, kur manipuliuojama tais pačiais ištekliais.

* Tam tikru momentu kolektyviai naudojamo išteklio kritinėje sekcijoje gali būti tik vienas procesas
* Nekritinėje zonoje baigiantis darbą procesas neturi turėti įtakos kitiems procesams
* Laukimas įeiti į kritinę sekciją neturi būti begalinis -- negali būti tarpusavio blokavimo ar badavimo;
* Kritinėje sekcijoje nesant vienam procesui, bet kuris, įėjimo į kritinę sekciją pareikalavęs procesas, turi ją iškarto gauti;
* Nedaromos jokios prielaidos apie procesų kiekį arba jų atlikimo santykinę spartą
* Kritinėje sekcijoje procesas gali išbūti tik ribotą trukmę

# Kokios operacijos gali būti vykdomos su semaforais?

Su semaforu galima atlikti tris atomines operacijas:

* Semaforas gali būti inicijuotas ne neigiama verte;
* Dekremento operacija;
* Inkremento operacija;

# Koks skirtumas tarp binarinių ir bendrojo pobūdžio semaforų?

Semaforo signalo laukiantis procesas yra blokuojamas, kol tas signalas nebus išsiųstas kito proceso. Semaforo signalo laukiantys procesai rikiuojami į eilę ties šiuo semaforu.

Binarinių semaforų atveju užblokuoti semaforą gali vienas procesas, o atblokuoti kitas.

# Koks skirtumas tarp "stipriojo" ir "silpnojo" semaforo?

Stipriojo semaforo atveju procesai šalinami iš eilės, eilės tvarka;
Silpnojo semaforo atveju procesai šalinami iš eilės atsitiktine tvarka;

# Aptarkite, kokiais atvejais procesorinio laiko požiūriu koncepcija "laukimas kol užimta" yra efektyvesnė, negu blokuojantis laukimas, kaip, pvz, semaforuose?

Semaforo, Petersono atveju, yra duodama garantija, jog procesai tarpusavio komunikacijai turi bent kažkiek bendros atminties ir gali ją naudotis valdant kritines sekcijas. Jeigu mes norime pasiekti distributed processing, tai mes negalima laikytis vien tik bendros atminties, todėl mums reikia kito priėjimo prie problemos -- naudojant "laukimas, kol užimta".

# Ką vadiname monitoriumi?

Monitorius yra programavimo kalbos konstrukcija, užtikrinanti semaforui analogišką funkcionalumą, tačiau valdoma žymiai papraščiau.

# Užduotis 5.4

Atominė operacija yra tokia tokia operacija, kuri užtikrina, kad esant daugiau negu vienai gijai modifikuojant resursą -- kita gija negaus resurso pusiau pakeisto, kita gija resursą paima tik pasibaigus kitos gijos darbui.

Tai reiškia, kad kai gija A dirba su kintamuoju x, gija B negali jo nei skaityti, nei rašyti. Ir atvirkščiai, kai tik gija B dirba su kintamuoju x, gija A negali su juo nieko daryti.

* x = 1
* y = 5 (Atėjo modifikacija iš gijos B)
* y = 4 (Šita operacija bus atliekama B ankščiau, todėl gija A gaus y=4)
* y = 6 (Gija A užblokavo operacija ant kintamojo y, todėl gija B gaus y=5)

# Užduotis  5.5

Terminas "laukiama, kol užimta" arba _busy waiting_ reiškia procesą, kuris nuolat tikrina ar galima įeiti į kritinę sekciją. Jis laukia, kol sekcija atsilaisvins.

Kitas metodas, kuris leidžia užtikrinti tarpusavio atmetimą, yra Petersono algoritmas. Algoritmas naudoja du kintamuosius, `flag` ir `turn`.

```
bool flag[2] = { false, false };
int turn;
```

Kintamojo `flag[n]` `true` reikšmė parodo, kad procesas `n` nori įeiti į kritinę sekciją. Įėjimas į kritinę sekciją yra garantuojamas procesui `P0`, jeigu procesas `P1` nenori įeiti į kritinę sekaciją arba jeigu `P1` turi aukštesnį prioritetą už `P0`.

Algoritmas patenkina visus tris kritinės sekcijos problemos sprendimo reikalavimus (_mutual exclusion_, _progress_, _bounded waiting_), turint omenyje, kad kintamųjų `turn`, `flag[0]` ir `flag[1]` reikšmės keičiasi iškarto ir atomiškai.

# Užduotis 5.6

```
Pradzioje turn=0; flag[0] = false; flag[1] = false;

P(1) paleidžia:
* blocked[id] = true;
* while (turn != id)
* while (blocked[1-id])

Tuomet P(0) paleidžia:
* blocked[id] = true;
* while (turn != id)
* /* critical section */

P(1) leidzia:
* turn = id;
* while (turn != id)
* /* critical section */

```

Tokiu būdu abu procesai naudoja kritinę sekaciją.

# Užduotis 5.12

```
const int n = /* number of processes */
int bolt;
void P(int i)
{
    while (true) {
        while (!test_and_set(bolt)) {
            /* do nothing */
        }
        /* critical section */
        bolt = 0;
        /* remainder */
    }
}
void main()
{
    bolt = 0;
    parbegin(P(1), P(2), ..., P(n));
}
```

```
int const n = /* number of processes */
int bolt;
void P(int i)
{
    int keyi = 1;
    while (true) {
        // labai nesuprantu, kam cia ir kodėl reikia keisti -- lagoritmas veikia puikiai ir be papildomos procedūros
        while (!test_and_set(bolt));
        do exchange (keyi, bolt);
        while (keyi != 0);
        /* critical section */
        bolt = 0;
        /* remainder */
    }
}
void main()
{
    bolt = 0;
    parbegin(P(1), P(2), ..., P(n))
}

```

# Užduotis 5.23

Visas priklauso nuo to, kuomet vartotojas šauna gamintojui signalą apie užpildytą buferį.

Užduotyje nėra jokio algoritmo, ką reikia tobulinti?

# Užduotis 20

Tokiu atveju yra galimas race condition, jeigu antras procesas pakeičia kintamąjį iškart po to, kai tik pirmas procesas nuskaito kitamąjį.


# Užduotis 22

Taip, `exchange_mem_reg` atominė instrukcija gali būti panaudoja valdant priėjimą prie kritinės sekcijos. Tai tiesioginis `test_and_set_lock` pakeitimas.

# Užduotis 23

Paprastas semaforų įgyvendinimo būdas yra up ir down sisteminiai kvietimai, kuomet operacinė sistema trumpam išjungia visus savo pertrauktis, kol yra testuojamas semaforas. Visi šitie veiksmai užima tik pora instrukcijų, todėl jokios žalos nėra išjungiant pertrauktis.

# Užduotis 26

Ciklinis planavimo algoritmas visiškai neturi prioriteto paskirstymo, todėl jo atveju nebus svarbu ar H procesas yra aukštesnio prioriteto už L procesą ar be. Tokiu atveju irgi gali labai lengvai susidaryti situacija dėl mažiau kritinio proceso užimamos kritinės sekcijos.

Kaip rizikos mažinimo operacija mažo prioriteto procesams galima nusakyti mažesnį kritinės sekcijos naudojimo laiką. Taip svarbesnis procesas greičiau gaus priėjimą prie kritinės sekcijos.