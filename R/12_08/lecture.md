# Aukštesnės eiles funkcijos

* Lambda calculus

Funkcinis programavimas pasizymi tuom, kad viskas yra funkcija.
Programavime, ir R, funkcijos gali ne tik gauti savo argumentus ivariais pavidalais. Funkcijos kaip argumentus gali gauti kitas funkcijas.
Funkcijas gali grazinti ne tik vektorius, matricas, bet gali grazinti ir kitas funkcijas.

Tai yra vadinamos aukštesnio lygio funkcijos.

    d/dx f(x) = f'(x)

Funkcionalai, yra objektai, kuriu reiksmes priklauso nuo funkcijos.

Atstumas tarp dvieju tasku, priklauso nuo funkcijos, kadangi funkcija jungia du taskus.

    f_x <- function(f, x)  {
        f(x)
    }

    f_x(sum, 1:5)
    f_x(prod, 1:5)

    f_y <- function(f, ...) {
        f(..)
    }

    I <- function(f, a, b) integrate(f,a,b);


    I(function(x) dnorm(x, mean=10, sd=10), 12, 17)

Yra kitos funkcijos, kurios yra aukstesnio lygio funkcijos (functionalai)

* lapply
* tapply
* mapply


Kodas:

    fun <- function(f,x) apply(x, 1, f)
    m <- matrix(1:100, 10, 10)
    fun(sum, m)
    fun(prod, m)
    fun(max, m)

Standartines aukšto lygio funkcijos

* Map
* Reduce
* Filter
* Negate
* Position


Mokykloje rašėme

    y = f(x)
    f: x -> y
    f: R -> R_
    
Vaizduoja vienos aibės elementus į kitos aibės elementus.
R atvaizdavimas yra apibrėžiamas kaip Map funkcija.

    Map(fx, aibe)
    
Funkcija perbėga per aibę elementų.

    l <- list(1:10, 1:5, 100:200)
    Map(sum, l)
    Map(length, l)
    
Tą pati padaro

    lapply(sum, l)
    
Iš sąrašo išrinkti nelyginius elementus

    Map(function(x) x[x %% 2 == 1], l)
    
Kažkas
    
    r <- Map(range, l)
    do.call(rbind, r)
    
Man reikia pakelti kvadratu vektoriu

    Map(function(x) x*x, 1:10)
    Map(mean, iris[1:4])
    Map(`+`, 1:5, 11:15)
    
    > Map(`+`, list(1:6), c(100,200))
    [[1]]
    [1] 101 102 103 104 105 106
    
    [[2]]
    [1] 201 202 203 204 205 206
    
    
Reikia sugeneruoti atsitiktines simbolių sekas, naudojant abecėlę ``letters``, tų sekų ilgis kinta ribose nuo 1 simbolio iki 10, simboliai gali kartotis.

Magišką funkcija ``paste``

    lapply((Map(sample, list(letters), 1:10, replace=TRUE)), paste, collapse="")
    
Funkcija Reduce naudojama redukcijai atlikti.

Turiu ``f(x)`` ir ``g(x)``, o reikia apskaičiuoti ``g(f(x))``.

    f <- function(x,y) x+y
    
    f(f(f(f(1,2),3),4),5)
    
    `+`(`+`(`+`(`+`(1,2),3),4),5)
    
    x <- c(1,2,7,12)
    y <- c(1,7,5,2)
    z <- c(7,3,1,8)
    
    intersect(intersect(x,y),z)
    
    Reduce(`+`, c(1,2,3,4,5,6))
    Reduce(`+`, c(1,2,3,4,5,6), init=0)
    
Pavyzdys

    x <- runif(1000)
    hist(x)
    
Sumuoti kol nebus 10. Tokiems sumavimams yra cumsum

    replicate(10, sample(letters, size=sample(1:10), TRUE))
    Reduce(intersect, replicate(2, sample(letters, size=sample(1:10,1), TRUE)))

Grandininės trupmenos. 

    x = a_0 + 1 /(a_1 + 1/(a_2 + 1 /( ... ))
    
Išreikšti skaičių, grandinine seka
    
    x = 415/93
    (4, 2, 6, 7)
    
Yra skirtumas, iš kurio galo taikyti Reduce operaciją

    x = 4+1/(2+1/(6+1/7)
    
Funkcija
    
    cfrac <- function(x,y) x + 1/y
    > Reduce(cfrac, c(4,2,6,7), right=TRUE)
    [1] 4.462366
    > 415/93
    [1] 4.462366

Funkcijų kompozicija

    comp <- function(f,...) f(...)
    log(cos(sin(x)))
    ff <- c(log, cos, sin)
    x <- 100
    Reduce(comp, ff, init=x, right=TRUE)
    


    ff <- c(sqrt, function(x) 1/x, function(x) 1+x, function(x) x^2)
    x <- 5
    Reduce(comp, ff, init=x, right=TRUE)
    
    ff <- rep(c(sqrt), 5)
    Reduce(comp, ff, init=x, right=TRUE)

Niutono metodas šaknies traukimui

    x^2 = n
    f(x) = x^2 - n
    
Skleidžiam viską į Teiloro eilutę

    x_(k+1) ~= (x_k+n/x_k)/2

Sprendimas
    
    sqi <- function(n) {
        function(x) (x + n/x)/2
    }
    n <- 120
    k <- 10
    x <- 100
    
    Reduce(comp, rep(c(sqi(n)), k), init=x, right=TRUE)
    
Filter naudojama elementų, kurie atitinka tam tikrą loginę sąlygą išrinkimą iš sąrašo. Sąlyga vadinama predikatu, kuri gražinama TRUE arba FALSE. Funkcija turi du pagrindinius argumetus. Pirmas argumentas yra predikatas, antras argumentas yra sąrašas elementų

Išrinkite tuos raidžių rinkinius, kurių elementų skaičius yra lyginis

    Filter(function(x)length(x) %% 2 == 1, replicate(2, sample(letters, size=sample(1:10,1), TRUE)))
    
Daugiau negu 7

    Filter(function(x)length(x) > 7, replicate(2, sample(letters, size=sample(1:10,1), TRUE)))
    l[sapply(l, length) > 7]


Išrinkti iš paketo base visas primityvias funkcijas

    ls(,env=baseenv())[grep('Primitive', Filter(ls(,envir=baseenv()), get))]


Neigimo funkcija

    is.notfunction <- function(x) !is.function(x)
    Filter(is.notfunction, lapply(ls(,envir=baseenv()), get))

Iš base paketo išrinkti visas funkcijas, kurios savo varde turi priskyrimo simbolį ``<-``

    Filter(function(x) grepl("<-",x), ls(,envir=baseenv()))
    
    Position(function(x) grepl("<-",x), ls(,envir=baseenv()))

# Aplinkos

``baseenv()`` yra funkcija, kuri gražina bazinio paketo aplinką.
Žymiai dažniau yra reikalinga globali aplinka. Jinai vadinasi ``globalenv()``. Dar yra ``emptyenv()``

Aplinką, kurioje mes dirbame nurodoma ``environment()``. 
Gražins mums global.
Rašoma su tašku priekyje -- ``.GlobalEnv``, čia yra vardas. Kada rašome funkciją ``ls`` arba ``get``. 
Pagal nutylėjimą ieškome globalioje aplinkoje.

Ieškokim objekto ``l``, baziniam pakete

    get("l", envir=baseenv())
    
Aplinka taip pat yra objektas. Net aplinkos, kurioje gyvena kiti objektai, vadinami objektais.

Norint sužinoti kokios aplinkos dabartinės aplinkos tėvinė aplinka

    parent.env(baseenv())
    
Aplinka susideda iš dviejų dalių:

* Aplinkai priklausančių vardų aibė
* Nuorodos į aukštesnio lygio aplinkas (enclosing environment)

Paprastam sąraše (list) vardai gali būti neunikalūs. Aplinkoje visi vardai turi būti unikalūs. 

Vardų / objektų tvarka neturi jokios prasmės. Frame jie visi yra lygiaverčiai.

Sąrašas neturi jokios tėvinės aplinkos, o aplinka turi savo tėvinę aplinką. Dataframe'as taip pat šiek tiek primena aplinkas, dėl to lentelėje taip pat yra kažkokie kintamieji, jie visi gyvena viduje, tačiau data frame vardai gali būti neunikalūs. Nėra nuorodų.

Galima pažiūrėti kuriame environment gyvena funkcija

    environment(mean)

Seka aplinkų

    search()
