(define (domain practica_Redflix_4)

(:requirements :typing :adl :fluents)

(:types contenido universo dias - object
    dia dia_previo - dias
    serie - universo
    pelicula capitulo - contenido
)

(:functions
    (ContPorVer)
    (ContDia ?d - dia)
    (MinPorDia ?d - dia)
    (duracion ?c - contenido)
)

(:predicates 
    (predecesor ?c1 - contenido ?c2 - contenido ?u - universo)
    (paralelo ?c1 - contenido ?c2 - contenido)
    (siguienteDia ?d1 - dias ?d2 - dias)
    (diaAnterior ?d1 - dias ?d2 - dias)
    (mismoDia ?d1 - dias ?d2 - dias)
    (EnCatalogo ?c - contenido)
    (ContenidoAsignado ?c - contenido ?d - dias)
    (quererVer ?c - contenido)
)

 (:action Incluir_EnPlan 
     :parameters (?c - contenido ?c1 - contenido ?u - universo)
     :precondition (and (not (quererVer ?c)) (not (exists (?d - dias) (ContenidoAsignado ?c ?d))) (or (quererVer ?c1) (exists (?d - dia_previo) (ContenidoAsignado ?c1 ?d)))
                     (or (predecesor ?c ?c1 ?u) (paralelo ?c1 ?c) (paralelo ?c ?c1)) (EnCatalogo ?c) (EnCatalogo ?c1))
     :effect (and (quererVer ?c) (increase (ContPorVer) 1))
 )

(:action Asignar_Contenido
    :parameters (?c - contenido ?d - dia)
    :precondition 
    (and 
        (quererVer ?c)
        (<= (+(MinPorDia ?d)(duracion ?c)) 200)  ;hay espacio para añadir un contenido mas
        
        (forall (?c1 - contenido ?u - universo)
            (imply (predecesor ?c1 ?c ?u)
                (exists (?d1 - dias)
                    (and (ContenidoAsignado ?c1 ?d1) (diaAnterior ?d1 ?d))
                )
            )
        )
    
        (forall (?c1 - contenido)
            (imply (or (paralelo ?c1 ?c) (paralelo ?c ?c1))
                (or ;o queremos ver el segundo paralelo (+ restricciones) o no hemos visto ninguno de los dos
                    (exists (?d1 - dia)
                        (and (ContenidoAsignado ?c1 ?d1) 
                            (or (mismoDia ?d1 ?d) (siguienteDia ?d ?d1))
                        )
                    )
                    (quererVer ?c1)
                )
            )
        )

        (forall (?d1 - dia)
            (imply (diaAnterior ?d1 ?d)
                (> (ContDia ?d1) 0)
            )
        )
    )
    :effect 
    (and
        (not (quererVer ?c)) 
        (decrease (ContPorVer) 1) 
        (ContenidoAsignado ?c ?d)
        (increase (ContDia ?d) 1)
        (increase (MinPorDia ?d) (duracion ?c))
    )
)

)