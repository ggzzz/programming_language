
#lang racket

(provide (all-defined-out)) ;; so we can put tests in a second file

;; put your code below
(define (sequence low high stride)
  (if (> low high)
      '()
      (cons low (sequence (+ low stride) high stride))))

(define (string-append-map xs suffix)
  (map (lambda (e) (string-append e suffix)) xs))

(define (list-nth-mod xs n)
  (cond ((< n 0) (error "list-nth-mod: negative number"))
        ((null? xs) (error "list-nth-mod: empty list"))
        ((car (list-tail xs (remainder n (length xs)))))))

(define (stream-for-n-steps s n)
  (if (= n 0)
      '()
      (cons (car (s)) (stream-for-n-steps (cdr (s)) (- n 1))))) 

(define funny-number-stream (letrec ((f (lambda (x)
                                          (if (= (remainder x 5) 0)
                                              (cons (- x) (lambda () (f (+ x 1))))
                                              (cons x (lambda () (f (+ x 1))))))))
                              (lambda () (f 1))))

(define dan-then-dog (letrec ((f (lambda (x)
                                   (if (string=? x "dan.jpg")
                                       (cons "dan.jpg" (lambda ()(f "dog.jpg")))
                                       (cons "dog.jpg" (lambda ()(f "dan.jpg")))))))
                       (lambda () (f "dan.jpg"))))
                                   
(define (stream-add-zero s)
  (lambda () (cons (cons 0 (car (s))) (stream-add-zero (cdr (s))))))

(define (cycle-lists xs ys)
  (letrec ((f (lambda (n)
                (cons (cons (list-nth-mod xs n) (list-nth-mod ys n)) (lambda () (f (+ n 1)))))))
    (lambda () (f 0))))

(define (vector-assoc v vec)
  (letrec ((f (lambda (i)
                (if (= i (vector-length vec))
                    #f
                    (if (and (pair? (vector-ref vec i))
                             (equal? v (car (vector-ref vec i))))
                        (vector-ref vec i)
                        (f (+ i 1)))))))
    (f 0)))

(define (cached-assoc xs n)
  (let ((cache (make-vector n #f))
        (pos 0))
    (lambda (v)
      (if (vector-assoc v cache)
          (vector-assoc v cache)
          (if (assoc v xs)
              (begin (vector-set! cache pos (assoc v xs))
                     (if (= pos (- n 1))
                         (set! pos 0)
                         (set! pos (+ pos 1)))
                     (assoc v xs))
              #f)))))


      