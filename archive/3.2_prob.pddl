(define (problem redflix_extended) (:domain practica_Redflix_3)
(:objects 
 p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12 p13 p14 p15 p16 p17 p18 p19 p20
 p21 p22 p23 p24 p25 p26 p27 p28 p29 p30 - pelicula
 universo1 universo2 universo3 universo4 universo5 universo6 - universo
 d1 d2 d3 d4 d5 d6 d7 d8 d9 d10 d11 d12 d13 d14 d15 d16 d17 d18 d19 d20 - dia
 d0 - dia_previo
)

(:init
    (=(ContPorVer) 10)  

    ;;Contador contenidos al dia
    (=(ContDia d1) 0)(=(ContDia d2) 0)(=(ContDia d3) 0)(=(ContDia d4) 0)(=(ContDia d5) 0)
    (=(ContDia d6) 0)(=(ContDia d7) 0)(=(ContDia d8) 0)(=(ContDia d9) 0)(=(ContDia d10) 0)
    (=(ContDia d11) 0)(=(ContDia d12) 0)(=(ContDia d13) 0)(=(ContDia d14) 0)(=(ContDia d15) 0)
    (=(ContDia d16) 0)(=(ContDia d17) 0)(=(ContDia d18) 0)(=(ContDia d19) 0)(=(ContDia d20) 0)

    (siguienteDia d1 d2) (siguienteDia d2 d3) (siguienteDia d3 d4)
    (siguienteDia d4 d5) (siguienteDia d5 d6) (siguienteDia d6 d7)
    (siguienteDia d7 d8) (siguienteDia d8 d9) (siguienteDia d9 d10)
    (siguienteDia d10 d11) (siguienteDia d11 d12) (siguienteDia d12 d13)
    (siguienteDia d13 d14) (siguienteDia d14 d15) (siguienteDia d15 d16)
    (siguienteDia d16 d17) (siguienteDia d17 d18) (siguienteDia d18 d19)
    (siguienteDia d19 d20)

    (diaAnterior d1 d2) (diaAnterior d1 d3) (diaAnterior d1 d4) (diaAnterior d1 d5) (diaAnterior d1 d6) 
    (diaAnterior d1 d7) (diaAnterior d1 d8) (diaAnterior d1 d9) (diaAnterior d1 d10) (diaAnterior d1 d11)
    (diaAnterior d1 d12) (diaAnterior d1 d13) (diaAnterior d1 d14) (diaAnterior d1 d15) (diaAnterior d1 d16)
    (diaAnterior d1 d17) (diaAnterior d1 d18) (diaAnterior d1 d19) (diaAnterior d1 d20) (diaAnterior d2 d3) 
    (diaAnterior d2 d4) (diaAnterior d2 d5) (diaAnterior d2 d6) (diaAnterior d2 d7) (diaAnterior d2 d8) 
    (diaAnterior d2 d9) (diaAnterior d2 d10) (diaAnterior d2 d11) (diaAnterior d2 d12) (diaAnterior d2 d13) 
    (diaAnterior d2 d14) (diaAnterior d2 d15) (diaAnterior d2 d16) (diaAnterior d2 d17) (diaAnterior d2 d18)
    (diaAnterior d2 d19) (diaAnterior d2 d20) (diaAnterior d3 d4) (diaAnterior d3 d5) (diaAnterior d3 d6) 
    (diaAnterior d3 d7) (diaAnterior d3 d8) (diaAnterior d3 d9) (diaAnterior d3 d10) (diaAnterior d3 d11) 
    (diaAnterior d3 d12) (diaAnterior d3 d13) (diaAnterior d3 d14) (diaAnterior d3 d15) (diaAnterior d3 d16)
    (diaAnterior d3 d17) (diaAnterior d3 d18) (diaAnterior d3 d19) (diaAnterior d3 d20) (diaAnterior d4 d5) 
    (diaAnterior d4 d6) (diaAnterior d4 d7) (diaAnterior d4 d8) (diaAnterior d4 d9) (diaAnterior d4 d10) 
    (diaAnterior d4 d11) (diaAnterior d4 d12) (diaAnterior d4 d13) (diaAnterior d4 d14) (diaAnterior d4 d15) 
    (diaAnterior d4 d16) (diaAnterior d4 d17) (diaAnterior d4 d18) (diaAnterior d4 d19) (diaAnterior d4 d20)
    (diaAnterior d5 d6) (diaAnterior d5 d7) (diaAnterior d5 d8) (diaAnterior d5 d9) (diaAnterior d5 d10) 
    (diaAnterior d5 d11) (diaAnterior d5 d12) (diaAnterior d5 d13) (diaAnterior d5 d14) (diaAnterior d5 d15) 
    (diaAnterior d5 d16) (diaAnterior d5 d17) (diaAnterior d5 d18) (diaAnterior d5 d19) (diaAnterior d5 d20)
    (diaAnterior d6 d7) (diaAnterior d6 d8) (diaAnterior d6 d9) (diaAnterior d6 d10) (diaAnterior d6 d11) 
    (diaAnterior d6 d12) (diaAnterior d6 d13) (diaAnterior d6 d14) (diaAnterior d6 d15) (diaAnterior d6 d16)
    (diaAnterior d6 d17) (diaAnterior d6 d18) (diaAnterior d6 d19) (diaAnterior d6 d20) (diaAnterior d7 d8) 
    (diaAnterior d7 d9) (diaAnterior d7 d10) (diaAnterior d7 d11) (diaAnterior d7 d12) (diaAnterior d7 d13) 
    (diaAnterior d7 d14) (diaAnterior d7 d15) (diaAnterior d7 d16) (diaAnterior d7 d17) (diaAnterior d7 d18)
    (diaAnterior d7 d19) (diaAnterior d7 d20) (diaAnterior d8 d9) (diaAnterior d8 d10) (diaAnterior d8 d11) 
    (diaAnterior d8 d12) (diaAnterior d8 d13) (diaAnterior d8 d14) (diaAnterior d8 d15) (diaAnterior d8 d16)
    (diaAnterior d8 d17) (diaAnterior d8 d18) (diaAnterior d8 d19) (diaAnterior d8 d20) (diaAnterior d9 d10) 
    (diaAnterior d9 d11) (diaAnterior d9 d12) (diaAnterior d9 d13) (diaAnterior d9 d14) (diaAnterior d9 d15) 
    (diaAnterior d9 d16) (diaAnterior d9 d17) (diaAnterior d9 d18) (diaAnterior d9 d19) (diaAnterior d9 d20)
    (diaAnterior d10 d11) (diaAnterior d10 d12) (diaAnterior d10 d13) (diaAnterior d10 d14) (diaAnterior d10 d15) 
    (diaAnterior d10 d16) (diaAnterior d10 d17) (diaAnterior d10 d18) (diaAnterior d10 d19) (diaAnterior d10 d20)
    (diaAnterior d11 d12) (diaAnterior d11 d13) (diaAnterior d11 d14) (diaAnterior d11 d15) (diaAnterior d11 d16)
    (diaAnterior d11 d17) (diaAnterior d11 d18) (diaAnterior d11 d19) (diaAnterior d11 d20) (diaAnterior d12 d13) 
    (diaAnterior d12 d14) (diaAnterior d12 d15) (diaAnterior d12 d16) (diaAnterior d12 d17) (diaAnterior d12 d18)
    (diaAnterior d12 d19) (diaAnterior d12 d20) (diaAnterior d13 d14) (diaAnterior d13 d15) (diaAnterior d13 d16)
    (diaAnterior d13 d17) (diaAnterior d13 d18) (diaAnterior d13 d19) (diaAnterior d13 d20) (diaAnterior d14 d15)
    (diaAnterior d14 d16) (diaAnterior d14 d17) (diaAnterior d14 d18) (diaAnterior d14 d19) (diaAnterior d14 d20)
    (diaAnterior d15 d16) (diaAnterior d15 d17) (diaAnterior d15 d18) (diaAnterior d15 d19) (diaAnterior d15 d20)
    (diaAnterior d16 d17) (diaAnterior d16 d18) (diaAnterior d16 d19) (diaAnterior d16 d20) (diaAnterior d17 d18)
    (diaAnterior d17 d19) (diaAnterior d17 d20) (diaAnterior d18 d19) (diaAnterior d18 d20) (diaAnterior d19 d20)

    (mismoDia d1 d1) (mismoDia d2 d2) (mismoDia d3 d3) (mismoDia d4 d4) (mismoDia d5 d5) 
    (mismoDia d6 d6) (mismoDia d7 d7) (mismoDia d8 d8) (mismoDia d9 d9) (mismoDia d10 d10)
    (mismoDia d11 d11) (mismoDia d12 d12) (mismoDia d13 d13) (mismoDia d14 d14) (mismoDia d15 d15)
    (mismoDia d16 d16) (mismoDia d17 d17) (mismoDia d18 d18) (mismoDia d19 d19) (mismoDia d20 d20)

    ;; En el catálogo
    (EnCatalogo p1)(EnCatalogo p2)(EnCatalogo p3)(EnCatalogo p4)(EnCatalogo p5)
    (EnCatalogo p6)(EnCatalogo p7)(EnCatalogo p8)(EnCatalogo p9)(EnCatalogo p10)
    (EnCatalogo p11)(EnCatalogo p12)(EnCatalogo p13)(EnCatalogo p14)(EnCatalogo p15)
    (EnCatalogo p16)(EnCatalogo p17)(EnCatalogo p18)(EnCatalogo p19)(EnCatalogo p20)
    (EnCatalogo p21)(EnCatalogo p22)(EnCatalogo p23)(EnCatalogo p24)(EnCatalogo p25)
    (EnCatalogo p26)(EnCatalogo p27)(EnCatalogo p28)(EnCatalogo p29)(EnCatalogo p30)

    ;; Películas que el usuario quiere ver
    (quererVer p5)(quererVer p8)(quererVer p10)(quererVer p11)(quererVer p12)
    (quererVer p15)(quererVer p18)(quererVer p20)(quererVer p25)(quererVer p30)

    ;; Universo 1
    (predecesor p1 p2 universo1) (predecesor p2 p3 universo1) (predecesor p3 p4 universo1) (predecesor p4 p5 universo1)

    ;; Universo 2
    (predecesor p6 p7 universo2) (predecesor p7 p8 universo2)

    ;; Universo 3
    (predecesor p9 p10 universo3)

    ;; Universo 4
    (predecesor p11 p12 universo4)

    ;; Universo 5
    (predecesor p13 p14 universo5) (predecesor p14 p15 universo5) (predecesor p15 p16 universo5) (predecesor p16 p17 universo5)

    ;; Universo 6
    (predecesor p18 p19 universo6) (predecesor p19 p20 universo6)

    ;; Paralelos
    (paralelo p9 p5) (paralelo p21 p22) (paralelo p23 p24) (paralelo p25 p26) (paralelo p27 p28) (paralelo p29 p30)
)

(:goal 
    (and (= (ContPorVer) 0))
)

)