v <- c(19, 5, 2, 19, 29, 42, 32, 35, 25, 18, 6, 22, 7, 28, 11, 8, 9, 37, 45, 23)

suma <- 0

for (i in 1:length(v)) {
    suma <- suma + v[i]
}

suma

suma <- 0

for (i in v) {
    suma <- suma + i
}

suma

sum(suma)


riba <- 30
suma <- 0
kiek <- 0

for (i in seq_along(v)) {
    if (v[i] > riba) {
        suma <- suma + v[i]
        kiek <- kiek + 1
    }
}

suma
kiek

sum(v[v > riba])
sum(v > riba)

nelyginiai <- seq(1, length(v), by = 2)

for (i in nelyginiai) {
    cat("elemento", i, "reiksme:", v[i], "\n")
}

v[nelyginiai]

zodis <- c("L", "I", "E", "T", "U", "V", "A")

