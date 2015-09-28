(deftemplate Persoa
(slot nome)
(slot apelidos)
(slot edad)
(slot sexo)
(slot peso)
(slot actividad-fisica)
(slot gastoBasal (default nil))
(slot gastoEnerxia (default nil))
(slot gastoTotal (default nil))
(slot dieta (default nil))
)


(deftemplate Alimento
(slot nome)
(slot grupo)
(slot carbohidratos);4kcal
(slot proteinas);4kcal
(slot grasas);9kcal
(slot calorias)
(slot usos)
)


;PARA SACAR OS PORCENTAJES (Gramos acumulados)
(deftemplate Acumulado
(slot carbohidratos)
(slot proteinas)
(slot grasas)
)

;************************************************************
;			GASTO BASAL
;************************************************************	

;MULLERES
;-----------------
(defrule Mulleres1
?persona<-(Persoa (edad ?e) (sexo feminino) (peso ?p) (gastoBasal nil))
(test (>= ?e 0))
(test (< ?e 3))	
=>	
(modify ?persona (gastoBasal (- (* 61 ?p) 51)))
)


(defrule Mulleres2
?persona<-(Persoa (edad ?e) (sexo feminino) (peso ?p) (gastoBasal nil))
(test (>= ?e 3))
(test (< ?e 10))	
=>	
(modify ?persona (gastoBasal (+ (* 22.5 ?p) 499)))
)


(defrule Mulleres3
?persona<-(Persoa (edad ?e) (sexo feminino) (peso ?p) (gastoBasal nil))
(test (>= ?e 10))
(test (< ?e 18))	
=>	
(modify ?persona (gastoBasal (+ (* 12.2 ?p) 746)))
)

(defrule Mulleres4
?persona<-(Persoa (edad ?e) (sexo feminino) (peso ?p) (gastoBasal nil))
(test (>= ?e 18))
(test (< ?e 30))	
=>	
(modify ?persona (gastoBasal (+ (* 14.7 ?p) 496)))
)

(defrule Mulleres5
?persona<-(Persoa (edad ?e) (sexo feminino) (peso ?p) (gastoBasal nil))
(test (>= ?e 30))
(test (< ?e 60))	
=>	
(modify ?persona (gastoBasal (+ (* 8.7 ?p) 829)))
)


(defrule Mulleres6

?persona<-(Persoa (edad ?e) (sexo feminino) (peso ?p) (gastoBasal nil))
(test (>= ?e 60))	
=>	
(modify ?persona (gastoBasal (+ (* 10.5 ?p) 596))))



;HOMES
;--------------------
(defrule Homes1
?persona<-(Persoa (edad ?e) (sexo masculino) (peso ?p) (gastoBasal nil))
(test (>= ?e 0))
(test (< ?e 3))	
=>
(modify ?persona (gastoBasal (- (* 60.9 ?p) 54)))
)


(defrule Homes2
?persona<-(Persoa (edad ?e) (sexo masculino) (peso ?p) (gastoBasal nil))
(test (>= ?e 3))
(test (< ?e 10))	
=>	
(modify ?persona (gastoBasal (+ (* 22.7 ?p) 495)))
)


(defrule Homes3
?persona<-(Persoa (edad ?e) (sexo masculino) (peso ?p) (gastoBasal nil))
(test (>= ?e 10))
(test (< ?e 18))	
=>	
(modify ?persona (gastoBasal (+ (* 17.5 ?p) 651)))
)

(defrule Homes4
?persona<-(Persoa (edad ?e) (sexo masculino) (peso ?p) (gastoBasal nil))
(test (>= ?e 18))
(test (< ?e 30))	
=>	
(modify ?persona (gastoBasal (+ (* 15.3 ?p) 679)))
)

(defrule Homes5
?persona<-(Persoa (edad ?e) (sexo masculino) (peso ?p) (gastoBasal nil))
(test (>= ?e 30))
(test (< ?e 60))	
=>	
(modify ?persona (gastoBasal (+ (* 11.6 ?p) 879)))
)


(defrule Homes6
?persona<-(Persoa (edad ?e) (sexo masculino) (peso ?p) (gastoBasal nil))
(test (>= ?e 60))	
=>	
(modify ?persona (gastoBasal (+ (* 13.5 ?p) 486)))
)




;************************************************************
;			GASTO ACTIVIDIDAD
;************************************************************


(defrule Repouso
?p<-(Persoa (actividad-fisica repouso) (gastoEnerxia nil))
=>
(modify ?p (gastoEnerxia 0))
)


(defrule Lixeira
?p<-(Persoa (actividad-fisica ligera) (gastoEnerxia nil))
=>
(modify ?p (gastoEnerxia 200))
)

(defrule Moderada
?p<-(Persoa (actividad-fisica moderada) (gastoEnerxia nil))
=>
(modify ?p (gastoEnerxia 400))
)

(defrule Intensa
?p<-(Persoa (actividad-fisica intensa) (gastoEnerxia nil))
=>
(modify ?p (gastoEnerxia 1000))
)



;************************************************************
;			GASTO TOTAL
;************************************************************

(defrule gastoTotal
?p<-(Persoa (gastoBasal ?gb) (gastoEnerxia ?ge) (gastoTotal nil))
;(Persoa (gastoBasal ~nil) (gastoEnerxia ~nil))
(test (numberp ?gb))
(test (numberp ?ge))

=>
(modify ?p (gastoTotal (+ ?gb ?ge))))




(defrule datosIniciais
(initial-fact)
=>
;LACTEOS 1
;-----------------------------------------------
(assert(Alimento (nome leche-de-cabra) (grupo 1) (carbohidratos 4.2) (proteinas 3.7) (grasas 3.92) (calorias 66.7)(usos 2)))
(assert(Alimento (nome leche-entera) (grupo 1) (carbohidratos 4.7) (proteinas 3.06) (grasas 3.8) (calorias 65.4)(usos 2)))
(assert(Alimento (nome batido-de-cacao) (grupo 1) (carbohidratos 9.8) (proteinas 2.7) (grasas 3.6) (calorias 84)(usos 2)))
(assert(Alimento (nome yogur-griego) (grupo 1) (carbohidratos 5.39) (proteinas 6.4) (grasas 10.2) (calorias 139)(usos 2)))
(assert(Alimento (nome queso-tetilla) (grupo 1) (carbohidratos 1) (proteinas 22) (grasas 34.5) (calorias 399)(usos 2)))
(assert(Alimento (nome queso-burgos) (grupo 1) (carbohidratos 2.5) (proteinas 14.04) (grasas 14.9) (calorias 200.1)(usos 2)))
(assert(Alimento (nome yogur-entero-natural) (grupo 1) (carbohidratos 5.5) (proteinas 3.96) (grasas 2.6) (calorias 61.4) (usos 1)))
(assert(Alimento (nome queso-gallego) (grupo 1) (carbohidratos 2) (proteinas 23) (grasas 28) (calorias 352)(usos 2)))
(assert(Alimento (nome leche-desnatada) (grupo 1) (carbohidratos 4.9) (proteinas 3.89) (grasas 0.2) (calorias 37)(usos 2)))
(assert(Alimento (nome arroz-con-leche) (grupo 1) (carbohidratos 16.4) (proteinas 3.3) (grasas 1.3) (calorias 90.7) (usos 1)))


;CARNE OVOS E PEIXE 2
;-----------------------------------------------
(assert(Alimento (nome atun-aceite-conserva) (grupo 2) (carbohidratos 0) (proteinas 24.8) (grasas 12.1) (calorias 208)(usos 2)))
(assert(Alimento (nome mejillon) (grupo 2) (carbohidratos 3.4) (proteinas 10.18) (grasas 1.96) (calorias 72)(usos 2)))
(assert(Alimento (nome huevo-gallina) (grupo 2) (carbohidratos 0.68) (proteinas 12.68) (grasas 12.1) (calorias 162)(usos 2)))
(assert(Alimento (nome ternera-magra) (grupo 2) (carbohidratos 1) (proteinas 20.7) (grasas 5.4) (calorias 131)(usos 2)))
(assert(Alimento (nome caballa) (grupo 2) (carbohidratos 0) (proteinas 18.68) (grasas 11.9) (calorias 182)(usos 2)))
(assert(Alimento (nome berberecho-conserva) (grupo 2) (carbohidratos 1.5) (proteinas 17.43) (grasas 0.4) (calorias 79.3)(usos 2)))
(assert(Alimento (nome jamon-serrano) (grupo 2) (carbohidratos 0) (proteinas 21.37) (grasas 5.6) (calorias 136)(usos 2)))
(assert(Alimento (nome langostino-cocido) (grupo 2) (carbohidratos 1.5) (proteinas 24.3) (grasas 0.8) (calorias 110)(usos 2)))
(assert(Alimento (nome pechuga-pavo) (grupo 2) (carbohidratos 1) (proteinas 24.12) (grasas 0.99) (calorias 105)(usos 2)))
(assert(Alimento (nome cerdo-magro) (grupo 2) (carbohidratos 1) (proteinas 22) (grasas 7.6) (calorias 156)(usos 2)))

;PATACAS, LEGUMES E FROITOS SECOS 3
;-----------------------------------------------
(assert(Alimento (nome anacardo) (grupo 3) (carbohidratos 30.5) (proteinas 17.5) (grasas 42.2) (calorias 577.6)(usos 2)))
(assert(Alimento (nome castanha) (grupo 3) (carbohidratos 36.5) (proteinas 2.65) (grasas 2.2) (calorias 190)(usos 2)))
(assert(Alimento (nome uva-pasa) (grupo 3) (carbohidratos 72) (proteinas 1.9) (grasas 0.6) (calorias 301)(usos 2)))
(assert(Alimento (nome nuez-sin-cascara) (grupo 3) (carbohidratos 4.4) (proteinas 14.42) (grasas 62.5) (calorias 649)(usos 2)))
(assert(Alimento (nome tofu) (grupo 3) (carbohidratos 3.3) (proteinas 8.08) (grasas 4.78) (calorias 89.1)(usos 2)))
(assert(Alimento (nome lenteja) (grupo 3) (carbohidratos 40.6) (proteinas 23.18) (grasas 1.7) (calorias 304)(usos 2)))
(assert(Alimento (nome garbanzo-conserva) (grupo 3) (carbohidratos 14.12) (proteinas 7.2) (grasas 2.9) (calorias 120)(usos 2)))
(assert(Alimento (nome almendra-sin-cascara) (grupo 3) (carbohidratos 5.36) (proteinas 18.71) (grasas 54.1) (calorias 610)(usos 2)))
(assert(Alimento (nome patatas) (grupo 3) (carbohidratos 14.8) (proteinas 2.34) (grasas 0.11) (calorias 73.59)(usos 2)))
(assert(Alimento (nome crema-cacahuete) (grupo 3) (carbohidratos 11.2) (proteinas 30.09) (grasas 47.8) (calorias 609)(usos 2)))

;VERDURAS E HORTALIZAS 4
;-----------------------------------------------
(assert(Alimento (nome alcachofa) (grupo 4) (carbohidratos 2.9) (proteinas 2.37) (grasas 0.12) (calorias 43.88)(usos 2)))
(assert(Alimento (nome berro) (grupo 4) (carbohidratos 2.03) (proteinas 1.6) (grasas 0.3) (calorias 20.2)(usos 2)))
(assert(Alimento (nome apio) (grupo 4) (carbohidratos 2.47) (proteinas 1.19) (grasas 0.2) (calorias 19.2)(usos 2)))
(assert(Alimento (nome brecol) (grupo 4) (carbohidratos 2.66) (proteinas 3.56) (grasas 0.2) (calorias 33)(usos 2)))
(assert(Alimento (nome calabacin) (grupo 4) (carbohidratos 2) (proteinas 1.88) (grasas 0.5) (calorias 23.2)(usos 2)))
(assert(Alimento (nome coliflor) (grupo 4) (carbohidratos 2.39) (proteinas 2.44) (grasas 0.28) (calorias 27.52)(usos 2)))
(assert(Alimento (nome espinaca) (grupo 4) (carbohidratos 0.61) (proteinas 2.63) (grasas 0.3) (calorias 20.74)(usos 2)))
(assert(Alimento (nome lechuga) (grupo 4) (carbohidratos 1.4) (proteinas 1.37) (grasas 0.6) (calorias 19.6)(usos 2)))
(assert(Alimento (nome grelo) (grupo 4) (carbohidratos 0.1) (proteinas 2.7) (grasas 0.2) (calorias 20.8)(usos 2)))
(assert(Alimento (nome pimiento-rojo) (grupo 4) (carbohidratos 4.2) (proteinas 1.25) (grasas 0.9) (calorias 32.9)(usos 2)))

;FROITAS 5
;-----------------------------------------------
(assert(Alimento (nome uva-blanca) (grupo 5) (carbohidratos 16.1) (proteinas 0.72) (grasas 0.16) (calorias 70.3)(usos 2)))
(assert(Alimento (nome cereza) (grupo 5) (carbohidratos 13.3) (proteinas 0.88) (grasas 0.31) (calorias 62.11)(usos 2)))
(assert(Alimento (nome platano) (grupo 5) (carbohidratos 20.8) (proteinas 1.06) (grasas 0.27) (calorias 95.03)(usos 2)))
(assert(Alimento (nome mandarina) (grupo 5) (carbohidratos 9.2) (proteinas 0.63) (grasas 0.2) (calorias 44.7)(usos 2)))
(assert(Alimento (nome manzana) (grupo 5) (carbohidratos 11.4) (proteinas 0.31) (grasas 0.36) (calorias 54.08)(usos 2)))
(assert(Alimento (nome kiwi) (grupo 5) (carbohidratos 9.12) (proteinas 1) (grasas 0.8) (calorias 51.8)(usos 2)))
(assert(Alimento (nome melocoton) (grupo 5) (carbohidratos 10.3) (proteinas 1) (grasas 0.2) (calorias 50.8)(usos 2)))
(assert(Alimento (nome pinha) (grupo 5) (carbohidratos 20.4) (proteinas 0.44) (grasas 0.4) (calorias 50.76)(usos 2)))
(assert(Alimento (nome sandia) (grupo 5) (carbohidratos 5.6) (proteinas 0.63) (grasas 0.3) (calorias 28.4)(usos 2)))
(assert(Alimento (nome pera) (grupo 5) (carbohidratos 10.6) (proteinas 0.43) (grasas 0.1) (calorias 49.42)(usos 2)))



;PAN,PASTA, CEREAIS, AZUCRE E DOCES grupo-6
;-----------------------------------------------
(assert(Alimento (nome arroz-integral) (grupo 6) (carbohidratos 74.21) (proteinas 7.25) (grasas 2.2) (calorias 350)(usos 2)))
(assert(Alimento (nome avena) (grupo 6) (carbohidratos 55.7) (proteinas 11.72) (grasas 7.09) (calorias 353)(usos 2)))
(assert(Alimento (nome galleta-integral) (grupo 6) (carbohidratos 42.9) (proteinas 10) (grasas 21.2) (calorias 427)(usos 2)))
(assert(Alimento (nome pan-integral) (grupo 6) (carbohidratos 38) (proteinas 7.02) (grasas 2.9) (calorias 221)(usos 2)))
(assert(Alimento (nome pan-integral-tostado) (grupo 6) (carbohidratos 44.5) (proteinas 10.8) (grasas 2.9) (calorias 265)(usos 2)))
(assert(Alimento (nome chocolate-puro) (grupo 6) (carbohidratos 47) (proteinas 5.3) (grasas 30) (calorias 509)(usos 2)))
(assert(Alimento (nome croisant) (grupo 6) (carbohidratos 52.6) (proteinas 6.96) (grasas 22.4) (calorias 444)(usos 2)))
(assert(Alimento (nome pasta) (grupo 6) (carbohidratos 70.9) (proteinas 12.78) (grasas 1.58) (calorias 359)(usos 2)))
(assert(Alimento (nome palmera) (grupo 6) (carbohidratos 61) (proteinas 5) (grasas 30) (calorias 539)(usos 2)))
(assert(Alimento (nome muesli) (grupo 6) (carbohidratos 61) (proteinas 9) (grasas 11) (calorias 395)(usos 2)))


;GRAXAS, ACEITE E MANTEQUILLA grupo-7
;-----------------------------------------------
(assert(Alimento (nome aceite-cacahuete) (grupo 7) (carbohidratos 0) (proteinas 0) (grasas 100) (calorias 900)(usos 2)))
(assert(Alimento (nome aceite-oliva) (grupo 7) (carbohidratos 0) (proteinas 0) (grasas 99.9) (calorias 899)(usos 2)))
(assert(Alimento (nome aceite-oliva-virgen) (grupo 7) (carbohidratos 0) (proteinas 0) (grasas 99.9) (calorias 899)(usos 2)))
(assert(Alimento (nome aceite-girasol) (grupo 7) (carbohidratos 0) (proteinas 0) (grasas 99.9) (calorias 899)(usos 2)))
(assert(Alimento (nome mantequilla) (grupo 7) (carbohidratos 0) (proteinas 0) (grasas 99.5) (calorias 897)(usos 2)))
(assert(Alimento (nome margarina) (grupo 7) (carbohidratos 0.4) (proteinas 0.2) (grasas 80) (calorias 722)(usos 2)))
(assert(Alimento (nome aceite-coco) (grupo 7) (carbohidratos 0) (proteinas 0) (grasas 100) (calorias 900)(usos 2)))
(assert(Alimento (nome margarina-salada) (grupo 7) (carbohidratos 0.9) (proteinas 0.9) (grasas 80.5) (calorias 732)(usos 2)))
(assert(Alimento (nome margarina-ligera) (grupo 7) (carbohidratos 0.4) (proteinas 1.62) (grasas 40) (calorias 368)(usos 2)))
(assert(Alimento (nome aceite-palma) (grupo 7) (carbohidratos 0) (proteinas 0) (grasas 99.9) (calorias 899)(usos 2)))


;VARIABLES de inicio da configuracion
;Acumulado do total, usado para contabilizar os gramos de carbohidratos, proteinas e grasas 
(assert (Acumulado (carbohidratos 0) (proteinas 0) (grasas 0)))
;Indicación do comezo da semana (LUNS)
(assert (dia 1))
;Alimento=0, que os alimentos non foron usados
(assert (alimento 0))
)


;************************************************************
;			CONFIGURACIÓN
;************************************************************


;Configuración das calorias de cada comida
;------------------------------------------
(defrule caloriasComidasInicio
?a1<-(Almorzo ?almorzo)
?a2<-(Media ?media)
?a3<-(Xantar ?xantar)
?a4<-(Merenda ?merenda)
?a5<-(Cea ?cea)
=>
(assert (macroAlmorzo (* 0.55 ?almorzo) (* 0.15 ?almorzo) (* 0.30 ?almorzo) ))
(assert (macroMedia (* 0.55 ?media) (* 0.15 ?media) (* 0.30 ?media)))
(assert (macroXantar (* 0.55 ?xantar) (* 0.15 ?xantar) (* 0.30 ?xantar)))
(assert (macroMerenda (* 0.55 ?merenda) (* 0.15 ?merenda) (* 0.30 ?merenda)))
(assert (macroCea (* 0.55 ?cea) (* 0.15 ?cea) (* 0.30 ?cea)))
(retract ?a1)
(retract ?a2)
(retract ?a3)
(retract ?a4)
(retract ?a5)
)


;Configuracion do LUNS, e xa vai ao almorzo
;---------------------------------------------
(defrule LUNS
?p<-(Persoa (gastoTotal ?gT) (dieta nil))
(test (numberp ?gT))
?d<-(dia ?dia)
(test (= ?dia 1))
=>
(printout t crlf "Dieta semanal de "?gT" Kcal" crlf)
(printout t "LUNS " crlf)
(assert (Almorzo (* 0.25 ?gT)))
(assert (Media (* 0.15 ?gT)))
(assert (Xantar (* 0.25 ?gT)))
(assert (Merenda (* 0.15 ?gT)))
(assert (Cea (* 0.2 ?gT)))
(assert (tipoComida 0))
(retract ?d)
(assert (dia 2))
)


;Configuracion do MARTES, e xa vai ao almorzo
;---------------------------------------------
(defrule MARTES
?acumulado<-(Acumulado (carbohidratos ?carbos) (proteinas ?proteinas) (grasas ?grasas))
?p<-(Persoa (gastoTotal ?gT))
(test (numberp ?gT))
?d<-(dia ?dia)
?aux<-(tipoComida ?comida)
(test (= ?comida 6))
(test (= ?dia 2))
=>
(printout t "MARTES" crlf)
(assert (Almorzo (* 0.25 ?gT)))
(assert (Media (* 0.15 ?gT)))
(assert (Xantar (* 0.25 ?gT)))
(assert (Merenda (* 0.15 ?gT)))
(assert (Cea (* 0.2 ?gT)))
(retract ?aux)
(modify ?acumulado (carbohidratos 0) (proteinas 0) (grasas 0))
(assert (tipoComida 0))
(retract ?d)
(assert (dia 3))
)


;Configuracion do MERCORES, e xa vai ao almorzo
;---------------------------------------------
(defrule MERCORES
?p<-(Persoa (gastoTotal ?gT))
(test (numberp ?gT))
?d<-(dia ?dia)
?aux<-(tipoComida ?comida)
(test (= ?comida 6))
(test (= ?dia 3))
=>
(printout t "MERCORES" crlf)
(assert (Almorzo (* 0.25 ?gT)))
(assert (Media (* 0.15 ?gT)))
(assert (Xantar (* 0.25 ?gT)))
(assert (Merenda (* 0.15 ?gT)))
(assert (Cea (* 0.2 ?gT)))
(retract ?aux)
(assert (tipoComida 0))
(retract ?d)
(assert (dia 4))
)


;Configuracion do XOVES, e xa vai ao almorzo
;---------------------------------------------
(defrule XOVES
?p<-(Persoa (gastoTotal ?gT))
(test (numberp ?gT))
?d<-(dia ?dia)
?aux<-(tipoComida ?comida)
(test (= ?comida 6))
(test (= ?dia 4))
=>
(printout t "XOVES " crlf)
(assert (Almorzo (* 0.25 ?gT)))
(assert (Media (* 0.15 ?gT)))
(assert (Xantar (* 0.25 ?gT)))
(assert (Merenda (* 0.15 ?gT)))
(assert (Cea (* 0.2 ?gT)))
(retract ?aux)
(assert (tipoComida 0))
(retract ?d)
(assert (dia 5))
)

;Configuracion do VENRES, e xa vai ao almorzo
;---------------------------------------------
(defrule VENRES
?p<-(Persoa (gastoTotal ?gT))
(test (numberp ?gT))
?d<-(dia ?dia)
?aux<-(tipoComida ?comida)
(test (= ?comida 6))
(test (= ?dia 5))
=>
(printout t "VENRES " crlf)
(assert (Almorzo (* 0.25 ?gT)))
(assert (Media (* 0.15 ?gT)))
(assert (Xantar (* 0.25 ?gT)))
(assert (Merenda (* 0.15 ?gT)))
(assert (Cea (* 0.2 ?gT)))
(retract ?aux)
(assert (tipoComida 0))
(retract ?d)
(assert (dia 6))
)




;REINICIO PERSOA para restablecer todo a 0 e calcular o da seguinte persona
;---------------------------------------------------------------------
(defrule reinicioPersoa
?p<-(Persoa (gastoTotal ?gT) (dieta nil))
?aux<-(alimento ?alimento)
?d<-(dia ?dia)
?tipo<-(tipoComida ?comida)
(test (= ?comida 6))
(test (= ?dia 6))
(test (= ?alimento 70))
=>
(retract ?aux)
(retract ?tipo)
(retract ?d)
(assert (Acumulado (carbohidratos 0) (proteinas 0) (grasas 0)))
(assert (dia 1))
(assert (alimento 0))
(modify ?p (dieta 1))
)



;REINICIO ALIMENTOS para restablecer os usos a 2
;---------------------------------------------------------------------
(defrule reinicioAlimentos
?a<-(Alimento (nome ?n1) (usos ?usos))
?d<-(dia ?dia)
?aux<-(alimento ?alimento)
?tipo<-(tipoComida ?comida)
(test (= ?comida 6))
(test (= ?dia 6))
(test (< ?alimento 70))
=>
=>
(bind ?ra (+ ?alimento 1))
(modify ?a (usos 2))
(retract ?aux)
(assert (alimento ?ra))
)


;************************************************************
;			DARLLE DE COMER
;************************************************************


;ALMORZO
;-----------------------------------------------------
;Alimentos a usar LEITE, GRASA, PASTA, FRUTA
(defrule rAlmorzo

;LEVAR A CONTA DOS GRAMOS
?acumulado<-(Acumulado (carbohidratos ?acarbos) (proteinas ?aprotes) (grasas  ?agrasas))

;ALIMENTOS A USAR NO ALMORZO
?a1<-(Alimento (nome ?n1) (grupo 1) (carbohidratos ?gc1) (proteinas  ?gp1) (grasas ?gg1) (calorias ?c1) (usos ?usos1))
?a5<-(Alimento (nome ?n5) (grupo 5) (carbohidratos ?gc5) (proteinas  ?gp5) (grasas ?gg5) (calorias ?c5) (usos ?usos5))
?a6<-(Alimento (nome ?n6) (grupo 6) (carbohidratos ?gc6) (proteinas  ?gp6) (grasas ?gg6) (calorias ?c6) (usos ?usos6))
?a7<-(Alimento (nome ?n7) (grupo 7) (carbohidratos ?gc7) (proteinas  ?gp7) (grasas ?gg7) (calorias ?c7) (usos ?usos7))

;COMPROBACION PARA QUE SEA ALMORZO, E GARDAMOS OS DATOS DO ALMORZO
?aux<-(tipoComida ?comida)
?mA<-(macroAlmorzo ?carbos ?protes ?grasas)
(test (= ?comida 0))

;COMPROBACION DO NUMERO DE USOS DOS ALIMENTOS
(test (numberp ?usos1))
(test (> ?usos1 0))
(test (numberp ?usos5))
(test (> ?usos5 0))
(test (numberp ?usos6))
(test (> ?usos6 0))
(test (numberp ?usos7))
(test (> ?usos7 0))

;PARA QUE VARIE OS ALIMENTOS
(test (> 100000 (random)))

=>

;GARDAMOS NA VARIABLE PARA IMPRIMIR OS GRAMOS DE CADA ALIMENTO
(bind ?grN1 (/ (+ (* 0.2 ?carbos) (* 0.40 ?protes) (* 0.1 ?grasas)) ?c1))
(bind ?grN6 (/ (+ (* 0.6 ?carbos) (* 0.40 ?protes) (* 0.2 ?grasas)) ?c6))
(bind ?grN5 (/ (* 0.2 ?carbos) ?c5))
(bind ?grN7 (/ (* 0.7 ?grasas) ?c7))

;SACAMOS OS GRAMOS DE CADA ALIMENTO
(printout t "Almorzo 1: " ?n1 ": "(* 100 ?grN1)" gr  ");Gramos de alimento por calorias
(printout t ""?n6 ": "(* 100 ?grN6)" gr  ");Gramos de alimento por calorias
(printout t "" ?n5 ": "(* 100 ?grN5)" gr  " );Gramos de alimento por calorias
(printout t "" ?n7 ": "(* 100 ?grN7)" gr" crlf);Gramos de alimento por calorias

(retract ?mA)
(assert (tipoComida 1))

(modify ?a1(usos (- ?usos1 1)))
(modify ?a5(usos (- ?usos5 1)))
(modify ?a6(usos (- ?usos6 1)))
(modify ?a7(usos (- ?usos7 1)))


;TOTAIS DE GRAMOS PARA CALCULAR O % DAS CALORIAS
(modify ?acumulado (carbohidratos (+(* ?gc1 ?grN1) (* ?gc6 ?grN6) (* ?gc5 ?grN5))) (proteinas (+ (* ?gp1 ?grN1) (* ?gp6 ?grN6) (* ?gp5 ?grN5))) (grasas (+ (* ?gg1 ?grN1) (* ?gg6 ?grN6)(* ?gg7 ?grN7))))

)



;MEDIA MAÑAN
;-----------------------------------------------------
;Alimentos a usar FRUTA PASTA OVOS
(defrule rMedia

;LEVAR A CONTA DOS GRAMOS
?acumulado<-(Acumulado (carbohidratos ?acarbos) (proteinas ?aprotes) (grasas  ?agrasas))

;ALIMENTOS A USAR NO ALMORZO
?a2<-(Alimento (nome ?n2) (grupo 2) (carbohidratos ?gc2) (proteinas  ?gp2) (grasas ?gg2) (calorias ?c2)(usos ?usos2))
?a5<-(Alimento (nome ?n5) (grupo 5) (carbohidratos ?gc5) (proteinas  ?gp5) (grasas ?gg5) (calorias ?c5)(usos ?usos5))
?a6<-(Alimento (nome ?n6) (grupo 6) (carbohidratos ?gc6) (proteinas  ?gp6) (grasas ?gg6) (calorias ?c6)(usos ?usos6))

;COMPROBACION PARA QUE SEA MEDIA MAÑAN, GARDAMOS OS DATOS
?aux<-(tipoComida ?comida)
?mM<-(macroMedia ?carbos ?protes ?grasas)
(test (= ?comida 1))

;COMPROBACION DO NUMERO DE USOS DOS ALIMENTOS
(test (numberp ?usos2))
(test (> ?usos2 1))
(test (numberp ?usos5))
(test (> ?usos5 1))
(test (numberp ?usos6))
(test (> ?usos6 1))

;PARA QUE VARIE OS ALIMENTOS
(test (> 88800 (random)))
=>
;GARDAMOS NA VARIABLE PARA IMPRIMIR OS GRAMOS DE CADA ALIMENTO
(bind ?grN2 (/ (+ (* 0.4 ?protes) (* 0.4 ?grasas)) ?c2))
(bind ?grN6 (/ (+ (* 0.7 ?carbos) (* 0.6 ?protes) (* 0.4 ?grasas)) ?c6))
(bind ?grN5 (/ (* 0.3 ?carbos) ?c5))


;SACAMOS OS GRAMOS DE CADA ALIMENTO
(printout t "Almorzo 2: " ?n2 ": "(* 100 ?grN2)" gr  ");Gramos de alimento por calorias
(printout t ""?n6 ": "(* 100 ?grN6 )" gr  ");Gramos de alimento por calorias
(printout t "" ?n5 ": "(* 100 ?grN5)" gr" crlf);Gramos de alimento por calorias
(retract ?mM)
(retract ?aux)
(assert (tipoComida 2))

(modify ?a2(usos (- ?usos2 1)))
(modify ?a5(usos (- ?usos5 1)))
(modify ?a6(usos (- ?usos6 1)))


;TOTAIS DE GRAMOS PARA CALCULAR O % DAS CALORIAS
(modify ?acumulado (carbohidratos (+ ?acarbos (* ?gc2 ?grN2) (* ?gc6 ?grN6) (* ?gc5 ?grN5))) (proteinas (+ ?aprotes (* ?gp2 ?grN2) (* ?gp6 ?grN6))) (grasas (+ ?agrasas (* ?gg2 ?grN2) (* ?gg6 ?grN6))))


)



;XANTAR
;-----------------------------------------------------
;Alimentos a usar Legumes Verduras Grasas Carne
(defrule rXantar

;VALOR ACUMULADO DOS GRAMOS DE CADA MACRO NUTRIENTE
?acumulado<-(Acumulado (carbohidratos ?acarbos) (proteinas ?aprotes) (grasas  ?agrasas))

;ALIMENTOS QUE SE VAN A USAR
?a3<-(Alimento (nome ?n3) (grupo 3) (carbohidratos ?gc3) (proteinas  ?gp3) (grasas ?gg3) (calorias ?c3)(usos ?usos3))
?a2<-(Alimento (nome ?n2) (grupo 2) (carbohidratos ?gc2) (proteinas  ?gp2) (grasas ?gg2) (calorias ?c2)(usos ?usos2))
?a7<-(Alimento (nome ?n7) (grupo 7) (carbohidratos ?gc7) (proteinas  ?gp7) (grasas ?gg7) (calorias ?c7)(usos ?usos7))
?a4<-(Alimento (nome ?n4) (grupo 4) (carbohidratos ?gc4) (proteinas  ?gp4) (grasas ?gg4) (calorias ?c4)(usos ?usos4))

;COMPROBACION DO XANTAR
?aux<-(tipoComida ?comida)
?mX<-(macroXantar ?carbos ?protes ?grasas)
(test (= ?comida 2))

;COMPROBACION DO NUMERO DE USOS DE CADA ALIMENTO
(test (numberp ?usos2))
(test (> ?usos2 1))
(test (numberp ?usos3))
(test (> ?usos3 0))
(test (numberp ?usos4))
(test (> ?usos4 0))
(test (numberp ?usos7))
(test (> ?usos7 0))

;PARA VARIAR MAIS OS ALIMENTOS
(test (> 775777 (random)))
=>
;VARIABLES COS CALCULOS CALORICOS, DOS GRAMOS DE CADA ALIMENTO
(bind ?grN2 (/ (+ (* 0.7 ?protes) (* 0.2 ?grasas)) ?c2))
(bind ?grN3 (/ (+ (* 0.8 ?carbos) (* 0.3 ?protes) (* 0.1 ?grasas)) ?c3))
(bind ?grN4 (/ (* 0.2 ?carbos) ?c4))
(bind ?grN7 (/ (* 0.7 ?grasas) ?c7))

;IMPRIMIMOS OS GRAMOS DO ALLIMENTO
(printout t "Comida: " ?n3 ": "(* 100 ?grN3)" gr  ");Gramos de alimento por calorias
(printout t ""?n2 ": "(* 100 ?grN2)" gr  ");Gramos de alimento por calorias
(printout t "" ?n7 ": "(* 100 ?grN7)" gr  " );Gramos de alimento por calorias
(printout t "" ?n4 ": "(* 100 ?grN4)" gr" crlf);Gramos de alimento por calorias
(retract ?mX)
(retract ?aux)
(assert (tipoComida 3))


(modify ?a2(usos (- ?usos2 1)))
(modify ?a3(usos (- ?usos3 1)))
(modify ?a4(usos (- ?usos4 1)))
(modify ?a7(usos (- ?usos7 1)))


;TOTAIS DE GRAMOS DE CADA MACRO
(modify ?acumulado (carbohidratos (+ ?acarbos (* ?gc2 ?grN2) (* ?gc3 ?grN3) (* ?gc4 ?grN4))) (proteinas (+  ?aprotes (* ?gp2 ?grN2) (* ?gp3 ?grN3))) (grasas (+ ?agrasas (* ?gg2 ?grN2) (* ?gg3 ?grN3) (* ?gg7 ?grN7))))


)





;MERENDA
;-----------------------------------------------------
;Alimentos a usar Legumes Froitas Leite
(defrule rMerenda
;ACUMULADO DOS GRAMOS DE CADA MACRO NUTRIENTE
?acumulado<-(Acumulado (carbohidratos ?acarbos) (proteinas ?aprotes) (grasas  ?agrasas))

;ALIMENTOS QUE VAMOS A USAR
?a5<-(Alimento (nome ?n5) (grupo 5) (carbohidratos ?gc5) (proteinas  ?gp5) (grasas ?gg5) (calorias ?c5)(usos ?usos5))
?a3<-(Alimento (nome ?n3) (grupo 3) (carbohidratos ?gc3) (proteinas  ?gp3) (grasas ?gg3) (calorias ?c3)(usos ?usos3))
?a1<-(Alimento (nome ?n1) (grupo 1) (carbohidratos ?gc1) (proteinas  ?gp1) (grasas ?gg1) (calorias ?c1)(usos ?usos1))

;COMPROBACION DO TIPO DE COMIDA
?aux<-(tipoComida ?comida)
?mM<-(macroMerenda ?carbos ?protes ?grasas)
(test (= ?comida 3))

;COMPROBACION DO NUMERO DE USOS
(test (numberp ?usos5))
(test (> ?usos5 0))
(test (numberp ?usos3))
(test (> ?usos3 0))
(test (numberp ?usos1))
(test (> ?usos1 0))

;PARA QUE VARIEN OS ALIMENTOS
(test (> 50550 (random)))
=>

;VARIABLES USADAS PARA CALCULAR OS GRAMOS, CALORICOS REQUERIDOS
(bind ?grN1 (/ (+ (* 0.4 ?carbos) (* 0.5 ?protes) (* 0.3 ?grasas)) ?c1))
(bind ?grN3 (/ (+ (* 0.4 ?carbos) (* 0.5 ?protes) (* 0.7 ?grasas)) ?c3))
(bind ?grN5 (/ (* 0.2 ?carbos) ?c5))

;IMPRESION DOS GRAMOS DOS ALIMENTOS
(printout t "Merenda: " ?n5 ": "(* 100 ?grN5)" gr  ");Gramos de alimento por calorias
(printout t ""?n1 ": "(* 100 ?grN1)" gr  ");Gramos de alimento por calorias
(printout t "" ?n3 ": "(* 100 ?grN3)" gr  " crlf);Gramos de alimento por calorias
(retract ?mM)
(retract ?aux)
(assert (tipoComida 4))


(modify ?a5(usos (- ?usos5 1)))
(modify ?a3(usos (- ?usos3 1)))
(modify ?a1(usos (- ?usos1 1)))

;GRAMOS TOTAIS
(modify ?acumulado (carbohidratos (+ ?acarbos (* ?gc1 ?grN1) (* ?gc3 ?grN3) (* ?gc5 ?grN5))) (proteinas (+  ?aprotes (* ?gp1 ?grN1) (* ?gp3 ?grN3))) (grasas (+ ?agrasas (* ?gg1 ?grN1) (* ?gg3 ?grN3))))

)


;CEA
;-----------------------------------------------------
;Alimentos a usar Verduras Carne Grasas
(defrule rCea
;GRAMOS ACUMULADOS DE CADA MACRO
?acumulado<-(Acumulado (carbohidratos ?acarbos) (proteinas ?aprotes) (grasas  ?agrasas))

;ALIMENTOS QUE SE VAN A SERVIR NA CEA
?a4<-(Alimento (nome ?n4) (grupo 4) (carbohidratos ?gc4) (proteinas  ?gp4) (grasas ?gg4) (calorias ?c4)(usos ?usos4))
?a3<-(Alimento (nome ?n3) (grupo 3) (carbohidratos ?gc3) (proteinas  ?gp3) (grasas ?gg3) (calorias ?c3)(usos ?usos3))
?a7<-(Alimento (nome ?n7) (grupo 7) (carbohidratos ?gc7) (proteinas  ?gp7) (grasas ?gg7) (calorias ?c7)(usos ?usos7))
?a2<-(Alimento (nome ?n2) (grupo 2) (carbohidratos ?gc2) (proteinas  ?gp2) (grasas ?gg2) (calorias ?c2)(usos ?usos2))

;COMPROBAMOS SI E UNHA CEA
?aux<-(tipoComida ?comida)
?mC<-(macroCea ?carbos ?protes ?grasas)
(test (= ?comida 4))

;NUMERO DE USOS DO ALIMENTO
(test (numberp ?usos2))
(test (> ?usos2 0))
(test (numberp ?usos3))
(test (> ?usos3 0))
(test (numberp ?usos4))
(test (> ?usos4 1))
(test (numberp ?usos7))
(test (> ?usos7 0))

;PARA QUE VARIEN OS ALIMENTOS
(test (> 100000 (random)))

=>
;GARDAMOS EN VARIABLES OS GRAMOS DE CADA ALIMENTO, CALORICOS
(bind ?grN2 (/ (+ (* 0.3 ?carbos) (* 0.7 ?protes) (* 0.15 ?grasas)) ?c2))
(bind ?grN3 (/ (+ (* 0.55 ?carbos) (* 0.3 ?protes) (* 0.05 ?grasas))  ?c3))
(bind ?grN4 (/ (* 0.15 ?carbos) ?c4))
(bind ?grN7 (/ (+ (* 0.2 ?protes) (* 0.8 ?grasas))  ?c7))

;IMPRIMIMOS O GRAMOS DOS ALIMENTOS A SERVIR
(printout t "Cena: " ?n4 ": "(* 100 ?grN4)" gr  ");Gramos de alimento por calorias
(printout t "" ?n7 ": "(* 100 ?grN7)" gr  " );Gramos de alimento por calorias
(printout t "" ?n3 ": "(* 100 ?grN3)" gr  " );Gramos de alimento por calorias
(printout t "" ?n2 ": "(* 100 ?grN2)" gr" crlf);Gramos de alimento por calorias
(retract ?mC)
(retract ?aux)
(assert (tipoComida 6))


(modify ?a2(usos (- ?usos2 1)))
(modify ?a3(usos (- ?usos3 1)))
(modify ?a4(usos (- ?usos4 1)))
(modify ?a7(usos (- ?usos7 1)))


;FINAL DA TOTALIDADE DOS GRAMOS DE CADA MACRONUTRIENTE
(modify ?acumulado (carbohidratos (+ ?acarbos (* ?gc2 ?grN2) (* ?gc3 ?grN3) (* ?gc4 ?grN4) (* ?gc7 ?grN7))) (proteinas (+  ?aprotes (* ?gp2 ?grN2) (* ?gp3 ?grN3) (* ?gp7 ?grN7))) (grasas (+ ?agrasas (* ?gg2 ?grN2) (* ?gg3 ?grN3) (* ?gg7 ?grN7))))

;GARDAMOS OS PORCENTAXES DAS CALORIAS
(bind ?porcentajeProteinas (* 100 (/ (* ?aprotes 4) (+ (* ?aprotes 4) (* ?acarbos 4) (* ?agrasas 9)))))
(bind ?porcentajeCarbohidratos (* 100 (/ (* ?acarbos 4) (+ (* ?aprotes 4) (* ?acarbos 4) (* ?agrasas 9)))))
(bind ?porcentajeGrasas (* 100 (/ (* ?agrasas 9) (+ (* ?aprotes 4) (* ?acarbos 4) (* ?agrasas 9)))))

;IMPRIMIMOS AS CALORIAS TOTAIS
(printout t "TOTAL:" crlf)
(printout t "% proteinas: "?porcentajeProteinas"" crlf)
(printout t "% hidratos de carbono: "?porcentajeCarbohidratos"" crlf)
(printout t "% graxas: "?porcentajeGrasas"" crlf)

)


;PERSOAS
;-----------------------------------------------
(deffacts personasBH
;PROBAS
;MULLERES
(Persoa (nome Ana) (apelidos Vilas) (edad 1) (sexo feminino) (peso 4) (actividad-fisica repouso))
(Persoa (nome Ana) (apelidos Gema) (edad 7) (sexo feminino) (peso 27) (actividad-fisica moderada))



;HOMES
(Persoa (nome Francisco) (apelidos Vilas) (edad 16) (sexo masculino) (peso 58) (actividad-fisica intensa))
(Persoa (nome Manuel) (apelidos Vilas) (edad 48) (sexo masculino) (peso 66) (actividad-fisica repouso))
(Persoa (nome Osvaldo) (apelidos Vilas) (edad 66) (sexo masculino) (peso 62) (actividad-fisica intensa))
)