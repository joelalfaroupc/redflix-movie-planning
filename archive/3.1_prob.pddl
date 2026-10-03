(define (problem redflix) (:domain practica_Redflix_3)
(:objects 
 p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12 - pelicula
 c1 c2 c3 c4 c5 - capitulo
 universo1 universo2 universo3 universo4 - universo
 serie1 - serie
 d1 d2 d3 d4 d5 d6 d7 d8 d9 d10 d11 - dia
 d0 - dia_previo

)

(:init
    ;;Contador contenidos al dia
    (=(ContDia d1) 0)(=(ContDia d2) 0)(=(ContDia d3) 0)(=(ContDia d4) 0)(=(ContDia d5) 0)
    (=(ContDia d6) 0)(=(ContDia d7) 0)(=(ContDia d8) 0)(=(ContDia d9) 0)(=(ContDia d10) 0)(=(ContDia d11) 0)

    ;;(diaActual d1)
    (siguienteDia d1 d2) (siguienteDia d2 d3) (siguienteDia d3 d4)
    (siguienteDia d4 d5) (siguienteDia d5 d6) (siguienteDia d6 d7)
    (siguienteDia d7 d8) (siguienteDia d8 d9) (siguienteDia d9 d10)
    (siguienteDia d10 d11) (siguienteDia d0 d1)

    ; d0 es el dia en el que se ha visto el contenido que nosotros no hemos recomendado (ContenidoAsignado ?c d0) = visto por su cuenta
    (diaAnterior d0 d1) (diaAnterior d0 d2) (diaAnterior d0 d3) (diaAnterior d0 d4) (diaAnterior d0 d5)
    (diaAnterior d0 d6) (diaAnterior d0 d7) (diaAnterior d0 d8) (diaAnterior d0 d9) (diaAnterior d0 d10)
    (diaAnterior d0 d11) (diaAnterior d0 d0)
    
    (diaAnterior d1 d0) (diaAnterior d2 d0) (diaAnterior d3 d0) (diaAnterior d4 d0) (diaAnterior d5 d0)
    (diaAnterior d6 d0) (diaAnterior d7 d0) (diaAnterior d8 d0) (diaAnterior d9 d0) (diaAnterior d10 d0)
    (diaAnterior d11 d0)

    (diaAnterior d1 d2) (diaAnterior d1 d3) (diaAnterior d1 d4) (diaAnterior d1 d5) (diaAnterior d1 d6) 
    (diaAnterior d1 d7) (diaAnterior d1 d8) (diaAnterior d1 d9) (diaAnterior d1 d10) (diaAnterior d1 d11)
    (diaAnterior d2 d3) (diaAnterior d2 d4) (diaAnterior d2 d5) (diaAnterior d2 d6) (diaAnterior d2 d7) 
    (diaAnterior d2 d8) (diaAnterior d2 d9) (diaAnterior d2 d10) (diaAnterior d2 d11) (diaAnterior d3 d4) 
    (diaAnterior d3 d5) (diaAnterior d3 d6) (diaAnterior d3 d7) (diaAnterior d3 d8) (diaAnterior d3 d9) 
    (diaAnterior d3 d10) (diaAnterior d3 d11) (diaAnterior d4 d5) (diaAnterior d4 d6) (diaAnterior d4 d7) 
    (diaAnterior d4 d8) (diaAnterior d4 d9) (diaAnterior d4 d10) (diaAnterior d4 d11) (diaAnterior d5 d6) 
    (diaAnterior d5 d7) (diaAnterior d5 d8) (diaAnterior d5 d9) (diaAnterior d5 d10) (diaAnterior d5 d11) 
    (diaAnterior d6 d7) (diaAnterior d6 d8) (diaAnterior d6 d9) (diaAnterior d6 d10) (diaAnterior d6 d11) 
    (diaAnterior d7 d8) (diaAnterior d7 d9) (diaAnterior d7 d10) (diaAnterior d7 d11) (diaAnterior d8 d9) 
    (diaAnterior d8 d10) (diaAnterior d8 d11) (diaAnterior d9 d10) (diaAnterior d9 d11) (diaAnterior d10 d11)

    (mismoDia d1 d1) (mismoDia d2 d2) (mismoDia d3 d3) (mismoDia d4 d4) (mismoDia d5 d5) 
    (mismoDia d6 d6) (mismoDia d7 d7) (mismoDia d8 d8) (mismoDia d9 d9) (mismoDia d10 d10)
    (mismoDia d11 d11) (mismoDia d0 d0)

    ;; En el catálogo
    (EnCatalogo p1)(EnCatalogo p2)(EnCatalogo p3)(EnCatalogo p4)(EnCatalogo p5)
    (EnCatalogo p6)(EnCatalogo p7)(EnCatalogo p8)(EnCatalogo p9)(EnCatalogo p10)
    (EnCatalogo c1) (EnCatalogo c2) (EnCatalogo c3) (EnCatalogo c4) (EnCatalogo c5)
    (EnCatalogo p11) (EnCatalogo p12)


    (=(ContPorVer) 9)
    ;; Películas que el usuario quiere ver
    ;;(quererVer p1)
    ;(quererVer p2)
    ;(quererVer p3)
    ;;(quererVer p4)
    (quererVer p5)
    ;;(quererVer p6)
    ;;(quererVer p7)
    (quererVer p8)
    ;;(quererVer p9)
    (quererVer p10)
    (quererVer c1)
    (quererVer c2)
    (quererVer c3)
    (quererVer c4)
    (quererVer c5)
    (quererVer p11)

    ;; Universo 1
    (predecesor p1 p2 universo1) (predecesor p2 p3 universo1) (predecesor p3 p4 universo1) (predecesor p4 p5 universo1)

    ;; Universo 2
    (predecesor p6 p7 universo2) (predecesor p7 p8 universo2)

    ;; Universo 3
    (predecesor p9 p10 universo3)

    ;serie1
    (predecesor c1 c2 serie1) (predecesor c2 c3 serie1) (predecesor c3 c4 serie1) (predecesor c4 c5 serie1)

    ;paralelos1

    (paralelo p11 p12) ; paralelos  sueltos

    ;; Paralelos2
    (paralelo p10 c5)

    (ContenidoAsignado p6 d0) ; contenido visto por su cuenta
    
)

(:goal 
    (and (= (ContPorVer) 0))
)

)