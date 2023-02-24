# Lenguajes de Programación - Tarea 1

# Integrantes 

| **Nombre**  | **No. de cuenta**  |
|---|---|
|  *Cureño Sánchez Misael* |  418002485 |
|  *González Mancera Ivette* |  316014490 |

<br>

---

<br>

## Ejercicios

<br>

1. Dadas las siguientes expresiones en la gramática WAE dispuesta en sintaxis concreta, da la respectiva representación utilizando sintaxis abstracta por medio de los Árboles de Sintaxis Abstracta (ASA) correspondientes. En caso de no poder generar el árbol, justifica.

    - **a)**
    
    <br>

    ```lisp
    {- 25 {+ 17 {+ 4 5}}}
    ```
    
    - **b)**
    
    <br>

    ```lisp
    {- {+ 30 {+ 44}}}
    ```

    - **c)**
    
    <br>

    ```ml
    {with {x 4}
        {with {y {- x x}}
            {+ x {- y 9}}}
    ```

    <br>
    
2. Dadas las siguientes expresiones en la gramática WAE dispuesta en sintaxis concreta, da la sintaxis abstracta correspondiente y realiza la sustitución que se indica.

    - **a)** `e = {+ a {+ b {- 32 57}}}` <br>
        `(subst (parse e) 'a (add (num 3) (num 4)))`

    - **b)** `e = {with {y {- 30 {- y z}}} {- 30 {+ y z}}}` <br>
        `(subst (parse e) 'y (id 'w))`

    - **c)** `e = {with {y {- 30 {- y z}}} {- 30 {+ y z}}}` <br>
        `(subst (parse e) 'z (id 'v))`


3. Sea la siguiente expresión definida usando lenguaje WAE. Da la sintaxis abstracta esta expresión. Muestra el proceso de evaluación mediante la función interp y responde las siguientes preguntas.
<br>

    ```ml
    {with {a 3}
        {with {b 9}
            {with {c 4}
                {with {d 11}
                    {+ a {+ b {+ c d}}}
                }
            }
        }
    }
    ```

- ¿Cuántas veces se aplica el algoritmo de sustitución para evaluar esta expresión?

<br>

4. Convierte las siguientes expresiones usando la notación de índices de De Bruijn.

- **a)**

    <br/>

    ```ml
    {with {v 2}
        {with {w 3}
            {with {x 4}
                {with {y {+ v {- w x} } }
                    {with {z {with {v {+ w x}} v } }
                        {+ y {with {w {- y z}} {- w x}}}
                    }
                }
            }
        }
    }
    ```

<br>

5. Dadas las siguientes expresiones representadas mediante índices de De Bruijn, obtén su respectiva versión usando los nombres de los identificadores de variables, iniciando por "x", ” y ”, "z", "v", "w".

    ```ml
    {with {1 2 3}
        {with {4 5 6}
            {with {
                {with {{+ <:0 1> <:1 2>} {- <:1 1> <:0 0>}} 3}}
                    {with {<: 0 0>}
                        {+ <:3 2> {+ <:2 1> {+ <:1 0> <:0 0>}}
                    }
                }
            }
        }
    }
    ```

<br>

6. Dada la siguiente expresión.

    ```ml
    {with {w 2}
        {with {x 3}
            {with {y {+ w x }}
                {with { w -2}
                    {with {x -3 } {+ y y} }
                }
            }
        }
    }
    ```

<br>

- Evalúa la expresión expresión. Muestra los pasos que se deben de hacer en cada una de sus derivaciones intermedias.
- ¿Pueden haber otros resultados? ¿Por qué?
- ¿Cuál es el resultado correcto en dado caso de haber más de un posible resultado? ¿Por qué?

<br>

---

## Referencias

<br>

- Maurer, W.D. (1972) Introduction to Programming Science-Part I: Syntax and Semantics of Programming Languages; EECS Department, University of California, Berkeley (http://www2.eecs.berkeley.edu/Pubs/TechRpts/1972/28726.html)

- Buschman Frank (1996) Pattern-Oriented Software Architecture Volume 1: A System of Patterns, Wiley (https://www.amazon.com/Pattern-Oriented-Software-Architecture-System-Patterns/dp/0471958697)