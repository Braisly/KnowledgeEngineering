(deftemplate Paciente 
 (slot fiebre (type SYMBOL)(allowed-symbols alta moderada baja no nil)(default nil))
 (slot temperatura)
 (slot sarpullido (type SYMBOL) (allowed-symbols si no) (default no)) 
 (slot exantema (type SYMBOL) (allowed-symbols si no) (default no)) 
 (slot garganta-irritada (type SYMBOL) (allowed-symbols si no) (default no)) 
 (slot vacunado (type SYMBOL) (allowed-symbols si no)) 
 (slot id (type SYMBOL))
 (slot diagnostico (type SYMBOL))
) 




(defrule Sarampion 
  ?p <- (Paciente (fiebre alta) (exantema si) (vacunado no) (diagnostico nil) (id ?x)) 
 => 
 (modify ?p (diagnostico sarampion)) 
 (printout t "Diagnostico del paciente " ?x ": Sarampion" crlf))
 
 (defrule Alergia1 
 ?p <- (Paciente (fiebre ~alta)  (exantema si) (id ?x)  (diagnostico nil)) 
 => 
 (modify ?p (diagnostico alergia)) 
 (printout t "Diagnostico del paciente " ?x ": Alergia" crlf))
 
 (defrule Alergia2 
 ?p <- (Paciente (vacunado si) (exantema si) (id ?x) (diagnostico nil)) 
 => 
 (modify ?p (diagnostico alergia)) 
 (printout t "Diagnostico del paciente " ?x ": Alergia" crlf))
 
 
 (defrule Alergia3 
 ?p <- (Paciente (sarpullido si) (exantema no) (fiebre no) (garganta-irritada no) (id ?x) (diagnostico nil)) 
 => 
 (modify ?p (diagnostico alergia)) 
 (printout t "Diagnostico del paciente " ?x ": Alergia" crlf))
 
 (defrule Gripe 
 ?p <- (Paciente (fiebre alta | moderada) (garganta-irritada si) (id ?x) (diagnostico nil)) 
 => 
 (modify ?p (diagnostico gripe)) 
 (printout t "Diagnostico del paciente " ?x ": Gripe" crlf))
 
 
 
 
 
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
 (Paciente (fiebre baja) (exantema si) (id P1))
 (Paciente (fiebre alta) (exantema si) (id P2))
 (Paciente (fiebre moderada) (garganta-irritada si) (id P3))
 (Paciente (fiebre baja) (sarpullido si) (id P4)))