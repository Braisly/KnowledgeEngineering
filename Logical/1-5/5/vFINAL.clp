(deftemplate estado
	  (slot j6
            (type INTEGER)
            (default 0))
      (slot j8
            (type INTEGER)
            (default 0))
      (slot padre)
      (slot nodo
            (type INTEGER)
            (default 0))
      (slot nivel
            (type INTEGER))
      (slot s-accion
            (type STRING))
)

(defrule inicial
(initial-fact)
=>
(assert (estado (j6 0) (j8 0) (padre sin-padre) (nivel 1) (s-accion "[0:0]")))
(assert (nodoactual 1))
)


(defrule llena-jarra-6
(estado (j6 ?c6)(j8 ?c8) (nodo ?nodo) (nivel ?nivel))
(not (estado (j6 6) (j8 ?c8)))
(not (estado (j6 ?j6) (j8 4)))
?n <-(nodoactual ?na)
(test (< ?c6 6))
=>
(assert (estado (j6 6) (j8 ?c8) (padre ?nodo) (nodo (+ ?na 1))(nivel (+ ?nivel 1)) (s-accion "[Llena j6]")))
(retract ?n)
(assert (nodoactual (+ ?na 1)))
)


(defrule llena-jarra-8
(estado (j6 ?c6)(j8 ?c8) (nodo ?nodo) (nivel ?nivel))
(not (estado (j8 8) (j6 ?c6)))
(not (estado (j6 ?j6) (j8 4)))
?n <-(nodoactual ?na)
(test (< ?c8 8))
=>
(assert (estado (j6 ?c6) (j8 8) (padre ?nodo) (nodo (+ ?na 1))(nivel (+ ?nivel 1)) (s-accion "[Llena j8]")))
(retract ?n)
(assert (nodoactual (+ ?na 1)))
)


(defrule llenar-j6-con-j8
(estado (j6 ?c6)(j8 ?c8) (nodo ?nodo)(nivel ?nivel))
(not (estado (j6 =(- ?c6 (- 8 ?c8))) (j8 8)))
(not (estado (j6 ?j6) (j8 4)))
?n <-(nodoactual ?na)
(test (and (< ?c8 8)(> (- ?c6 (- 8 ?c8)) 0)(>= (+ ?c6 ?c8) 8)))
=>
(assert (estado (j6 (- ?c6 (- 8 ?c8))) (j8 8) (padre ?nodo) (nodo (+ ?na 1))(nivel (+ ?nivel 1)) (s-accion "[Llenar: j8->j6]")))
(retract ?n)
(assert (nodoactual (+ ?na 1)))
)


(defrule llenar-j8-con-j6
(estado (j6 ?c6)(j8 ?c8) (nodo ?nodo) (nivel ?nivel))
(not (estado (j6 6) (j8 =(- ?c8 (- 6 ?c6))) ))
(not (estado (j6 ?j6) (j8 4)))
?n <-(nodoactual ?na)
(test (and (< ?c6 6)(> (- ?c8 (- 6 ?c6)) 0)(>= (+ ?c6 ?c8) 6)))
=>
(assert ( estado (j6 6) (j8 (- ?c8 (- 6 ?c6))) (padre ?nodo) (nodo (+ ?na 1))(nivel (+ ?nivel 1)) (s-accion "[Llenar: j6->j8]")))
(retract ?n)
(assert (nodoactual (+ ?na 1)))
)


(defrule vaciar-j6
(estado (j6 ?c6)(j8 ?c8) (nodo ?nodo)(nivel ?nivel))
(not (estado (j6 0) (j8 ?c8)))
(not (estado (j6 ?j6) (j8 4)))
?n <-(nodoactual ?na)
(test (> ?c6 0))
=>
(assert (estado (j6 0) (j8 ?c8) (padre ?nodo) (nodo (+ ?na 1))(nivel (+ ?nivel 1)) (s-accion "[Vaciar j6]")))
(retract ?n)
(assert (nodoactual (+ ?na 1)))
)


(defrule vaciar-j8
(estado (j6 ?c6)(j8 ?c8) (nodo ?nodo)(nivel ?nivel))
(not (estado (j6 ?c6) (j8 0)))
(not (estado (j6 ?j6) (j8 4)))
?n <-(nodoactual ?na)
(test (> ?c8 0))
=>
(assert (estado (j6 ?c6) (j8 0) (padre ?nodo) (nodo (+ ?na 1))(nivel (+ ?nivel 1)) (s-accion "[Vaciar j8]")))
(retract ?n)
(assert (nodoactual (+ ?na 1)))
)

(defrule vaciar-j6-en-j8
(estado (j6 ?c6)(j8 ?c8) (nodo ?nodo) (nivel ?nivel))
(not (estado (j6 0) (j8 =(+ ?c6 ?c8))))
(not (estado (j6 ?j6) (j8 4)))
?n <-(nodoactual ?na)
(test (and (> ?c6 0)(<= (+ ?c6 ?c8) 8)))
=>
(assert ( estado (j6 0) (j8 (+ ?c6 ?c8)) (padre ?nodo) (nodo (+ ?na 1))(nivel (+ ?nivel 1)) (s-accion "[Vaciar: j6->j8]")))
(retract ?n)
(assert (nodoactual (+ ?na 1)))
)


(defrule vaciar-j8-en-j6
(estado (j6 ?c6)(j8 ?c8) (nodo ?nodo) (nivel ?nivel))
(not (estado (j6 =(+ ?c6 ?c8)) (j8 0) ))
(not (estado (j6 ?j6) (j8 4)))
?n <-(nodoactual ?na)
(test (and (> ?c8 0)(<= (+ ?c6 ?c8) 6)))
=>
(assert ( estado (j6 (+ ?c6 ?c8)) (j8 0) (padre ?nodo) (nodo (+ ?na 1))(nivel (+ ?nivel 1)) (s-accion "[Vaciar: j8->j6]")))
(retract ?n)
(assert (nodoactual (+ ?na 1)))
)


(defrule meta-alcanzada 
 ?meta <- (estado (j6 ?c6) (j8 4))  
=>  
(printout t "Meta alcanzada: " crlf)  
(assert (obtener-padre ?meta)) 
(assert (camino)) 
)  

(defrule contruye-camino 
      ?e <- (estado (padre ?padre) (s-accion ?accion)) 
      ?r <- (obtener-padre ?e) 
      ?c <- (camino $?caminoactual) 
=> 
      (assert (camino ?accion ?caminoactual)) 
      (assert (obtener-padre ?padre)) 
      (retract ?c) 
      (retract ?r) 
) 

(defrule terminado 
      ?rec <- (obtener-padre sin-padre) 
      ?lista <- (camino $?caminocompleto) 
=> 
      (printout t "Solucion:" ?caminocompleto crlf) 
      (retract ?rec ?lista) 
) 
