(define (domain practica_Redflix_1)

(:requirements :typing :adl :fluents)


(:types contenido universo dia - object
    serie - universo
    pelicula capitulo - contenido
)
(:functions
    (ContPorVer)
)

(:predicates 
    (visto ?c - contenido) ; visto por recomendacion
    (vistoPrevio ?c - contenido) ; visto por cuenta propia
    (sinPredecesor ?c - contenido) ; para peliculas sueltas
    (predecesor ?c1 - contenido ?c2 - contenido ?u - universo) ;; c1 va antes de c2
    (ContInicial ?c - contenido ?u - universo) ; para peliculas con predecesor
    (quererVer ?c - contenido)
    (diaActual ?dia - dia)
    (EnCatalogo ?c - contenido)
    (ContenidoAsignado ?c - contenido ?d - dia) 
    (siguienteDia ?d1 - dia ?d2 - dia) ;; d1 es el dia antes de d2
)

(:action Incluir_EnPlan
    :parameters (?c - contenido ?c1 - contenido ?u - universo)
    :precondition (and (not (quererVer ?c)) (not (or (visto ?c) (vistoPrevio ?c))) (or (quererVer ?c1)(vistoPrevio ?c1)) (predecesor ?c ?c1 ?u) 
                    (EnCatalogo ?c) (EnCatalogo ?c1))
    :effect (and (quererVer ?c) (increase (ContPorVer) 1))
)

(:action asig_Cont_Predec_Asignado
    :parameters (?c - contenido ?d - dia ?c1 - contenido ?d1 - dia ?u - universo) 
    :precondition (and (quererVer ?c) (predecesor ?c1 ?c ?u) (ContenidoAsignado ?c1 ?d1) (EnCatalogo ?c) (EnCatalogo ?c1) (siguienteDia ?d1 ?d))
    :effect (and (not (quererVer ?c)) (visto ?c) (decrease (ContPorVer) 1) (ContenidoAsignado ?c ?d))
)

(:action asig_Cont_Pred_Visto
    :parameters (?c - contenido ?d - dia ?c1 - contenido ?u - universo) 
    :precondition (and (quererVer ?c) (predecesor ?c1 ?c ?u) (vistoPrevio ?c1) (or (sinPredecesor ?c1)(ContInicial ?c1 ?u)) (EnCatalogo ?c) (EnCatalogo ?c1) (diaActual ?d))
    :effect (and (not (quererVer ?c)) (visto ?c) (decrease (ContPorVer) 1) (ContenidoAsignado ?c ?d))
)

(:action asig_Cont_Pred_Visto_ConPred
    :parameters (?c - contenido ?d - dia ?c1 - contenido ?c2 - contenido ?d2 - dia ?u - universo) 
    :precondition (and (quererVer ?c) (predecesor ?c1 ?c ?u) (vistoPrevio ?c1) (EnCatalogo ?c) (EnCatalogo ?c1)
                    (predecesor ?c2 ?c1 ?u) (ContenidoAsignado ?c2 ?d2) (siguienteDia ?d2 ?d))
    :effect (and (not (quererVer ?c)) (visto ?c) (decrease (ContPorVer) 1) (ContenidoAsignado ?c ?d))
)

(:action asig_Contenido
    :parameters (?c - contenido  ?u - universo ?d - dia)
    :precondition (and (quererVer ?c) (or (ContInicial ?c ?u) (sinPredecesor ?c)) (EnCatalogo ?c) (diaActual ?d))
    :effect (and (not (quererVer ?c)) (visto ?c) (decrease (ContPorVer) 1) (ContenidoAsignado ?c ?d))
)
)