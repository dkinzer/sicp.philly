; Exercise 1.1 :
; Below is a sequence of expressions. 
; What is the result printed by the interpreter in response to each expression?
; Assume that the sequence is to be evaluated in the order in which it is presented.

(define assert
  (lambda (a m)
    (if a 
      (display (string  "PASSED: " m "\n"))
      (display (string   "FAILED: " m "\n")))))

(assert (= 10 10)
        "Numbers evaluate to numbers.")

(assert (= 12 (+ 5 3 4))
        "The + operator adds the operands.")

(assert (= 8 (- 9 1))
        "The - operator subtracts the rest of the operands from the first.")

(assert (= 3 (/ 6 2))
        "The / operator divides the first operand by rest of the operands.") 

(assert (= 8 (+ 2 (* 2 4) (- 4 6)))
        "S-expressions can contain sub-expressions.") 

(define a 3) ; a

(define b (+ a 1)) ; b

(assert (= 19 (+ a b (* a b)))
        "Defined symbols evaluate to their respective values.") 

(assert (not (= a b))
        "a is not equal to b.") 

(assert (= 4 (if (and (> b a) (< b (* a b)))
               b
               a))
        "The if form chooses.") 

(assert (= 16 (cond ((= a 4) 6)
            ((= b 4) (+ 6 7 a))
            (else 25)))
        "The cond form is a more general chooser.")


(assert (= 6 (+ 2 (if (> b a) b a)))
        "An if form can be used as an operand.")  

(assert (= 16 (* (cond ((> a b) a)
         ((< a b) b)
         (else -1)) 4))
        "A cond form can be used as an operand.") 


; Exercise 1.2:
; Translate the following expression into prefix form.
; 5 + 1/2 + (2 - (3 - (6 + 1/3) )) / 3 * (2 - 6) (2 - 7)
(assert (= (/ 13 72)
           (/ (+ 5 (/ 1 2) (- 2 (- 3 (+ 6 (/ 1 3)))))
   (* 3 (- 2 6) (- 2 7))))
        "These nested expressions can get pretty Freaky.")

; Exercise 1.3.
; Define a procedure that takes three numbers as arguments and returns
; the sum of the squares of the two larger numbers.
(define exercise-1.3
  (lambda (x y z)
         (cond ((< x y z) (+ (* y y) (* z z)))
               ((< z y x) (+ (* x x) (* y y)))
               (else (+ (* x x) (* z z))))))

(assert (= 13 (exercise-1.3 1 2 3))
        "Exercise-1.3 works when the last 2 operands are greater.")

(assert (= 13 (exercise-1.3 3 2 1))
        "Exercise-1.3 works when the first 2 operands are greater.")

(assert (= 13 (exercise-1.3 3 1 2))
        "Exercise-1.3 works when the exterior operands are greater.")
