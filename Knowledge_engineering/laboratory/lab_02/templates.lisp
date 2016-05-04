(deftemplate automobile
    "A specific car."
    (slot make)
    (slot model)
    (slot year (type INTEGER))
    (slot color (default white)))

(assert (automobile (model Golf) (make VW) (year 1986)))

(facts)

(deftemplate box (slot location) (multislot contens))

(bind ?id (assert(box (location kitchen) (contens spatula sponge frying-pan))))

(facts)

(modify ?id (location dining-room))

(facts)

(deftemplate used-auto extends automobile
    (slot mileage)
    (slot blue-book-value)
    (multislot owners))