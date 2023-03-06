#lang racket

;; Nombre: Misael Cureño Sanchez
;; No. de cuenta: 418002485

(define (mes n)
  (if (= n 1)
      "Enero"
      (if (= n 2)
          "Febrero"
          (if (= n 3)
              "Marzo"
              (if (= n 4)
                  "Abril"
                  (if (= n 5)
                      "Mayo"
                      (if (= n 6)
                          "Junio"
                          (if (= n 7)
                              "Julio"
                              (if (= n 8)
                                  "Agosto"
                                  (if (= n 9)
                                      "Septiembre"
                                      (if (= n 10)
                                          "Octubre"
                                          (if (= n 11)
                                              "Noviembre"
                                              (if (= n 12)
                                                  "Diciembre"
                                                  "Valor invalido"
                                              )
                                          )
                                      )
                                  )
                              )
                          )
                      )
                  )
              )
          )
      )
   )
)