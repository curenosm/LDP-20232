# Practica 1 - Puntos extra

- **(+ 2 pts)** Investiga quién es *Bárbara Liskov* e indica sus contribuciones al diseño 
de lenguajes de programación, principalmente relacionados con la abstracción de datos. Escribe un ensayo de mínimo una cuartilla donde describas quién es *Barbara Liskov*, qué es la abstracción, qué utilidad tiene la abstracción en las ciencias de la computación, qué utilidad tiene la abstracción en los lenguajes de programación y ejemplifica con aplicaciones. Tu ensayo debe contener introducción, desarrollo, conclusiones, bibliografía y debe estar debidamente citado. Este debe estar hecho a mano.


<br><br>


## Introducción
---

<br><br>



## Desarrollo
---

<br><br>


## Conclusiones
---

<br><br>

## Bibliografía
---

<br><br>

---

<br><br>

- **(+1 pt)** Dada una lista de números enteros, definir una función que devuelve la mayor de las
sumas de las sublistas de la misma. En este caso, las sublistas de una lista son todas las listas
no vacías de elementos consecutivos de la lista original. Para la entrega de este punto extra, deberán mandar su archivo *.rkt* a mi correo. <br>

    Por ejemplo: 
    <br>

    ```scheme
    (define (sublistas lista)
        (if (empty? lista)
            lista
            (append 
                lista 
                (sublistas (subseq 0))
            )
        )
    )

    (define (max-sumas lista)
        (define cur-val (car lista) )
        (define next-call (max-sumas (cdr lista)) )
        (if (empty? lista)
            0
            (if (= (count lista) 1)
                (car lista)
                (if (> cur-val next-call)
                    cur-val
                    next-call
                )
            )
        )
    )
    ```

    ```lisp
    > (sublistas ’(1 7 2 9))
    ((1) (7) (2) (9) (1 7) (7 2) (2 9) (1 7 2) (7 2 9) (1 7 2 9))
    ```

    ```lisp
    > (max-sumas ’(1 7 2 9))
    19
    ```