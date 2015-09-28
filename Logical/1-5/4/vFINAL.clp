(deftemplate Paciente
 (slot fiebre (type SYMBOL)(allowed-symbols alta moderada baja no nil)(default nil))
 (slot exantema (type SYMBOL)(allowed-symbols si no nil) (default nil))
 (slot sarpullido (type SYMBOL)(allowed-symbols si no nil)(default nil))
 (slot garganta-irritada (type SYMBOL)(allowed-symbols si no nil)(default nil))
 (slot vacunado (type SYMBOL)(allowed-symbols si no nil)(default nil))
 (slot id (type SYMBOL))
 (slot diagnostico (type SYMBOL))
 (slot temperatura)
)


(defrule LTemperatura
(initial-fact)
?p <- (Paciente (temperatura nil))
 =>
(printout t "Entra la temperatura del paciente: ")
(bind ?t (read))
(modify ?p (temperatura ?t)))



(defrule noFiebre
?p <- (Paciente (fiebre nil) (temperatura ?t))
  (test (numberp ?t))
  (test (< ?t 36.7))
=>
(modify ?p (fiebre no)))

(defrule bajaFiebre
?p <- (Paciente (fiebre nil) (temperatura ?t))
  (test (numberp ?t))
  (test (and (<= ?t 37.6) (> ?t 36.7)))
=>
(modify ?p (fiebre baja)))
 
(defrule moderadaFiebre
?p <- (Paciente (fiebre nil) (temperatura ?t))
  (test (numberp ?t))
  (test (and (<= ?t 39) (> ?t 37.6)))
=>
(modify ?p (fiebre moderada)))

(defrule altaFiebre
?p <- (Paciente (fiebre nil) (temperatura ?t))
  (test (numberp ?t))
  (test (> ?t 39))
 => 
(modify ?p (fiebre alta)))


(defrule LExantema
(initial-fact)
?p <- (Paciente (exantema nil))
 =>
(printout t "Tiene exantema el paciente: ")
(bind ?t (read))
(modify ?p (exantema ?t)))


(defrule LGarganta-irritada
(initial-fact)
?p <- (Paciente (garganta-irritada nil))
 =>
(printout t "Tiene la garganta-irritada el paciente: ")
(bind ?t (read))
(modify ?p (garganta-irritada ?t)))

(defrule LSarpullido
?p <- (Paciente (sarpullido nil) (exantema no) (temperatura ?t) (garganta-irritada no))
(test (numberp ?t))
(test (< ?t 36.7))
 =>
(printout t "Tiene sarpullido el paciente: ")
(bind ?t (read))
(modify ?p (sarpullido ?t)))


(defrule LVacunado
?p <- (Paciente (exantema si) (vacunado nil))
 =>
(printout t "Esta vacunado el paciente:")
(bind ?t (read))
(modify ?p (vacunado ?t)))


(defrule Sarampion 
  ?p <- (Paciente (fiebre nil) (exantema si) (vacunado no) (diagnostico nil) (temperatura ?t) (id ?x)) 
  (test (numberp ?t))
  (test (> ?t 39))
 => 
 (modify ?p (diagnostico sarampion)) 
 (printout t "Diagnostico del paciente " ?x ": Sarampion" crlf))
 
 (defrule Alergia1 
 ?p <- (Paciente (exantema si) (id ?x) (temperatura ?t) (diagnostico nil)) 
 (test (numberp ?t))
 (test (< ?t 39))
 => 
 (modify ?p (diagnostico alergia)) 
 (printout t "Diagnostico del paciente " ?x ": Alergia1" crlf))
 
 (defrule Alergia2 
 ?p <- (Paciente (vacunado si) (exantema si) (id ?x) (diagnostico nil) ) 
 => 
 (modify ?p (diagnostico alergia)) 
 (printout t "Diagnostico del paciente " ?x ": Alergia2" crlf))
 
 
 (defrule Alergia3 
 ?p <- (Paciente (sarpullido si) (exantema no) (garganta-irritada no) (temperatura ?t) (id ?x) (diagnostico nil)) 
  (test (numberp ?t))
  (test (< ?t 36.7))
 => 
 (modify ?p (diagnostico alergia)) 
 (printout t "Diagnostico del paciente " ?x ": Alergia3" crlf))
 
 (defrule Gripe 
 ?p <- (Paciente (garganta-irritada si) (id ?x) (temperatura ?t) (diagnostico nil)) 
  (test (numberp ?t))
  (test (and (<= ?t 39) (> ?t 37.6)))
 => 
 (modify ?p (diagnostico gripe)) 
 (printout t "Diagnostico del paciente " ?x ": Gripe" crlf))
 
 
  (defrule diagDescon
 ?p <- (Paciente (sarpullido no) (id ?x) (diagnostico nil)) 
 => 
 (modify ?p (diagnostico desconocido)) 
 (printout t "Diagnostico del paciente " ?x ": Desconocido" crlf))
 
 (defrule diagDescon2
 ?p <- (Paciente (exantema no) (garganta-irritada no) (temperatura ?t) (id ?x) (diagnostico nil)) 
 (test (numberp ?t))
 (test (< ?t 39))
 => 
 (modify ?p (diagnostico desconocido)) 
 (printout t "Diagnostico del paciente " ?x ": Desconocido" crlf))
 
 
 
 
 
 
 
 (defrule Cura-Sarampion
 (diagnostico ?x sarampion)
 =>
 (assert (tratamiento ?x reposo-ayuda))
 (printout t "Tratamiento del paciente " ?x ": Descanso y ayuda" crlf))
 
  (defrule Cura-Alergia
 (diagnostico ?x alergia)
 =>
 (assert (tratamiento ?x antihistaminicos))
 (printout t "Tratamiento del paciente " ?x ": Antihistaminicos" crlf))
 
 
   (defrule Cura-Gripe
 (diagnostico ?x gripe)
 =>
 (assert (tratamiento ?x reposo-cama))
 (printout t "Tratamiento del paciente " ?x ": Reposo y cama" crlf))

 
(deffacts BHinicial
 (Paciente (id P1) (temperatura 35) (exantema si) (garganta-irritada si) (vacunado no))
(Paciente (id P2) (temperatura 35) (exantema si) (garganta-irritada no) (vacunado no))
(Paciente (id P3) (temperatura 35) (exantema si) (garganta-irritada si) (vacunado si))
(Paciente (id P4) (temperatura 35) (exantema si) (garganta-irritada no) (vacunado no))
(Paciente (id P5) (temperatura 35) (exantema no) (garganta-irritada si))
(Paciente (id P6) (temperatura 35) (exantema no) (garganta-irritada no) (sarpullido si))
(Paciente (id P7) (temperatura 35) (exantema no) (garganta-irritada no) (sarpullido no))

(Paciente (id P8) (temperatura 37) (exantema si) (garganta-irritada si) (vacunado no))
(Paciente (id P9) (temperatura 37) (exantema si) (garganta-irritada no) (vacunado no))
(Paciente (id P10) (temperatura 37) (exantema si) (garganta-irritada si) (vacunado si))
(Paciente (id P11) (temperatura 37) (exantema si) (garganta-irritada no) (vacunado no))
(Paciente (id P12) (temperatura 37) (exantema no) (garganta-irritada si))
(Paciente (id P12) (temperatura 37) (exantema no) (garganta-irritada no))

(Paciente (id P13) (temperatura 38) (exantema si) (garganta-irritada si) (vacunado no))
(Paciente (id P14) (temperatura 38) (exantema si) (garganta-irritada no) (vacunado no))
(Paciente (id P15) (temperatura 38) (exantema si) (garganta-irritada si) (vacunado si))
(Paciente (id P16) (temperatura 38) (exantema si) (garganta-irritada no) (vacunado no))
(Paciente (id P17) (temperatura 38) (exantema no) (garganta-irritada si))
(Paciente (id P18) (temperatura 38) (exantema no) (garganta-irritada no))

(Paciente (id P19) (temperatura 40) (exantema si) (garganta-irritada si) (vacunado no))
(Paciente (id P20) (temperatura 40) (exantema si) (garganta-irritada no) (vacunado no))
(Paciente (id P21) (temperatura 40) (exantema si) (garganta-irritada si) (vacunado si))
(Paciente (id P22) (temperatura 40) (exantema si) (garganta-irritada no) (vacunado no))
(Paciente (id P23) (temperatura 40) (exantema no) (garganta-irritada si))
(Paciente (id P24) (temperatura 40) (exantema no) (garganta-irritada no)) 
)

