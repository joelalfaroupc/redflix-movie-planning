(define (domain practica_Redflix_base)

(:requirements :typing :adl :fluents)


(:types contenido universo dia - object
    serie - universo
    pelicula capitulo - contenido
)

(:functions
    (ContPorVer)
)

(:predicates 
    (visto ?c - contenido)
    (vistoPrevio ?c - contenido)
    (sinPredecesor ?c - contenido)
    (predecesor ?c1 - contenido ?c2 - contenido ?u - universo) ;; c1 va antes de c2
    (ContInicial ?c - contenido ?u - universo)
    (quererVer ?c - contenido)
    (EnCatalogo ?c - contenido)
    (ContenidoAsignado ?c - contenido ?d - dia)
    (diaActual ?dia - dia)
    (siguienteDia ?d1 - dia ?d2 - dia) ;; d1 es el dia antes de d2

)

(:action Incluir_EnPlan 
    :parameters (?c - contenido ?c1 - contenido ?u - universo)
    :precondition (and (not (quererVer ?c)) (not (visto ?c)) (quererVer ?c1) (predecesor ?c ?c1 ?u) 
                    (EnCatalogo ?c) (EnCatalogo ?c1))
    :effect (and (quererVer ?c) (increase (ContPorVer) 1))
)

(:action asig_Cont_Predec
    :parameters (?c - contenido ?d - dia ?c1 - contenido ?d1 - dia ?u - universo)
    :precondition (and (quererVer ?c) (predecesor ?c1 ?c ?u) (ContenidoAsignado ?c1 ?d1) (EnCatalogo ?c) 
                    (EnCatalogo ?c1) (siguienteDia ?d1 ?d))
    :effect (and (not (quererVer ?c)) (visto ?c) (decrease (ContPorVer) 1) (ContenidoAsignado ?c ?d))
)

(:action asig_Cont_Predec_Prev
    :parameters (?c - contenido ?d - dia ?c1 - contenido ?u - universo)
    :precondition (and (quererVer ?c) (predecesor ?c1 ?c ?u) (vistoPrevio ?c1) (EnCatalogo ?c) 
                    (EnCatalogo ?c1) (diaActual ?d))
    :effect (and (not (quererVer ?c)) (visto ?c) (decrease (ContPorVer) 1) (ContenidoAsignado ?c ?d))
)

(:action asig_Cont
    :parameters (?c - contenido ?d - dia  ?u - universo)
    :precondition (and (quererVer ?c) (or (ContInicial ?c ?u) (sinPredecesor ?c)) (EnCatalogo ?c)(diaActual ?d))
    :effect (and (not (quererVer ?c)) (visto ?c) (decrease (ContPorVer) 1)(ContenidoAsignado ?c ?d))
)
)