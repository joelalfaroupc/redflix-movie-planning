(define (problem problem_name) (:domain practica_Redflix_base)
(:objects 
 p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 - pelicula
 universo1 universo2 universo3 universo4 - universo
 d1 d2 d3 d4 d5 - dia
)

(:init
  
  (diaActual d1)
  (siguienteDia d1 d2) (siguienteDia d2 d3) (siguienteDia d3 d4)
  (siguienteDia d4 d5)


  (= (ContPorVer) 9)  

  ;; En el catálogo
  (EnCatalogo p1)(EnCatalogo p2)(EnCatalogo p3)(EnCatalogo p4)(EnCatalogo p5)
  (EnCatalogo p6)(EnCatalogo p7)(EnCatalogo p8)(EnCatalogo p9)(EnCatalogo p10)

  ;; Películas que el usuario quiere ver
  (quererVer p1)
  (quererVer p2)
  (quererVer p3)
  (quererVer p4)
  (quererVer p5)
  (quererVer p6)
  (quererVer p7)
  ;(quererVer p8)
  (quererVer p9)
  (quererVer p10)
  
  
  (vistoPrevio p8)

  ;; Predecesores (una película puede tener 0 o 1 predecesor)
  (predecesor p1 p2 universo1)
  (predecesor p4 p5 universo2)
  (predecesor p6 p7 universo3)
  (predecesor p8 p9 universo4)

  ;; Contenido inicial que el usuario ya ha visto
  (ContInicial p1 universo1)
  (ContInicial p4 universo2)
  (ContInicial p6 universo3)
  (ContInicial p8 universo4)


  (sinPredecesor p3)
  (sinPredecesor p10)
)


(:goal 
    (and (= (ContPorVer) 0))
    )

)