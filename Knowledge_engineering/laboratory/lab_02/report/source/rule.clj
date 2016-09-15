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