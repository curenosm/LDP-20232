;; Miembros del equipo:
;;  - Cureño Sanchez Misael, 418002485
;;  - López Carrillo Alan Ignacio, 420014760
;;  - Gonzalez Ivette
;;  - Reyes López Eduardo Alfonso, 420003681

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#lang racket

;; Ejercicio 1: Determina el area total de un cono circular recto, dado su
;; diámetro y generatriz.
(define (area-total g d)
    (+ (* pi (/ d 2) g) (* pi (/ d 2) (/ d 2))))


;; Ejercicio 2: Dados cuatro números indica si se encuentran otrdenados de
;; forma decremental.
(define (decremental? n1 n2 n3 n4)
  (if(and (>= n1 n2) (>= n2 n3) (>= n3 n4)) #t #f))


;; Ejercicio 3:Definir la función multiplica que dada una lista, multiplica todos los elementos
;; contenidos en la misma.

(define (multiplica lst)
  (if (empty? lst)
      1
      (* (car lst) (multiplica (cdr lst)))))



;; Ejercicio 4: Definir la función area-heron que calcula el área de un triángulo a partir de
;; la medida de cada uno de sus lados.

;; Función auxiliar para calcular S
(define (calcula-S a b c)
  (/ (+ a b c) 2))

(define(area-heron a b c)
  (sqrt (*(*(calcula-S a b c)(-(calcula-S a b c)a))(*(-(calcula-S a b c)b)(-(calcula-S a b c)c)))))


;; Ejercicio 5: Determina si todos los elementos de una lista son pares.
(define (pares? lst)
    (if (empty? lst)
        #t
        (and (eq? (remainder (car lst) 2) 0) (pares? (cdr lst)))))


;; Ejercicio 6: Definir la función collatz que dado un número entero positivo, da como 
;; resultado una lista con todos los resultados intermedios de la conjetura,
;; incluyendo el número de inicio.
(define (collatz n)
    (if (= n 1)
        (list 1)
        (if (= (modulo n 2) 0)
            (cons n (collatz (/ n 2)) )
            (cons n (collatz (add1 (* 3 n))))
        )
    )
)


;; Ejercicio 7: Definir la función (rombo n) que dado un número, construya una cadena 
;; que dibuje un rombo con dicho número de dígitos. El número deberá estar entre 1 y 10.
;; El rombo debe construirse con especificadores de formato como \n o \t y debe poderse mostrar con 
;; la función display.
(define (renglon i)
    (if (= i 1)
        "0"
        (string-append
            (number->string (- i 1))
            (renglon (- i 1))
            (number->string (- i 1))
        )
    )
)

;; Funcion auxiliar para dibujar una piramide ya sea sobre su base o invertida
(define (piramide i n dir cur)
    (define spaces
        (if (= dir 1)
            (make-string (abs (- n i)) #\space )
            (make-string (add1 (abs (- n i))) #\space )
        )
    )
    (define cur-string (string-append cur spaces (renglon i) "\n"))
    (if (= 1 dir)
        (if (= i n)
            cur-string
            (piramide (+ i dir) n dir cur-string)
        )
        (if (= 1 i)
            cur-string
            (piramide (+ i dir) n dir cur-string)
        )
    )
)

;; Funcion principal del ejercicio 7
(define (rombo n)
    (if (= n 1)
        (piramide 1 n 1 "")
        (string-append
            (piramide 1 n 1 "")
            (piramide (- n 1) (- n 1) -1 "")
        )
    )
)


;; EJERCICIO 8 Definir la función binarios que dada una lista de números enteros, regresa la 
;;representación binaria en cadena de cada uno de los números.

;; Función auxiliar para calcular el binario de un num
;; Usando la funcion predefinida de racket append para concatenar
;; elemento creamos un string para almacenar el resultado

(define (decimal-a-binario n)
  (local [(define (db-calc x)
       (cond [(zero? x) ""]
             [(even? x) (string-append "0" (db-calc (/ x 2)))]
             [else (string-append "1" (db-calc (/ (- x 1) 2)))]))]
(db-calc n)))

(define (binarios lst)
    (map decimal-a-binario lst))



;; Ejercicio 9: Filtra los elementos de la lista, para que sólo queden primos.
(define (primos lst)
    (filter prime? lst))

;; Función que determina si un número es primo.
(define (prime? num)
    (if (eq? num 1)
        #f
    (prime-helper num (- num 1)))
    )

;; Función recursiva que va dividiendo entre todos los números menores a n,
;; para determinar si es primo.
(define (prime-helper num x)
    (if (eq? 1 x)
        #t
        (and (not (eq? (remainder num x) 0)) (prime-helper num (- x 1)))
        )
    )


;; Ejercicio 10: Definir la función recursiva (entierra s n) que dado un símbolo lo entierra 
;; n número de veces. Es decir, se deberán anidar n−1 listas hasta que se llegue a la lista
;; que tiene como único elemento al símbolo correspondiente.
(define (entierra word n)
    (if (= n 0)
        word
        (entierra (list word) (sub1 n))
    )
)


;; Ejercicio 11: Función son-triangulos que recibe una lista de tripletas, 
;; donde cada una de estas representan a un triángulo definido por las medidas 
;; de sus lados, y regresa una lista donde especifica si cada uno de ellos se 
;; trata de un triángulo equilátero, isósceles o si "no es el caso".
(define (son-triangulos lst)
  (define lst1-e1 (car (car (cdr (car lst)))))
  (define lst1-e2 (list-ref (car (cdr (car lst))) 1))
  (define lst1-e3 (list-ref (car (cdr (car lst))) 2))
  (define lst2-e1 (car (car (cdr (car (cdr lst))))))
  (define lst2-e2 (list-ref (car (cdr (car (cdr lst)))) 1))
  (define lst2-e3 (list-ref (car (cdr (car (cdr lst)))) 2))
  (define lst3-e1 (list-ref (car (cdr (list-ref lst 2))) 0))
  (define lst3-e2 (list-ref (car (cdr (list-ref lst 2))) 1))
  (define lst3-e3 (list-ref (car (cdr (list-ref lst 2))) 2))
  (define lista (list '()))
  (if(= lst1-e1 lst1-e2 lst1-e3)
     (set! lista (append lista (list "equilátero")))
     (cond 
       [(= lst1-e1 lst1-e2) (set! lista (append lista (list "isóceles")))] 
       [(= lst1-e1 lst1-e3) (set! lista (append lista (list "isóceles")))]
       [(= lst1-e2 lst1-e3) (set! lista (append lista (list "isóceles")))]
       [else (set! lista (append lista (list "no es el caso")))]))
  (if(= lst2-e1 lst2-e2 lst2-e3)
     (set! lista (append lista (list "equilátero")))
     (cond 
       [(= lst2-e1 lst2-e2) (set! lista (append lista (list "isóceles")))] 
       [(= lst2-e1 lst2-e3) (set! lista (append lista (list "isóceles")))]
       [(= lst2-e2 lst2-e3) (set! lista (append lista (list "isóceles")))]
       [else (set! lista (append lista (list "no es el caso")))]))
  (if(= lst3-e1 lst3-e2 lst3-e3)
     (set! lista (append lista (list "equilátero")))
     (cond 
       [(= lst3-e1 lst3-e2) (set! lista (append lista (list "isóceles")))] 
       [(= lst3-e1 lst3-e3) (set! lista (append lista (list "isóceles")))]
       [(= lst3-e2 lst3-e3) (set! lista (append lista (list "isóceles")))]
       [else (set! lista (append lista (list "no es el caso")))]))
  lista)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
