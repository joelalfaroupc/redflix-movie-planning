(define (problem problem_name) (:domain practica_Redflix_1)
(:objects 
 p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 - pelicula
 cap1 cap2 cap3 cap4 cap5 - capitulo
 universo1 universo2 universo3 universo4 - universo
 breaking_bad - serie
 d1 d2 d3 d4 d5 d6 - dia
)

(:init
    (= (ContPorVer) 2)  

    (diaActual d1)
    (siguienteDia d1 d2)
    (siguienteDia d2 d3)
    (siguienteDia d3 d4)
    (siguienteDia d4 d5)
    (siguienteDia d5 d6)

    ;; En el catálogo
    (EnCatalogo p1)(EnCatalogo p2)(EnCatalogo p3)(EnCatalogo p4)(EnCatalogo p5)
    (EnCatalogo p6)(EnCatalogo p7)(EnCatalogo p8)(EnCatalogo p9)(EnCatalogo p10)
    (EnCatalogo cap1)(EnCatalogo cap2)(EnCatalogo cap3)(EnCatalogo cap4)(EnCatalogo cap5)


    ;; Películas que el usuario quiere ver
    ;;(quererVer p1)
    ;(quererVer p2)
    ;;(quererVer p3)
    ;;(quererVer p4)
    (quererVer p5)
    ;;(quererVer p6)
    ;;(quererVer p7)
    (quererVer p8)
    ;;(quererVer p9)
    (quererVer p10)

    ;; Universo 1
    (predecesor p1 p2 universo1)
    (predecesor p2 p3 universo1)
    (predecesor p3 p4 universo1)
    (predecesor p4 p5 universo1)

    ;; Universo 2
    (predecesor p6 p7 universo2)
    (predecesor p7 p8 universo2)

    ;; Universo 3
    (predecesor p9 p10 universo3)

    ;Breaking Bad
    (predecesor cap1 cap2 breaking_bad)
    (predecesor cap2 cap3 breaking_bad)
    (predecesor cap3 cap4 breaking_bad)
    (predecesor cap4 cap5 breaking_bad)

    ;; Contenido inicial: primeras películas del grupo
    (ContInicial p1 universo1)
    (ContInicial p6 universo2)
    (ContInicial p9 universo3)

    (ContInicial cap1 breaking_bad)

    (vistoPrevio p3) ;ve la pelicula 3 antes de empezar a asignar peliculas
)

(:goal 
    (and (= (ContPorVer) 0))
    )
)