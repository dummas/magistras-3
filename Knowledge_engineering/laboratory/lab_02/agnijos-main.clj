;; Ekspertine sistema turi turėti:
;; - Nemažiau 20 faktu failą
;; - Nemažiau 15 taisyklių bazę

(defadvice after printout (printout t crlf))

(deftemplate preke
    "Prekes sandelyje"
    (slot pavadinimas)
    (slot kiekisDezemis))

(defrule A
    "UAB A uzsakymas"
    ?preke1 <- (preke {pavadinimas == pudraBiri1 && kiekisDezemis == 0})
    ?preke2 <- (preke {pavadinimas == kunoKremas && kiekisDezemis == 0})
    =>
    (printout t "surinkti ir issiusti UAB A uzsakyma"))

(defrule B
    "UAB B uzsakymas"
    ?preke1 <- (preke {pavadinimas == lupdazis1 && kiekisDezemis == 0})
    ?preke2 <- (preke {pavadinimas == antakiuPiestukas2 && kiekisDezemis == 0})
    ?preke3 <- (preke {pavadinimas == kremas1 && kiekisDezemis == 0})
    =>
    (printout t "surinkti ir issiusti UAB B uzsakyma"))

(defrule C
    "UAB C uzsakymas"
    ?preke1 <- (preke {pavadinimas == kunoKremas && kiekisDezemis == 0})
    ?preke2 <- (preke {pavadinimas == lupdazis3 && kiekisDezemis == 0})
    ?preke3 <- (preke {pavadinimas == lupdazis2 && kiekisDezemis == 0})
    =>
    (printout t "surinkti ir issiusti UAB C uzsakyma"))

(defrule D
  "UAB D uzsakymas"
    ?preke1 <- (preke {pavadinimas == blastienu1 && kiekisDezemis == 0})
    ?preke2 <- (preke {pavadinimas == blastienu2 && kiekisDezemis == 0})
    =>
    (printout t "surinkti ir issiusti UAB D uzsakyma"))


(defrule E
  "UAB E uzsakymas"
    ?preke1 <- (preke {pavadinimas == valiklis && kiekisDezemis == 1})
    ?preke2 <- (preke {pavadinimas == tonikas1 && kiekisDezemis == 1})
    ?preke3 <- (preke {pavadinimas == tonikas2 && kiekisDezemis == 1})
    ?preke4 <- (preke {pavadinimas == tonikas3 && kiekisDezemis == 1})
    =>
    (printout t "surinkti ir issiusti UAB E uzsakyma"))

(defrule F
  "UAB F uzsakymas"
    ?preke1 <- (preke {pavadinimas == pudraSkysta1 && kiekisDezemis == 0})
    =>
    (printout t "surinkti ir issiusti UAB F uzsakyma"))

(defrule G
  "UAB G uzsakymas"
    ?preke1 <- (preke {pavadinimas == lupdazis4 && kiekisDezemis == 0})
    ?preke2 <- (preke {pavadinimas == kvepalai && kiekisDezemis == 0})
    =>
    (printout t "surinkti ir issiusti UAB G uzsakyma"))



(defrule H
  "UAB H uzsakymas"
        ?preke1 <- (preke {pavadinimas == pudraSkysta1 && kiekisDezemis == 0})
        ?preke2 <- (preke {pavadinimas == pudraSkysta2 && kiekisDezemis == 0})
        =>
        (printout t "surinkti ir issiusti UAB H uzsakyma"))

    (defrule I
      "UAB I uzsakymas"
            ?preke1 <- (preke {pavadinimas == kremas1 && kiekisDezemis == 0})
            ?preke2 <- (preke {pavadinimas == kremas2 && kiekisDezemis == 0})
            =>
          (printout t "surinkti ir issiusti UAB I uzsakyma"))

    (defrule K
        "UAB K uzsakymas"
          ?preke1 <- (preke {pavadinimas == pudraBiri1 && kiekisDezemis == 0})
          ?preke2 <- (preke {pavadinimas == pudraBiri2 && kiekisDezemis == 0})
            =>
        (printout t "surinkti ir issiusti UAB K uzsakyma"))

    (defrule L
      "UAB L uzsakymas"
        ?preke1 <- (preke {pavadinimas == kunoKremas && kiekisDezemis == 0})
        =>
      (printout t "surinkti ir issiusti UAB L uzsakyma"))

    (defrule M
    "UAB M uzsakymas"
          ?preke1 <- (preke {pavadinimas == kremas1 && kiekisDezemis == 0})
          ?preke2 <- (preke {pavadinimas == kremas2 && kiekisDezemis == 0})
          ?preke3 <- (preke {pavadinimas == tonikas3 && kiekisDezemis == 0})
          =>
    (printout t "surinkti ir issiusti UAB M uzsakyma"))

    (defrule N
      "UAB N uzsakymas"
        ?preke1 <- (preke {pavadinimas == antakiuPiestukas1 && kiekisDezemis == 0})
        ?preke2 <- (preke {pavadinimas == antakiuPiestukas2 && kiekisDezemis == 0})
        =>
        (printout t "surinkti ir issiusti UAB N uzsakyma"))

  (defrule O
    "UAB O uzsakymas"
        ?preke1 <- (preke {pavadinimas == lupdazis1 && kiekisDezemis == 0})
        ?preke2 <- (preke {pavadinimas == blastienu1 && kiekisDezemis == 0})
        ?preke3 <- (preke {pavadinimas == antakiuPiestukas2 && kiekisDezemis == 0})
            =>
    (printout t "surinkti ir issiusti UAB O uzsakyma"))

(assert (preke (pavadinimas blastienu1) (kiekisDezemis 10)))
(assert (preke (pavadinimas blastienu2) (kiekisDezemis 2)))
(assert (preke (pavadinimas antakiuPiestukas1) (kiekisDezemis 1)))
(assert (preke (pavadinimas antakiuPiestukas2) (kiekisDezemis 5)))
(assert (preke (pavadinimas lupdazis1) (kiekisDezemis 58)))
(assert (preke (pavadinimas lupdazis2) (kiekisDezemis 14)))
(assert (preke (pavadinimas lupdazis3) (kiekisDezemis 15)))
(assert (preke (pavadinimas lupdazis4) (kiekisDezemis 8)))
(assert (preke (pavadinimas valiklis) (kiekisDezemis 5)))
(assert (preke (pavadinimas tonikas1) (kiekisDezemis 4)))
(assert (preke (pavadinimas tonikas2) (kiekisDezemis 8)))
(assert (preke (pavadinimas tonikas3) (kiekisDezemis 3)))
(assert (preke (pavadinimas kremas1) (kiekisDezemis 1)))
(assert (preke (pavadinimas kremas2) (kiekisDezemis 15)))
(assert (preke (pavadinimas kunoKremas) (kiekisDezemis 9)))
(assert (preke (pavadinimas pudraBiri1) (kiekisDezemis 3)))
(assert (preke (pavadinimas pudraBiri2) (kiekisDezemis 15)))
(assert (preke (pavadinimas pudraSkysta1) (kiekisDezemis 1)))
(assert (preke (pavadinimas pudraSkysta2) (kiekisDezemis 2)))
(assert (preke (pavadinimas kvepalai) (kiekisDezemis 5)))


(run)
