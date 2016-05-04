;; Ekspertine sistema turi turėti:
;; - Nemažiau 20 faktu failą
;; - Nemažiau 15 taisyklių bazę

;; Duoti paskola?

(deftemplate person
    "A specific person"
    (slot firstName (type STRING))
    (slot lastName (type STRING))
    (slot age (type INTEGER))
    (slot giveLoan (type INTEGER) (default 0)))

(defrule economy-is-bad
    "Indicator of bad economy"
    (economy {risingEconomy < 0})
    =>
    (printout t "Economy is bad" crlf))

(defrule economy-is-good
    "Indicator is good economy"
    (economy {risingEconomy > 0})
    =>
    (printout t "Economy is good" crlf))

;;(defrule person-interest-rate
    ;;(if (> person.age > 50)))

(defrule person-age-limit
    "Person is too joung"
    (person {age < 18})
    =>
    (printout t "Person is too joung" crlf))



(run)