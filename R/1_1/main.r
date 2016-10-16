# Patikrintkite teisini, kad vektoriaus d ir jo vardo vektoriaus ilgiai sutampa
d <- c(sausis = 31, vasaris = 28, kovas = 31, balandis = 30)
length(d) == length(names(d))

# Apskaiciuokite, kokio ilgio yra vektorius LETTERS
length(LETTERS)

# Apskaiciuokite vektoriaus u ilgi ir nustatykite jo tipa
x <- c(1,2,3)
y <- c(4,5,6)
z <- c(7,8,9)
u <- c(x,y,z)
length(u)
mode(u)

# Sugalvokite, kaip vektoriaus vardus panaikinti naudojant komanda attr
a <- c("I" = 1, "II" = 2, "III" = 3, "IV" = 4, "V" = 5)
attr(a, "names") <- NULL

# Naudodami indekso vektoriu, vektoriaus d elementus istrikkiuokite priesinga tvarka
i <- c(4,3,2,1)
d[i]

# Sudarykite tokia indekso vektoriu, kuri naudojant pirmasis vektoriaus d elementas butu isrenkamas tris kartus
i <- c(1,1,1)
d[i]

# Is vektoriaus d istrinkite tuos elementus, kuriu reiksme tiksliai lygi 30
i <- d == 30
d[i]

# Sudarykite toki vardu vektoriu, kad vektoriaus d elementus isvestu ju vardu abeceles tvarka
i <- c(4, 3, 1, 2)
names(d)[i]

# Uzrasykite komanda, kuri bet kokio ilgio vektoriui isrinktu paskutini to vektoriaus vardu vektoriaus elementa
names(d)
names(d)[length(d)]

# Su komanda seq sudarykite seka is mazesniu nei 100 nelyginiu naturiniu skaiciu
seq(1,100, by=2)

# Su komanda seq sudarykite seka, kuri atkarpa [0, 1] padalina i 10 lygiu daliu
seq(0, 1, by=0.11111)

# Antro uzdavinio rezultata gaukite funkcijoje nenaudojant parametro by
seq(0, 1, length.out=10)

# Antro uzdavinio rezultata gaukite is vis nenaudodami funkcijos seq
0:10/11

# Komandos rep(1, 5) rezultata gaukite panaudodami funkcija seq
seq(1, 1, length.out=5)

# Uzrasykite rep komanda, kuris is vektoriaus v sudarytu seka 1, 2, 2, 3, 3, 3
v <- 1:3
rep(v, times=c(1,2,3))
