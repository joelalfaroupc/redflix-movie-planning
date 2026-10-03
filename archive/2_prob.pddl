(define (problem problem_name) (:domain practica_Redflix_2)
(:objects 
 p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12 - pelicula
 universo1 universo2 universo3 universo4 - universo
 d1 d2 d3 d4 d5 d6 - dia

)

(:init  
    (diaActual d1)
    (siguienteDia d1 d2) (siguienteDia d2 d3) (siguienteDia d3 d4)
    (siguienteDia d4 d5) (siguienteDia d5 d6)

    (diaAnterior d1 d2) (diaAnterior d1 d3) (diaAnterior d1 d4) (diaAnterior d1 d5) (diaAnterior d1 d6) 
    (diaAnterior d2 d3) (diaAnterior d2 d4) (diaAnterior d2 d5) (diaAnterior d2 d6) (diaAnterior d3 d4) 
    (diaAnterior d3 d5) (diaAnterior d3 d6) (diaAnterior d4 d5) (diaAnterior d4 d6) (diaAnterior d5 d6)

    (mismoDia d1 d1) (mismoDia d2 d2) (mismoDia d3 d3) (mismoDia d4 d4) (mismoDia d5 d5) (mismoDia d6 d6)

    ;; En el catálogo
    (EnCatalogo p1)(EnCatalogo p2)(EnCatalogo p3)(EnCatalogo p4)(EnCatalogo p5)
    (EnCatalogo p6)(EnCatalogo p7)(EnCatalogo p8)(EnCatalogo p9)(EnCatalogo p10)
    (EnCatalogo p11)(EnCatalogo p12)

    (= (ContPorVer) 5)

    ;; Películas que el usuario quiere ver
    ;;(quererVer p1)
    ;;(quererVer p2)
    ;;(quererVer p3)
    ;;(quererVer p4)
    (quererVer p5)
    ;;(quererVer p6)
    ;;(quererVer p7)
    (quererVer p8)
    ;;(quererVer p9)
    (quererVer p10)
    (quererVer p11)
    (quererVer p12)

    ;; Universo 1
    (predecesor p1 p2 universo1) (predecesor p2 p3 universo1) (predecesor p3 p4 universo1) (predecesor p4 p5 universo1)

    ;; Universo 2
    (predecesor p6 p7 universo2) (predecesor p7 p8 universo2)

    ;; Universo 3
    (predecesor p9 p10 universo3)

    ;; Paralelos
    (paralelo p10 p5)  (paralelo p1 p6)  
    
    (sinPredecesor p11) (sinPredecesor p12) (sinPredecesor p1) (sinPredecesor p6) (sinPredecesor p9)
    
    (sinParalelo p2) (sinParalelo p3) (sinParalelo p4) (sinParalelo p12)
    (sinParalelo p7) (sinParalelo p8) (sinParalelo p9) (sinParalelo p11) 
)

(:goal 
    (and (= (ContPorVer) 0))
)

)