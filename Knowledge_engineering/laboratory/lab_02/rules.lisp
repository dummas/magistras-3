(deftemplate person 
    (slot firstName) 
    (slot lastName) 
    (slot age))

(defrule welcome-toddlers
    "Give a special gretting to your children"
    (person {age < 3})
    =>
    (printout t "Hello, little one!" crlf))

(defrule teenager
    ?p <- (person {age > 12 && age < 20} (firstName ?name))
    =>
    (printout t ?name " is " ?p.age " years old." crlf))

(watch all)

(assert (person (age 2)))

(assert (person (firstName "John") (age 15)))

(run)