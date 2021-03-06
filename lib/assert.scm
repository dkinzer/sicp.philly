(declare (usual-integrations))

;;; @file
;;; assert.scm
;;; Testing and analysis type functions go here.

(define (running-in-term?)
  (if (environment-bound?
        (nearest-repl/environment)
        'running-in-term)
    running-in-term
    #f))

(define (term-display a)
  ; I need a way stop display when not running via term.
  (if (running-in-term?)
    ((lambda ()
       (newline)
       (display a)))
    ()))

(define (my/pp a)
  (with-output-to-string
    (lambda () (pp a))))

(define (assert a #!optional m)
  (if (list? a)
    (assert (eval a (nearest-repl/environment)) (my/pp a))
    (if a
      (term-display (string "\n" "PASSED: " m "\n"))
      (term-display (string "\n" "FAILED: " m "\n")))))

(define (restart-if-error thunk)
  ; This code handles conditions that arise while executing thunk
  ; by invoking a restart.
  (bind-condition-handler
    '() ; All conditions
    (lambda (condition)
      (invoke-restart (find-restart 'assert-restart) (condition/report-string condition)))
    thunk))

(define (assert-error expected-error thunk #!optional a-message)
  ; This code provides a way of handling errors: the ASSERT-ERROR restart.
  ; Invokes the assert message by checking expected against actual error message.
  (restart-if-error
    (lambda ()
      (call-with-current-continuation
        (lambda (kappa)
          (with-restart
            ; Name
            'assert-restart
            ;  Reporter
            "This restart is named assert-restart"
            ; Effector
            (lambda (message)
              (assert (substring? expected-error message)
                      (string-append "\"" expected-error "\" error was thrown.\n"
                                     "Actual error was: " message "\n"
                                     a-message))
              (kappa #f))
            ; No Interactor.
            #f
            ; A reconfigured thunk.
            (lambda ()
              (thunk)
              (error "NO ERROR"))))))))

(define time
  ; Use (time f) to analyse how long procedures take.
  ; f is an unevaluated expression. run-time gc-time
  ; & real-time are written to output and returned as a list.
  (lambda (f)
    (with-timings
      f
      (lambda (run-time gc-time real-time)
      (newline)
      (term-display run-time)
      (term-display #\space)
      (term-display gc-time)
      (term-display #\space)
      (term-display real-time)
      (newline)
      (list run-time gc-time real-time)))))
