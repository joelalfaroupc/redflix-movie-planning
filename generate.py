import random
import subprocess
import sys

def generate_pddl_problem(num_peliculas, extension, output_file="problem_redflix.pddl", seed=42):
    if not isinstance(num_peliculas, int) or num_peliculas < 1 or extension not in {"0","1","2","3","4"}:
        raise ValueError("positive movie count and extension 0..4 required")
    rng = random.Random(seed)
    with open(output_file, "w") as file:
        file.write(f"(define (problem redflix) (:domain practica_Redflix_{extension if extension in '1234' else 'base'})\n")
        file.write("(:objects \n")

        # Generar películas
        peliculas = [f"p{i}" for i in range(1, num_peliculas + 1)]
        file.write(" ".join(peliculas) + " - pelicula\n")

        # Generar universos y días
        universos = [f"universo{i}" for i in range(1, 5)]
        dias = [f"d{i}" for i in range(1, num_peliculas + 1)]
        file.write(" ".join(universos) + " - universo\n")
        file.write(" ".join(dias) + " - dia\n")
        if extension in "34":
            file.write("d0 - dia_previo\n\n")

        file.write(")\n\n(:init\n")
        if num_peliculas > 3:
            cont = rng.randint(num_peliculas//4,num_peliculas//2)
        else:
            cont = rng.randint(1,num_peliculas)
        file.write(f"    (= (ContPorVer) {cont})\n")

        if extension in "34":
            for dia in dias:
                file.write(f"    (= (ContDia {dia}) 0)\n")
        
        if extension in "012":
            file.write(f"    (diaActual d1)\n")
        
        # Relaciones de días consecutivos
        for i in range(len(dias) - 1):
            file.write(f"    (siguienteDia {dias[i]} {dias[i + 1]})\n")
        
        if extension in "34":
            # Inicializar contadores de diaAnterior
            for c in range(len(dias)):
                for p in range(c,len(dias)):
                    file.write(f"    (diaAnterior d{c} d{p+1}) \n")  

            for dia in dias:
                file.write(f"    (mismoDia {dia} {dia})\n")
        
        if extension == "2":
            # Inicializar contadores de diaAnterior (extension 2)
            for c in range(len(dias)-1):
                for p in range(c+1,len(dias)):
                    file.write(f"    (diaAnterior d{c+1} d{p+1}) \n")  

            for dia in dias:
                file.write(f"    (mismoDia {dia} {dia})\n")        
        
        # Relación de películas con catálogo
        for pelicula in peliculas:
            file.write(f"    (EnCatalogo {pelicula})\n")

        # Películas que el usuario quiere ver (aleatorias)
        querer_ver = rng.sample(peliculas, cont)
        for pelicula in querer_ver:
            file.write(f"    (quererVer {pelicula})\n")

        # Relación de predecesores (basico)
        if extension == "0":
            
            universos_posibles = set(universos)
            # Track contents that have been assigned as successors
            contenidos_sucesores = set()
            # Track contents that have been assigned as predecessors
            contenidos_predecesores_usados = set()
            # Track universes of contents with predecessors
            pelicula_a_universo = {}

            sin_predecesor = set(peliculas)
                 
            for i in range(len(peliculas)//2):
                if universos_posibles:
                    # Find available successors (not yet assigned and not in contenidos_sucesores)
                    available_sucesores = [p for p in peliculas[i+1:] 
                                            if p not in contenidos_sucesores]
                    
                    if available_sucesores:
                        sucesor = rng.choice(available_sucesores)
                        
                        # Choose an unused universe or a less-used universe
                        universo_candidatos = sorted(universos_posibles)
                        
                        
                        universo = rng.choice(universo_candidatos)
                        
                        # Update tracking
                        predecesor = peliculas[i]
                        contenidos_sucesores.add(sucesor)
                        contenidos_predecesores_usados.add(predecesor)
                        pelicula_a_universo[sucesor] = universo
                        pelicula_a_universo[predecesor] = universo
                        universos_posibles.discard(universo)
                        sin_predecesor.discard(sucesor)
                        
                        # Write predecesor relationship
                        file.write(f"    (predecesor {predecesor} {sucesor} {universo})\n")
        
        # Relación de predecesores (1234)
        if extension in "1234":
            # Inicializar universos_posibles desde la lista original de universos
            universos_posibles = set(universos)  # Asegurarnos de que esto se inicializa siempre
            pelicula_a_universo = {}
            sin_predecesor = set(peliculas)  # Inicializamos todas las películas como sin predecesor
            contenidos_predecesores_usados = set()

            for pelicula in peliculas:
                if universos_posibles:
                    universo = rng.choice(sorted(universos_posibles))
                    pelicula_a_universo[pelicula] = universo
                    universos_posibles.discard(universo)
                else:
                    # Si no hay universos disponibles, reiniciar la lista de universos
                    universos_posibles = set(universos)
                    universo = rng.choice(sorted(universos_posibles))
                    pelicula_a_universo[pelicula] = universo
                    universos_posibles.discard(universo)

            # Generar relaciones de predecesores dentro de los universos
            relaciones_generadas = set()  # Para evitar duplicados
            for universo in universos:
                peliculas_en_universo = [p for p in peliculas if pelicula_a_universo[p] == universo]
                
                if len(peliculas_en_universo) > 1:
                    # Asignar predecesores dentro del universo
                    for i in range(len(peliculas_en_universo) - 1):
                        predecesor = peliculas_en_universo[i]
                        sucesor = peliculas_en_universo[i + 1]

                        if (predecesor, sucesor, universo) not in relaciones_generadas:
                            file.write(f"    (predecesor {predecesor} {sucesor} {universo})\n")
                            relaciones_generadas.add((predecesor, sucesor, universo))
                            contenidos_predecesores_usados.add(predecesor)

                            # Actualizar el conjunto de películas sin predecesor
                            sin_predecesor.discard(sucesor)

        if extension in "01":
            no_pred = []        
            for i in sorted(sin_predecesor):  
                if i in contenidos_predecesores_usados:
                    universo = pelicula_a_universo[i]
                    file.write(f"    (ContInicial {i} {universo})\n")
                else:
                    no_pred.append(i)
            for el in no_pred:
                file.write(f"    (sinPredecesor {el})\n")
        elif extension == "2":
        # Definir contenidos sin predecesor
            for pelicula in sorted(sin_predecesor):
                file.write(f"    (sinPredecesor {pelicula})\n")
        
        if extension in "234":
            paralelos_usados = set()
            for _ in range(0, num_peliculas, 12):
                # Different universes cannot share a predecessor chain.
                pairs = [(a,b) for i,a in enumerate(peliculas)
                         for b in peliculas[i+1:]
                         if a not in paralelos_usados and b not in paralelos_usados
                         and pelicula_a_universo[a] != pelicula_a_universo[b]]
                if not pairs:
                    break
                a,b = rng.choice(pairs)
                file.write(f"    (paralelo {a} {b})\n")
                paralelos_usados.update([a,b])

            if extension == "2":
                for i in range(1, num_peliculas + 1):
                    pelicula_actual = f"p{i}"
                    if pelicula_actual not in paralelos_usados:
                        file.write(f"    (sinParalelo {pelicula_actual})\n")
                        
        if extension ==  "4":
            # Duraciones de contenidos
            file.write("\n    ;; Duraciones de los contenidos\n")
            for pelicula in peliculas:
                duracion = rng.randint(50, 100)
                file.write(f"    (= (duracion {pelicula}) {duracion})\n")
            for dia in dias:  
                file.write(f"    (= (MinPorDia {dia})0)\n")

        file.write(")\n\n(:goal\n    (and (= (ContPorVer) 0))\n)\n\n")
        file.write(")")


if __name__ == '__main__':
    import argparse
    parser = argparse.ArgumentParser(description='Generate a seeded Redflix PDDL instance')
    parser.add_argument('--movies', type=int, default=12)
    parser.add_argument('--extension', choices=list('01234'), default='4')
    parser.add_argument('--seed', type=int, default=42)
    parser.add_argument('--output', default='problem_redflix.pddl')
    args = parser.parse_args()
    generate_pddl_problem(args.movies,args.extension,args.output,args.seed)
    print(args.output)
