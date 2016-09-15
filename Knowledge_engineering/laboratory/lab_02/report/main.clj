;; Ekspertine sistema turi turėti:
;; - Nemažiau 20 faktu failą
;; - Nemažiau 15 taisyklių bazę

(defadvice after printout (printout t crlf))

(deftemplate item
    "Item in the fridge"
    (slot name)
    (slot amount))
;; 1
(defrule spicy-carrot
    "Spicy carrot Salad"
    ?item1 <- (item {name == carrot && amount > 2})
    ?item2 <- (item {name == garlic && amount >= 1})
    =>
    (printout t "Spicy carrot Salad"))

;; 2
(defrule tomato-peach
    "Tomato-Peach Salad"
    ?item1 <- (item {name == tomato && amount > 2})
    ?item2 <- (item {name == peach && amount > 1})
    ?item3 <- (item {name == onion && amount > 0})
    =>
    (printout t "Tomato Peach Salad"))

;; 3
(defrule creole-green-beans
    "Creole Green Beans"
    ?item1 <- (item {name == beans && amount > 3})
    ?item2 <- (item {name == onion && amount > 0})
    ?item3 <- (item {name == cheese && amount > 1})
    =>
    (printout t "Creole Green Beans"))

;; 4
(defrule herb-salad
    ?item1 <- (item {name == lemon && amount > 0})
    ?item2 <- (item {name == lettuce && amount > 1})
    =>
    (printout t "Herb Salad"))

;; 5
; Moliugo ir makaronu salotos
(defrule squash-and-orzo-salad
    ?item1 <- (item {name == cheese && amount > 1})
    ?item2 <- (item {name == squash && amount > 0})
    ?item3 <- (item {name == orzon && amount > 0})
    =>
    (printout t "Squash and Orzo Salad"))

;; 6
(defrule champagne-greens
    ?item1 <- (item {name == lettuce && amount > 0})
    =>
    (printout t "Champagne greens"))

;; 7
(defrule watercress-fruit-salat
    ?item1 <- (item {name == peach && amount > 1})
    ?item2 <- (item {name == waterlemon && amount > 1})
    =>
    (printout t "Watercress Fruit Salat"))

;; 8
(defrule caesar-salad
    ?item1 <- (item {name == garlic && amount > 1})
    ?item2 <- (item {name == anchovy && amount > 1})
    ?item3 <- (item {name == egg && amount > 0})
    =>
    (printout t "Caesar Salad"))

;; 9
(defrule hearty-tuna-salad
    ?item1 <- (item {name == bean && amount > 1})
    ?item2 <- (item {name == mushroom && amount > 2})
    ?item3 <- (item {name == olive && amount > 2})
    ?item4 <- (item {name == tomato && amount > 1})
    =>
    (printout t "Hearty Tuna Salad"))

;; 10
(defrule tomatoes-with-mint
    ?item1 <- (item {name == tomato && amount > 1})
    ?item2 <- (item {name == mint && amount > 0})
    =>
    (printout t "Tomatoes with Mint"))

;; 11
(defrule pasta-caprese
    ?item1 <- (item {name == mozzarella && amount > 0})
    ?item2 <- (item {name == tomatoe && amount > 1})
    ?item3 <- (item {name == nut && amount > 1})
    ?item4 <- (item {name == garlic && amount > 0})
    =>
    (printout t "Pasta Caprese"))

;; 12 
(defrule chicken-mango-salad
    ?item1 <- (item {name == honey && amount > 0})
    ?item2 <- (item {name == chicken && amount > 1})
    ?item3 <- (item {name == mango && amount > 1})
    =>
    (printout t "Chicken-Mongo salad"))

;; 13
(defrule oranges-with-mozzarella
    ?item1 <- (item {name == mozzarella && amount > 0})
    ?item2 <- (item {name == orange && amount > 1})
    =>
    (printout t "Oranges with Mozzarella"))

;; 14
(defrule dilled-egg-salad
    ?item1 <- (item {name == egg && amount > 2})
    ?item2 <- (item {name == pickle && amount > 0})
    =>
    (printout t "Dilled Egg Salad"))

;; 15
(defrule cantaloupe-carpaccio
    ?item1 <- (item {name == cantaloupe && amount > 0})
    ?item2 <- (item {name == ricotta && amount > 1})
    =>
    (printout t "Cantaloupe Carpaccio"))

;; 16
(defrule three-bean-salad
    ?item1 <- (item {name == bean && amount > 2})
    ?item2 <- (item {name == onion && amount > 1})
    =>
    (printout t "Three-Bean Salad"))

(assert (item (name lemon) (amount (1)))) ;; 1
(assert (item (name lettuce) (amount 2))) ;; 2
(assert (item (name carrot) (amount 3))) ;; 3
(assert (item (name garlic) (amount 2))) ;; 4
(assert (item (name onion) (amount 2))) ;; 5
(assert (item (name bean) (amount 3))) ;; 6
(assert (item (name ricotta) (amount 0))) ;; 7
(assert (item (name cantaloupe) (amount 0))) ;; 8
(assert (item (name pickle) (amount 0))) ;; 9
(assert (item (name egg) (amount 0))) ;; 10
(assert (item (name orange) (amount 0))) ;; 11
(assert (item (name mozzarella) (amount 0))) ;; 12
(assert (item (name mango) (amount 0))) ;; 13
(assert (item (name chicken) (amount 0))) ;; 14
(assert (item (name honey) (amount 0))) ;; 15
(assert (item (name nut) (amount 0))) ;; 16
(assert (item (name tomatoe) (amount 0))) ;; 17
(assert (item (name mint) (amount 0))) ;; 18
(assert (item (name olive) (amount 0))) ;; 19
(assert (item (name mushroom) (amount 0))) ;; 20

(run)