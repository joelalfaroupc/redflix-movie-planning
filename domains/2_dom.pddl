(define (domain practica_Redflix_2)

(:requirements :typing :adl :fluents)


(:types contenido universo dia - object
    serie - universo
    pelicula capitulo - contenido
)

(:functions
    (ContPorVer)
)

(:predicates 
    (visto ?c - contenido) ;; el  usuario ha visto el contenido por nuestra recomendacion
    (vistoPrevio ?c - contenido) ;; el usuario ya habia visto el contenido por su cuenta
    (sinPredecesor ?c - contenido) ;; peliculas  sueltas
    (sinParalelo ?c - contenido) ;; peliculas  sueltas
    (predecesor ?c1 - contenido ?c2 - contenido ?u - universo) ;; c1 va antes de c2
    (paralelo ?c1 - contenido ?c2 - contenido)
    (diaActual ?dia - dia)
    (siguienteDia ?d1 - dia ?d2 - dia) ;; d1 es el dia antes de d2
    (diaAnterior ?d1 - dia ?d2 - dia) ;; d1 es uno de los dias que pasa antes que d2
    (mismoDia ?d1 - dia ?d2 - dia)
    (EnCatalogo ?c - contenido)
    (ContenidoAsignado ?c - contenido ?d - dia)
    (quererVer ?c - contenido)

)

(:action Incluir_EnPlan 
    :parameters (?c - contenido ?c1 - contenido ?u - universo)
    :precondition (and (not (quererVer ?c)) (not (or (visto ?c) (vistoPrevio ?c))) (or (quererVer ?c1) (vistoPrevio ?c1)) (or (predecesor ?c ?c1 ?u) 
                    (paralelo ?c1 ?c) (paralelo ?c ?c1)) (EnCatalogo ?c) (EnCatalogo ?c1))
    :effect (and (quererVer ?c) (increase (ContPorVer) 1))
)

(:action asig_Cont_Predec_Asignado
    :parameters (?c - contenido ?d - dia ?c1 - contenido ?d1 - dia ?u - universo) 
    :precondition (and (quererVer ?c) (predecesor ?c1 ?c ?u) (ContenidoAsignado ?c1 ?d1) 
                    (EnCatalogo ?c) (EnCatalogo ?c1) (siguienteDia ?d1 ?d) (sinParalelo ?c))
    :effect (and (not (quererVer ?c)) (visto ?c) (decrease (ContPorVer) 1) (ContenidoAsignado ?c ?d))
)

(:action asig_Cont_Pred_Visto
    :parameters (?c - contenido ?d - dia ?c1 - contenido ?u - universo) 
    :precondition (and (quererVer ?c) (predecesor ?c1 ?c ?u) (vistoPrevio ?c1) (EnCatalogo ?c) (sinPredecesor ?c1) 
                    (EnCatalogo ?c1) (diaActual ?d) (sinParalelo ?c))
    :effect (and (not (quererVer ?c)) (visto ?c) (decrease (ContPorVer) 1) (ContenidoAsignado ?c ?d))
)

(:action asig_Cont_Pred_Visto_ConPred
    :parameters (?c - contenido ?d - dia ?c1 - contenido ?c2 - contenido ?d2 - dia ?u - universo) 
    :precondition (and (quererVer ?c) (predecesor ?c1 ?c ?u) (vistoPrevio ?c1) (EnCatalogo ?c) (EnCatalogo ?c1)
                    (predecesor ?c2 ?c1 ?u) (ContenidoAsignado ?c2 ?d2) (siguienteDia ?d2 ?d))
    :effect (and (not (quererVer ?c)) (visto ?c) (decrease (ContPorVer) 1) (ContenidoAsignado ?c ?d))
)

(:action asig_Contenido
    :parameters (?c - contenido ?d - dia ?u - universo)
    :precondition (and (quererVer ?c) (sinPredecesor ?c) (EnCatalogo ?c) (diaActual ?d) (sinParalelo ?c))
    :effect (and (not (quererVer ?c)) (visto ?c) (decrease (ContPorVer) 1) (ContenidoAsignado ?c ?d))
)

;;asignar el primer paralelo para dos contenidos que ninguno tiene predecesor
(:action asig_Primer_Paralelo_sinPrec
    :parameters (?c - contenido  ?c1 - contenido ?d - dia ?u - universo)
    :precondition (and (quererVer ?c) (or (not (visto ?c1)) (vistoPrevio ?c1)) (EnCatalogo ?c) 
                (diaActual ?d) (or (paralelo ?c ?c1) (paralelo ?c1 ?c)) (sinPredecesor ?c) (sinPredecesor ?c1))
    :effect (and (not (quererVer ?c)) (visto ?c) (decrease (ContPorVer) 1) (ContenidoAsignado ?c ?d))
)

;;asignar el segundo paralelo para dos contenidos q ninguno tiene predecesores
(:action asig_Paralelo2_NingunPredec
    :parameters (?c - contenido ?c1 - contenido ?d1 - dia ?u - universo)
    :precondition (and (quererVer ?c) (or (paralelo ?c ?c1) (paralelo ?c1 ?c)) (ContenidoAsignado ?c1 ?d1) 
                    (EnCatalogo ?c) (EnCatalogo ?c1) (sinPredecesor ?c)(sinPredecesor ?c1))
    :effect (and (not (quererVer ?c)) (visto ?c) (decrease (ContPorVer) 1) (ContenidoAsignado ?c ?d1))
)

;;asignar el primer paralelo para dos contenidos que el primero si tiene predecesor y el segundo no
(:action asig_Primer_Paralelo_ConPredec_asig
    :parameters (?c - contenido ?d - dia ?c1 - contenido ?c2 - contenido ?d2 - dia ?u - universo)
    :precondition (and (quererVer ?c) (or (not (visto ?c1)) (vistoPrevio ?c1)) (EnCatalogo ?c) (EnCatalogo ?c1) (EnCatalogo ?c2)
                    (or (paralelo ?c ?c1) (paralelo ?c1 ?c)) (predecesor ?c2 ?c ?u) (ContenidoAsignado ?c2 ?d2) (siguienteDia ?d2 ?d)
                    (sinPredecesor ?c1))
    :effect (and (not (quererVer ?c)) (visto ?c) (decrease (ContPorVer) 1) (ContenidoAsignado ?c ?d))
)

;;asignar el segundo paralelo para dos contenidos que el primero si tiene predecesor y el segundo no
(:action asig_Paralelo2_Asig_ConPredec
    :parameters (?c - contenido ?c1 - contenido ?d1 - dia)
    :precondition (and (quererVer ?c) (or (paralelo ?c ?c1) (paralelo ?c1 ?c)) (ContenidoAsignado ?c1 ?d1) 
                    (EnCatalogo ?c) (EnCatalogo ?c1) (sinPredecesor ?c))
    :effect (and (not (quererVer ?c)) (visto ?c) (decrease (ContPorVer) 1) (ContenidoAsignado ?c ?d1))
)

;;asignar primer paralelo para dos contenidos que tienen predecesores (el predecesor del primero esta asignado 
;;antes que el predecesor del segundo paralelo)
(:action asig_Segundo_Paralelo_ConPredec_asig1
    :parameters (?c - contenido ?c1 - contenido ?c2 - contenido ?d2 - dia ?u1 - universo ?c3 - contenido ?d3 - dia 
                     ?u2 - universo)
    :precondition (and (quererVer ?c) (EnCatalogo ?c) (EnCatalogo ?c1) (EnCatalogo ?c2) (EnCatalogo ?c3) (or (paralelo ?c ?c1) 
                    (paralelo ?c1 ?c)) (or (not (visto ?c1)) (vistoPrevio ?c1))
                    (predecesor ?c2 ?c ?u1) (predecesor ?c3 ?c1 ?u2) (ContenidoAsignado ?c2 ?d2) 
                    (ContenidoAsignado ?c3 ?d3) (diaAnterior ?d2 ?d3))
    :effect (and (not (quererVer ?c)) (visto ?c) (decrease (ContPorVer) 1) (ContenidoAsignado ?c ?d3))
)

;;asignar primer paralelo para dos contenidos que tienen predecesores (el predecesor del primero esta asignado 
;;despues que el predecesor del segundo paralelo)
(:action asig_Segundo_Paralelo_ConPredec_asig2
    :parameters (?c - contenido ?d - dia ?c1 - contenido ?c2 - contenido ?d2 - dia ?u1 - universo ?c3 - contenido ?d3 - dia 
            ?u2 - universo)
    :precondition (and (quererVer ?c) (EnCatalogo ?c) (EnCatalogo ?c1) (EnCatalogo ?c2) (EnCatalogo ?c3) (or (paralelo ?c ?c1) 
                    (paralelo ?c1 ?c)) (or (not (visto ?c1)) (vistoPrevio ?c1))
                    (predecesor ?c2 ?c ?u1) (predecesor ?c3 ?c1 ?u2) (ContenidoAsignado ?c2 ?d2) 
                    (ContenidoAsignado ?c3 ?d3) (diaAnterior ?d3 ?d2) (siguienteDia ?d2 ?d))
    :effect (and (not (quererVer ?c)) (visto ?c) (decrease (ContPorVer) 1) (ContenidoAsignado ?c ?d))
)

;;asignar primer paralelo para dos contenidos que tienen predecesores (el predecesor del primero esta asignado 
;;el mismo dia que el predecesor del segundo paralelo)
(:action asig_Segundo_Paralelo_ConPredec_asig3
    :parameters (?c - contenido ?d - dia ?c1 - contenido ?c2 - contenido ?d2 - dia ?u1 - universo ?c3 - contenido ?d3 - dia 
                     ?u2 - universo)
    :precondition (and (quererVer ?c) (EnCatalogo ?c) (EnCatalogo ?c1) (EnCatalogo ?c2) (EnCatalogo ?c3) (or (paralelo ?c ?c1) 
                    (paralelo ?c1 ?c)) (or (not (visto ?c1)) (vistoPrevio ?c1))
                    (predecesor ?c2 ?c ?u1) (predecesor ?c3 ?c1 ?u2) (ContenidoAsignado ?c2 ?d2) 
                    (ContenidoAsignado ?c3 ?d3) (mismoDia ?d3 ?d2) (siguienteDia ?d2 ?d))
    :effect (and (not (quererVer ?c)) (visto ?c) (decrease (ContPorVer) 1) (ContenidoAsignado ?c ?d))
)

;;asignar el segundo paralelo para dos contenidos que los dos tienen predecesores asignados (el primero esta asignado antes)
(:action asig_Segundo_Paralelo_ConPredec_asig
    :parameters (?c - contenido ?d - dia ?c1 - contenido ?d1 - dia)
    :precondition (and (quererVer ?c) (EnCatalogo ?c) (EnCatalogo ?c1) (or (paralelo ?c ?c1) 
                    (paralelo ?c1 ?c)) (ContenidoAsignado ?c1 ?d1) (siguienteDia ?d1 ?d))
    :effect (and (not (quererVer ?c)) (visto ?c) (decrease (ContPorVer) 1) (ContenidoAsignado ?c ?d))
)
)