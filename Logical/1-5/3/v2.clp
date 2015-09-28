(deftemplate Paciente 
 (slot fiebre (type SYMBOL)(allowed-symbols alta moderada baja no) (default no)) 
 (slot sarpullido (type SYMBOL) (allowed-symbols si no) (default no)) 
 (slot exantema (type SYMBOL) (allowed-symbols si no) (default no)) 
 (slot garganta-irritada (type SYMBOL) (allowed-symbols si no) (default no)) 
 (slot vacunado (type SYMBOL) (allowed-symbols si no)) 
 (slot id (type SYMBOL))
) 

(defrule Sarampion 
 (Paciente (fiebre alta) (exantema si) (vacunado no) (id ?x)) 
 => 
 (assert (diagnostico ?x sarampion)) 
 (printout t "Diagnostico del paciente " ?x ": Sarampion" crlf))
 
 (defrule Alergia1 
 (Paciente (fiebre ~alta) (exantema si) (id ?x)) 
 => 
 (assert (diagnostico id ?x alergia)) 
 (printout t "Diagnostico del paciente " ?x ": Alergia" crlf))
 
 (defrule Alergia2 
 (Paciente (vacunado si) (exantema si) (id ?x)) 
 => 
 (assert (diagnostico ?x alergia)) 
 (printout t "Diagnostico del paciente " ?x ": Alergia" crlf))
 
 
 (defrule Alergia3 
 (Paciente (sarpullido si) (exantema no) (fiebre no) (garganta-irritada no) (id ?x)) 
 => 
 (assert (diagnostico ?x alergia)) 
 (printout t "Diagnostico del paciente " ?x ": Alergia" crlf))
 
 (defrule Gripe 
 (Paciente (fiebre alta | moderada) (garganta-irritada si) (id ?x)) 
 => 
 (assert (diagnostico ?x gripe)) 
 (printout t "Diagnostico del paciente " ?x ": Gripe" crlf))
 
(deffacts BHinicial 
 (Paciente (fiebre baja) (exantema si) (id P1)) 
 (Paciente (fiebre alta) (exantema si) (id P2)) 
 (Paciente (fiebre moderada) (garganta-irritada si) (id P3)) 
 (Paciente (fiebre baja) (sarpullido si) (id P4)))

