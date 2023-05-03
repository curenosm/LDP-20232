#lang plai

;;Definición del lenguaje WAE


;;Definición tipo Binding
(define-type Binding
  [binding (id symbol?) (value WAE?)])

;;Tipo WAE
(define-type WAE
  [id (i symbol?)]
  [num (n number?)]
  [op (f procedure?) (args (listof WAE?))]
  [with (bindings (listof binding?)) (body WAE?)]
  [with* (bindings (listof binding?)) (body WAE?)])

;; Parse :: s-expression -> WAE
(define (parse sexp)
  (cond
    [(symbol? sexp) (id sexp)]
    [(number? sexp) (num sexp)]
    [(list? sexp)
     [(empty? sexp) (error "lista vacia")]
     [case (car sexp) ;;Ahora, fijemonos en el primer elemento de la lista (sexp)
       [(+)
        (if  (> (length sexp) 2)
             (op + (map (lambda (x) (parse x)) (cdr sexp)))
             (error "Operador binario; se necesitan al menos dos argumentos."))] ;;Chequen esto
       ;;[(+) (op + (map parse (cdr sexp)))]                ;;chequen esto tambien
       ;;Aqui va el esto de su código con respecto a los demás operadores.
       ;;Terminen parseo de with
       [(with) (with (map parse-binding (second sexp)) (parse (third sexp)))]
       [(with*) (with* (map parse-binding (second sexp)) (parse (third sexp)))]
       ]
     
     ]
    ))

(define (parse-binding sexp)
  (binding (first sexp) (parse (second sexp))))

;;;;;;
;;; (+ 1 2)  <- (op + (list (num 1)(num 2 )))
;;; ( * 1 2 3 4) 
;;; (* 2) <- aridad incorrecta