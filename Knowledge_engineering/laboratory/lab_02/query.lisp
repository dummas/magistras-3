(deftemplate person (slot firstName) (slot lastName) (slot age))

(defquery search-by-name
    "Finds people with a given last name"
    (declare (variables ?ln))
    (person (lastName ?ln) (firstName ?fn) (age ?age)))

(deffacts data
  (person (firstName Fred)   (lastName Smith)    (age 12))
  (person (firstName Fred)   (lastName Jones)    (age 9))
  (person (firstName Bob)    (lastName Thomas)   (age 32))
  (person (firstName Bob)    (lastName Smith)    (age 22))
  (person (firstName Pete)   (lastName Best)     (age 21))
  (person (firstName Pete)   (lastName Smith)    (age 44))
  (person (firstName George) (lastName Smithson) (age 1)))

(reset)

(bind ?result (run-query* search-by-name Smith))

(while (?result next)
    (printout t (?result getString fn) " " (?result getString ln) ", age " (?result getInt age) crlf))

(run)
