# Uzrasykite kiek imanoma trumpesne komanda, kuri sudarytu matrica is 10 eiluciu ir 2 stulpeliu, kur visi pirmo stulpelio nariai lygus 1, o antro lygus 2
matrix(rep(1:2, times=10),2)

# Sukurkite antros eiles kvadratine matrica sudaryta is praleistu reiksmiu
matrix(1:4,2,2)   

# Naudojant funkcija dim parasykite tokia komanda, kuri transponuotu matrica
m <- matrix(1:16, 8,2)
m
dim(m) <- c(2,8)
m

# Uzrasykite komanda, kuri matricos m stulpelius sukeistu vietomis
dim(m) <- c(4,4)
rownames(m) <- c("X", "Y", "Z", "A")
m
m[, 4:1]

# Uzrasykite komanda, kuri iskirtu pirmus tris Y stulpelio elementus
m["Y", 1:3]

# Uzrasykite komanda, kuri is matricos m isskirtu nelyginius pirmo stulpelio narius isdestytus mazejancia tvarka



