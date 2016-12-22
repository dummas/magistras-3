# Paskaita

# Sugalvoti buda, kaip skliausteliams perduoti argumentus, kadangi skliausteliai R yra funkcija

fx <- function(x,y) {
    v <- x**y
    log(v)
}

body(fx) <- expression()

tapply(iris$Sepal.Length, iris$Species, `[`, 1:10)

tapply(airquality[,1], airquality[,5], function(x) mean(x, na.rm=TRUE))
tapply(airquality[,1], airquality[,5], mean, na.rm=TRUE)

`fx<-` <- function(x, value) {
    x[1] <- value
    x
}

fx(x) <- 10

# %x%
# 1 %in% 1:10
# 'z' %in% letters

`%manoop%` <- function (a, b) {
    a/b + b/a
}

# Sukurti operatoriu, kuris patikrintu ar viena aibe yra kitos aibes poaibis
`%aib%` <- function(a, b) {
    length(intersect(x,y)) > 0
}

saknis <- .Primitive("sqrt")

df <- capture.output(data.frame)

# Funckciju klasifikacija

# Funkcijos, prie kuriu galima prieiti tiesiogiai, jos ir matomos kaip primityvios funkcijos
# .Internal
# .Primitive
# .External
# .Call

# Paketai:
# stats, optim, optimize, nls, uniroot, rnorm, qnorm, dnorm, unorm, pnorm
# eigen

# Is paketo base isrinkti visas funckijas, kurios yra primityvios
ls(,env=baseenv())[grep('Primitive', lapply(ls(,envir=baseenv()), get))]
# Is paketo base istrinkti visas funkcijas, kurios yra special ir built in
ls(,env=baseenv())[grep('.Call', lapply(ls(,envir=baseenv()), get))]
# Is paketo stats istrinkti visas funkcijas, kurios naudoja external interface
ls(name='package:stats')[grep('.External*', lapply(ls(name='package:stats'), get))]
# Is paketo base isrikti visas funkcijas, kurios naudoja internal interface
ls(,env=baseenv())[grep('.Internal', lapply(ls(,envir=baseenv()), get))]

# Kita paskaita:

# Uzduotys

# Naudojant funkcija which, suraskite numerius tu vektoriaus x elementu, kurie lygus 6 arba -6

x <- c(7, -2, 4, 24, 22, 26, 27, -2, 12, -9, -6, 0, 29, 16, -7, 6, 26, 1, 5, 12) 
which(x == 6 | x == -6)

# Uzrasykite komanda, kuri surastu nelyginiu vienzenkliu vektoriaus x elementu numerius
x[which(nchar(x)==1 & x %% 2 == 0)]

# Sugalvokite buda, kaip, nenaudojant funkcijos which.min, surasti maziausio vektoriaus elemento numeri
which(x==min(x))

# Sugalvokite buda, kaip, naudojant funkcija which.min, surasti didziausia vektoriaus elementa
