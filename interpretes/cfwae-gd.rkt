#lang plai

;; Sintaxis Concreta
;; Lenguaje CFWAE
;; Versión Glotona con Alcance Dinámico
;; <expr> ::= <id>
;;          | <num>
;;          | {+ <expr> <expr>}
;;          | {- <expr> <expr>}
;;          | {* <expr> <expr>}
;;          | {if0 <expr> <expr> <expr>}
;;          | {with {<id> <expr>} <expr>}
;;          | {fun {<id>} <expr>}
;;          | {<expr> <expr>}

;; Sintaxis abstracta
(define-type ASA
  [id (i symbol?)]
  [num (n number?)]
  [add (i ASA?) (d ASA?)]
  [sub (i ASA?) (d ASA?)]
  [plus (i ASA?) (d ASA?)]
  [if0 (cond-expr ASA?) (then-expr ASA?) (else-expr ASA?)]
  [fun (param symbol?) (body ASA?)]
  [app (fun-expr ASA?) (arg ASA?)])

;; Ambientes de evaluación.
;; Almacenan parejas (id,valor)
(define-type Env
  [mtSub]
  [aSub (id symbol?) (value ASA?) (rest-env Env?)])


;; lookup symbol Env -> ASA
;; Búsqueda de un id en el ambiente.
(define (lookup sub-id env)
  (match env
    [(mtSub) (error 'lookup "Variable libre")]
    [(aSub i v r)
        (if (equal? i sub-id)
            v
            (lookup sub-id r))]))

;; interp: ASA -> ASA
;; Intérprete para CFAE, toma una expresión en sintaxis abstracta y nos devuelve el resultado de
;; evaluar dicha expresión.
(define (interp expr env)
  (match expr
    [(id i) 
      (lookup i env)]
    [(num n) 
      (num n)]
    [(add i d) 
      (num (+ (num-n (interp i env)) (num-n (interp d env))))]
    [(sub i d) 
      (num (- (num-n (interp i env)) (num-n (interp d env))))]
    [(plus i d) 
      (num (* (num-n (interp i env)) (num-n (interp d env))))]
    [(if0 cond-expr then-expr else-expr)
      (if (zero? (num-n (interp cond-expr env)))
          (interp then-expr env)
          (interp else-expr env))]
    [(fun p b) 
      (fun p b)]
    [(app f a)
        (let ([fun-val (interp f env)])
          (interp (fun-body fun-val)
                  (aSub (fun-param fun-val) (interp a env) env)))]))

;; Prueba
;; {with {f {fun {n} {if0 n 1 {* n {f {- n 1}}}}}}
;;    {f 5}}
;; Debe dar 120 (Lo hace por el alcance dinámico)
(define expr 
  (app (fun 'f (app (id 'f) (num 5)))
       (fun 'n (if0 (id 'n) (num 1) (plus (id 'n) (app (id 'f) (sub (id 'n) (num 1))))))))
