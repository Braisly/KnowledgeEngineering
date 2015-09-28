(deffacts tipoAnimalBH
(tiene-pelo robbie) 
(tiene-pezunas robbie) 
(tiene-rayas-negras robbie))

(defrule R1
(tiene-pelo ?x)
=>
 (assert(mamifero ?x)))

(defrule R2
(da-leche ?x)
=>
 (assert(mamifero ?x)))
 
(defrule R3
(mamifero ?x)
(tiene-pezunas ?x)
=>
 (assert(ungulado ?x)))
 
(defrule R4
(mamifero ?x)
(si-rumia ?x)
=>
 (assert(ungulado ?x)))
 
(defrule R5
(ungulado ?x)
(cuello-largo ?x)
=>
 (assert(jirafa ?x)))
 
 (defrule R6
(ungulado ?x)
(tiene-rayas-negras ?x)
=>
 (assert(cebra ?x)))
