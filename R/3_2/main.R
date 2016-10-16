
# kitamojo reikmes riba
riba <- 20
# riba virsijancio dydzio skaiciaus
kiek <- 0
# riba virsijancio dydzio suma
suma <- 0
# kitamojo d reiksme gali keisti
d <- 13

if (d > riba) {
    kiek <- kiek + 1
    suma <- suma + d
} else {
    cat("Dydis nevirsija nustatytos ribos\n")
}

kiek
suma

testas <- T
x <- 0
y <- 0

if (testas) x <- 1 else y <- 1

x
y

a <- 6
b <- 2

if (a > b) {
    t <- a
    a <- b
    b <- t

    # Tarpinio kintamojo istrinimas
    rm(t)
}

a
b


z <- c(1, 2, NA, 4, 5, NA, NA, 8)

praleistas <- is.na(z)
praleistas

if (any(praleistas)) {
    i <- which(praleistas)
    cat("Elemento su praleistomis reiksmemis numeriai:\n")
    print(i)
} else {
    cat("Elementu su praleistomis reiksmemis nera.\n")
}

n <- c(2, 5, 1, 6, 8, 7, 3, 9, 4)

m <- ifelse(n %% 2 == 0, 1, -1)
m

m <- n %% 2
m


x <- 3

y <- if (x > 0) {
    f <- x
} else {
    f <- -x
}

y

x <- 3

y <- if (x > 10) 1 else 0
y

y <- if (x > 10) 1
y
