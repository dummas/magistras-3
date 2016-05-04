(printout t "Hello world" crlf)

(bind ?a 123)

(printout t "a variable is " ?a " !" crlf)

(bind ?i 3)

(while (> ?i 0)
    (printout t ?i crlf)
    (-- ?i))

(bind ?x 60)

(if (> ?x 100) then
        (printout t "X is big" crlf)
    elif (> ?x 50) then
        (printout t "X is medium" crlf)
    else
        (printout t "X is small" crlf))

(deffunction max (?a ?b)
    (if (> ?a ?b) then
        ?a
    else
        ?b))

(printout t "The greater of 3 and 5 is " (max 3 5) "." crlf)

(defadvice before +  (bind $?argv (create$ $?argv 1)))

(printout t "The sum of 2 and 2 is " (+ 2 2) "." crlf)

(defadvice before + (return 1))

(printout t "The sum of 2 and 2 is " (+ 2 2) "." crlf)

(undefadvice +)

(printout t "The sum is correct now " (+ 2 2) "." crlf)