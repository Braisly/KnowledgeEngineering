(deftemplate Paciente 
 (slot fiebre (type SYMBOL)(allowed-symbols alta moderada baja no) (default no)) 
 (slot sarpullido (type SYMBOL) (allowed-symbols si no) (default no)) 
 (slot exantema (type SYMBOL) (allowed-symbols si no) (default no)) 
 (slot garganta-irritada (type SYMBOL) (allowed-symbols si no) (default no)) 
 (slot vacunado (type SYMBOL) (allowed-symbols si no)) 
) 

(defrule Sarampion 
 (Paciente (fiebre alta) (exantema si) (vacunado no)) 
 => 
 (assert (diagnostico sarampion)) 
 (printout t "Diagnostico: Sarampion" crlf))
 
 (defrule Alergia1 
 (Paciente (fiebre ~alta) (exantema si)) 
 => 
 (assert (diagnostico alergia)) 
 (printout t "Diagnostico: Alergia" crlf))
 
 (defrule Alergia2 
 (Paciente (vacunado si) (exantema si)) 
 => 
 (assert (diagnostico alergia)) 
 (printout t "Diagnostico: Alergia" crlf))
 
 
 (defrule Alergia3 
 (Paciente (sarpullido si) (exantema no) (fiebre no) (garganta-irritada no)) 
 => 
 (assert (diagnostico alergia)) 
 (printout t "Diagnostico: Alergia" crlf))
 
 (defrule Gripe 
 (Paciente (fiebre alta | moderada) (garganta-irritada si)) 
 => 
 (assert (diagnostico gripe)) 
 (printout t "Diagnostico: Gripe" crlf))
 
 (deffacts BHinicial 
 (Paciente (fiebre baja) (exantema si)))
 
 
 