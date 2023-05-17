#lang plai

(define (suma-pares n)
    (if (zero? n)
        0
        (+ (* 2 n) (suma-pares (- n 1)))))

(define (suma-pares-c n)
    (suma-pares-cps n (lambda (x) x)))

(define (suma-pares-cps n k)
    (if (zero? n)
        (k n)
        (suma-pares-cps
            (sub1 n)
            (lambda (v) 
                (k (+ (* 2 n) v))))))