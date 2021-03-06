; {{{1 2.2.1 Representing Sequences
; 
; {{{2 Exercise 2.17:
; {{{3 Problem
;      Define a procedure `last-pair' that returns the
;      list that contains only the last element of a given (nonempty)
;      list:
; 
;           (last-pair (list 23 72 149 34))
;           (34)
; 
; {{{3 Solution
; {{{2 Exercise 2.18:
; {{{3 Problem
;      Define a procedure `reverse' that takes a list as
;      argument and returns a list of the same elements in reverse order:
; 
;           (reverse (list 1 4 9 16 25))
;           (25 16 9 4 1)
; 
; {{{3 Solution
; {{{2 Exercise 2.19:
; {{{3 Problem
;      Consider the change-counting program of section
;      *Note 1-2-2::.  It would be nice to be able to easily change the
;      currency used by the program, so that we could compute the number
;      of ways to change a British pound, for example.  As the program is
;      written, the knowledge of the currency is distributed partly into
;      the procedure `first-denomination' and partly into the procedure
;      `count-change' (which knows that there are five kinds of U.S.
;      coins).  It would be nicer to be able to supply a list of coins to
;      be used for making change.
; 
;      We want to rewrite the procedure `cc' so that its second argument
;      is a list of the values of the coins to use rather than an integer
;      specifying which coins to use.  We could then have lists that
;      defined each kind of currency:
; 
;           (define us-coins (list 50 25 10 5 1))
; 
;           (define uk-coins (list 100 50 20 10 5 2 1 0.5))
; 
;      We could then call `cc' as follows:
; 
;           (cc 100 us-coins)
;           292
; 
;      To do this will require changing the program `cc' somewhat.  It
;      will still have the same form, but it will access its second
;      argument differently, as follows:
; 
;           (define (cc amount coin-values)
;             (cond ((= amount 0) 1)
;                   ((or (< amount 0) (no-more? coin-values)) 0)
;                   (else
;                    (+ (cc amount
;                           (except-first-denomination coin-values))
;                       (cc (- amount
;                              (first-denomination coin-values))
;                           coin-values)))))
; 
;      Define the procedures `first-denomination',
;      `except-first-denomination', and `no-more?' in terms of primitive
;      operations on list structures.  Does the order of the list
;      `coin-values' affect the answer produced by `cc'?  Why or why not?
; 
; {{{3 Solution
; {{{2 Exercise 2.20:
; {{{3 Problem
;      The procedures `+', `*', and `list' take
;      arbitrary numbers of arguments. One way to define such procedures
;      is to use `define' with notation "dotted-tail notation".  In a
;      procedure definition, a parameter list that has a dot before the
;      last parameter name indicates that, when the procedure is called,
;      the initial parameters (if any) will have as values the initial
;      arguments, as usual, but the final parameter's value will be a "list"
;      of any remaining arguments.  For instance, given the definition
; 
;           (define (f x y . z) <BODY>)
; 
;      the procedure `f' can be called with two or more arguments.  If we
;      evaluate
; 
;           (f 1 2 3 4 5 6)
; 
;      then in the body of `f', `x' will be 1, `y' will be 2, and `z'
;      will be the list `(3 4 5 6)'.  Given the definition
; 
;           (define (g . w) <BODY>)
; 
;      the procedure `g' can be called with zero or more arguments.  If we
;      evaluate
; 
;           (g 1 2 3 4 5 6)
; 
;      then in the body of `g', `w' will be the list `(1 2 3 4 5 6)'.(4)
; 
;      Use this notation to write a procedure `same-parity' that takes
;      one or more integers and returns a list of all the arguments that
;      have the same even-odd parity as the first argument.  For example,
; 
;           (same-parity 1 2 3 4 5 6 7)
;           (1 3 5 7)
; 
;           (same-parity 2 3 4 5 6 7)
;           (2 4 6)
; 
; {{{3 Solution
; {{{2 Exercise 2.21:
; {{{3 Problem
;      The procedure `square-list' takes a list of
;      numbers as argument and returns a list of the squares of those
;      numbers.
; 
;           (square-list (list 1 2 3 4))
;           (1 4 9 16)
; 
;      Here are two different definitions of `square-list'.  Complete
;      both of them by filling in the missing expressions:
; 
;           (define (square-list items)
;             (if (null? items)
;                 nil
;                 (cons <??> <??>)))
; 
;           (define (square-list items)
;             (map <??> <??>))
; 
; {{{3 Solution
; {{{2 Exercise 2.22:
; {{{3 Problem
;      Louis Reasoner tries to rewrite the first
;      `square-list' procedure of *Note Exercise 2-21:: so that it
;      evolves an iterative process:
; 
;           (define (square-list items)
;             (define (iter things answer)
;               (if (null? things)
;                   answer
;                   (iter (cdr things)
;                         (cons (square (car things))
;                               answer))))
;             (iter items nil))
; 
;      Unfortunately, defining `square-list' this way produces the answer
;      list in the reverse order of the one desired.  Why?
; 
;      Louis then tries to fix his bug by interchanging the arguments to
;      `cons':
; 
;           (define (square-list items)
;             (define (iter things answer)
;               (if (null? things)
;                   answer
;                   (iter (cdr things)
;                         (cons answer
;                               (square (car things))))))
;             (iter items nil))
; 
;      This doesn't work either.  Explain.
; 
; {{{3 Solution
; {{{2 Exercise 2.23:
; {{{3 Problem
;      The procedure `for-each' is similar to `map'.  It
;      takes as arguments a procedure and a list of elements.  However,
;      rather than forming a list of the results, `for-each' just applies
;      the procedure to each of the elements in turn, from left to right.
;      The values returned by applying the procedure to the elements are
;      not used at all--`for-each' is used with procedures that perform
;      an action, such as printing.  For example,
; 
;           (for-each (lambda (x) (newline) (display x))
;                     (list 57 321 88))
;           57
;           321
;           88
; 
;      The value returned by the call to `for-each' (not illustrated
;      above) can be something arbitrary, such as true.  Give an
;      implementation of `for-each'.
; 
; {{{3 Solution
; 
; {{{1 2.2.2 Hierarchical Structures
; 
; {{{2 Exercise 2.24:
; {{{3 Problem
;      Suppose we evaluate the expression `(list 1 (list
;      2 (list 3 4)))'.  Give the result printed by the interpreter, the
;      corresponding box-and-pointer structure, and the interpretation of
;      this as a tree (as in *Note Figure 2-6::).
; 
; {{{3 Solution
; {{{2 Exercise 2.25:
; {{{3 Problem
;      Give combinations of `car's and `cdr's that will
;      pick 7 from each of the following lists:
; 
;           (1 3 (5 7) 9)
; 
;           ((7))
; 
;           (1 (2 (3 (4 (5 (6 7))))))
; 
; {{{3 Solution
; {{{2 Exercise 2.26:
; {{{3 Problem
;      Suppose we define `x' and `y' to be two lists:
; 
;           (define x (list 1 2 3))
; 
;           (define y (list 4 5 6))
; 
;      What result is printed by the interpreter in response to
;      evaluating each of the following expressions:
; 
;           (append x y)
; 
;           (cons x y)
; 
;           (list x y)
; 
; {{{3 Solution
; {{{2 Exercise 2.27:
; {{{3 Problem
;      Modify your `reverse' procedure of *Note Exercise
;      2-18:: to produce a `deep-reverse' procedure that takes a list as
;      argument and returns as its value the list with its elements
;      reversed and with all sublists deep-reversed as well.  For example,
; 
;           (define x (list (list 1 2) (list 3 4)))
; 
;           x
;           ((1 2) (3 4))
; 
;           (reverse x)
;           ((3 4) (1 2))
; 
;           (deep-reverse x)
;           ((4 3) (2 1))
; 
; {{{3 Solution
; {{{2 Exercise 2.28:
; {{{3 Problem
;      Write a procedure `fringe' that takes as argument
;      a tree (represented as a list) and returns a list whose elements
;      are all the leaves of the tree arranged in left-to-right order.
;      For example,
; 
;           (define x (list (list 1 2) (list 3 4)))
; 
;           (fringe x)
;           (1 2 3 4)
; 
;           (fringe (list x x))
;           (1 2 3 4 1 2 3 4)
; 
; {{{3 Solution
; {{{2 Exercise 2.29:
; {{{3 Problem
;      A binary mobile consists of two branches, a left
;      branch and a right branch.  Each branch is a rod of a certain
;      length, from which hangs either a weight or another binary mobile.
;      We can represent a binary mobile using compound data by
;      constructing it from two branches (for example, using `list'):
; 
;           (define (make-mobile left right)
;             (list left right))
; 
;      A branch is constructed from a `length' (which must be a number)
;      together with a `structure', which may be either a number
;      (representing a simple weight) or another mobile:
; 
;           (define (make-branch length structure)
;             (list length structure))
; 
;        a. Write the corresponding selectors `left-branch' and
;           `right-branch', which return the branches of a mobile, and
;           `branch-length' and `branch-structure', which return the
;           components of a branch.
; 
;        b. Using your selectors, define a procedure `total-weight' that
;           returns the total weight of a mobile.
; 
;        c. A mobile is said to be "balanced" if the torque applied by
;           its top-left branch is equal to that applied by its top-right
;           branch (that is, if the length of the left rod multiplied by
;           the weight hanging from that rod is equal to the
;           corresponding product for the right side) and if each of the
;           submobiles hanging off its branches is balanced. Design a
;           predicate that tests whether a binary mobile is balanced.
; 
;        d. Suppose we change the representation of mobiles so that the
;           constructors are
; 
;                (define (make-mobile left right)
;                  (cons left right))
; 
;                (define (make-branch length structure)
;                  (cons length structure))
; 
;           How much do you need to change your programs to convert to
;           the new representation?
; 
; {{{3 Solution
; {{{2 Exercise 2.30:
; {{{3 Problem
;      Define a procedure `square-tree' analogous to the
;      `square-list' procedure of *Note Exercise 2-21::.  That is,
;      `square-list' should behave as follows:
; 
;           (square-tree
;            (list 1
;                  (list 2 (list 3 4) 5)
;                  (list 6 7)))
;           (1 (4 (9 16) 25) (36 49))
; 
;      Define `square-tree' both directly (i.e., without using any
;      higher-order procedures) and also by using `map' and recursion.
; 
; {{{3 Solution
; {{{2 Exercise 2.31:
; {{{3 Problem
;      Abstract your answer to *Note Exercise 2-30:: to
;      produce a procedure `tree-map' with the property that
;      `square-tree' could be defined as
; 
;           (define (square-tree tree) (tree-map square tree))
; 
; {{{3 Solution
; {{{2 Exercise 2.32:
; {{{3 Problem
;      We can represent a set as a list of distinct
;      elements, and we can represent the set of all subsets of the set as
;      a list of lists.  For example, if the set is `(1 2 3)', then the
;      set of all subsets is `(() (3) (2) (2 3) (1) (1 3) (1 2) (1 2
;      3))'.  Complete the following definition of a procedure that
;      generates the set of subsets of a set and give a clear explanation
;      of why it works:
; 
;           (define (subsets s)
;             (if (null? s)
;                 (list nil)
;                 (let ((rest (subsets (cdr s))))
;                   (append rest (map <??> rest)))))
; 
; {{{3 Solution
; 
; {{{1 2.2.3 Sequences as Conventional Interfaces
; 
; {{{2 Exercise 2.33:
; {{{3 Problem
;      Fill in the missing expressions to complete the
;      following definitions of some basic list-manipulation operations
;      as accumulations:
; 
;           (define (map p sequence)
;             (accumulate (lambda (x y) <??>) nil sequence))
; 
;           (define (append seq1 seq2)
;             (accumulate cons <??> <??>))
; 
;           (define (length sequence)
;             (accumulate <??> 0 sequence))
; 
; {{{3 Solution
; {{{2 Exercise 2.34:
; {{{3 Problem
;      Evaluating a polynomial in x at a given value of
;      x can be formulated as an accumulation.  We evaluate the polynomial
; 
;           a_n r^n | a_(n-1) r^(n-1) + ... + a_1 r + a_0
; 
;      using a well-known algorithm called "Horner's rule", which
;      structures the computation as
; 
;           (... (a_n r + a_(n-1)) r + ... + a_1) r + a_0
; 
;      In other words, we start with a_n, multiply by x, add a_(n-1),
;      multiply by x, and so on, until we reach a_0.(3)
; 
;      Fill in the following template to produce a procedure that
;      evaluates a polynomial using Horner's rule.  Assume that the
;      coefficients of the polynomial are arranged in a sequence, from
;      a_0 through a_n.
; 
;           (define (horner-eval x coefficient-sequence)
;             (accumulate (lambda (this-coeff higher-terms) <??>)
;                         0
;                         coefficient-sequence))
; 
;      For example, to compute 1 + 3x + 5x^3 + x^(5) at x = 2 you would
;      evaluate
; 
;           (horner-eval 2 (list 1 3 0 5 0 1))
; 
; {{{3 Solution
; {{{2 Exercise 2.35:
; {{{3 Problem
;      Redefine `count-leaves' from section *Note
;      2-2-2:: as an accumulation:
; 
;           (define (count-leaves t)
;             (accumulate <??> <??> (map <??> <??>)))
; 
; {{{3 Solution
; {{{2 Exercise 2.36:
; {{{3 Problem
;      The procedure `accumulate-n' is similar to
;      `accumulate' except that it takes as its third argument a sequence
;      of sequences, which are all assumed to have the same number of
;      elements.  It applies the designated accumulation procedure to
;      combine all the first elements of the sequences, all the second
;      elements of the sequences, and so on, and returns a sequence of
;      the results.  For instance, if `s' is a sequence containing four
;      sequences, `((1 2 3) (4 5 6) (7 8 9) (10 11 12)),' then the value
;      of `(accumulate-n + 0 s)' should be the sequence `(22 26 30)'.
;      Fill in the missing expressions in the following definition of
;      `accumulate-n':
; 
;           (define (accumulate-n op init seqs)
;             (if (null? (car seqs))
;                 nil
;                 (cons (accumulate op init <??>)
;                       (accumulate-n op init <??>))))
; 
; {{{2 Exercise 2.37
; 
; Suppose we represent vectors v = (v_i) as sequences of numbers, and
; matrices m = (m_(ij)) as sequences of vectors (the rows of the matrix).
; For example, the matrix
; 
;      +-         -+
;      |  1 2 3 4  |
;      |  4 5 6 6  |
;      |  6 7 8 9  |
;      +-         -+
; 
; is represented as the sequence `((1 2 3 4) (4 5 6 6) (6 7 8 9))'.  With
; this representation, we can use sequence operations to concisely
; express the basic matrix and vector operations.  These operations
; (which are described in any book on matrix algebra) are the following:
; 
;                                             __
;      (dot-product v w)      returns the sum >_i v_i w_i
; 
;      (matrix-*-vector m v)  returns the vector t,
;                                         __
;                             where t_i = >_j m_(ij) v_j
; 
;      (matrix-*-matrix m n)  returns the matrix p,
;                                            __
;                             where p_(ij) = >_k m_(ik) n_(kj)
; 
;      (transpose m)          returns the matrix n,
;                             where n_(ij) = m_(ji)
; 
;    We can define the dot product as(4)
; 
;      (define (dot-product v w)
;        (accumulate + 0 (map * v w)))
; 
;    Fill in the missing expressions in the following procedures for
; computing the other matrix operations.  (The procedure `accumulate-n'
; is defined in *Note Exercise 2-36::.)
; 
;      (define (matrix-*-vector m v)
;        (map <??> m))
; 
;      (define (transpose mat)
;        (accumulate-n <??> <??> mat))
; 
;      (define (matrix-*-matrix m n)
;        (let ((cols (transpose n)))
;          (map <??> m)))
; 
; {{{3 Solution
; {{{2 Exercise 2.38:
; {{{3 Problem
;      The `accumulate' procedure is also known as
;      `fold-right', because it combines the first element of the
;      sequence with the result of combining all the elements to the
;      right.  There is also a `fold-left', which is similar to
;      `fold-right', except that it combines elements working in the
;      opposite direction:
; 
;           (define (fold-left op initial sequence)
;             (define (iter result rest)
;               (if (null? rest)
;                   result
;                   (iter (op result (car rest))
;                         (cdr rest))))
;             (iter initial sequence))
; 
;      What are the values of
; 
;           (fold-right / 1 (list 1 2 3))
; 
;           (fold-left / 1 (list 1 2 3))
; 
;           (fold-right list nil (list 1 2 3))
; 
;           (fold-left list nil (list 1 2 3))
; 
;      Give a property that `op' should satisfy to guarantee that
;      `fold-right' and `fold-left' will produce the same values for any
;      sequence.
; 
; {{{3 Solution
; {{{2 Exercise 2.39:
; {{{3 Problem
;      Complete the following definitions of `reverse'
;      (*Note Exercise 2-18::) in terms of `fold-right' and `fold-left'
;      from *Note Exercise 2-38:::
; 
;           (define (reverse sequence)
;             (fold-right (lambda (x y) <??>) nil sequence))
; 
;           (define (reverse sequence)
;             (fold-left (lambda (x y) <??>) nil sequence))
; 
; {{{3 Solution
; {{{2 Exercise 2.40:
; {{{3 Problem
;      Define a procedure `unique-pairs' that, given an
;      integer n, generates the sequence of pairs (i,j) with 1 <= j< i <=
;      n.  Use `unique-pairs' to simplify the definition of
;      `prime-sum-pairs' given above.
; 
; {{{3 Solution
; {{{2 Exercise 2.41:
; {{{3 Problem
;      Write a procedure to find all ordered triples of
;      distinct positive integers i, j, and k less than or equal to a
;      given integer n that sum to a given integer s.
; 
;      *Figure 2.8:* A solution to the eight-queens puzzle.
; 
;           +---+---+---+---+---+---+---+---+
;           |   |   |   |   |   | Q |   |   |
;           +---+---+---+---+---+---+---+---+
;           |   |   | Q |   |   |   |   |   |
;           +---+---+---+---+---+---+---+---+
;           | Q |   |   |   |   |   |   |   |
;           +---+---+---+---+---+---+---+---+
;           |   |   |   |   |   |   | Q |   |
;           +---+---+---+---+---+---+---+---+
;           |   |   |   |   | Q |   |   |   |
;           +---+---+---+---+---+---+---+---+
;           |   |   |   |   |   |   |   | Q |
;           +---+---+---+---+---+---+---+---+
;           |   | Q |   |   |   |   |   |   |
;           +---+---+---+---+---+---+---+---+
;           |   |   |   | Q |   |   |   |   |
;           +---+---+---+---+---+---+---+---+
; 
; {{{3 Solution
; {{{2 Exercise 2.42:
; {{{3 Problem
;      The "eight-queens puzzle" asks how to place eight
;      queens on a chessboard so that no queen is in check from any other
;      (i.e., no two queens are in the same row, column, or diagonal).
;      One possible solution is shown in *Note Figure 2-8::.  One way to
;      solve the puzzle is to work across the board, placing a queen in
;      each column.  Once we have placed k - 1 queens, we must place the
;      kth queen in a position where it does not check any of the queens
;      already on the board.  We can formulate this approach recursively:
;      Assume that we have already generated the sequence of all possible
;      ways to place k - 1 queens in the first k - 1 columns of the
;      board.  For each of these ways, generate an extended set of
;      positions by placing a queen in each row of the kth column.  Now
;      filter these, keeping only the positions for which the queen in
;      the kth column is safe with respect to the other queens.  This
;      produces the sequence of all ways to place k queens in the first k
;      columns.  By continuing this process, we will produce not only one
;      solution, but all solutions to the puzzle.
; 
;      We implement this solution as a procedure `queens', which returns a
;      sequence of all solutions to the problem of placing n queens on an
;      n*n chessboard.  `Queens' has an internal procedure `queen-cols'
;      that returns the sequence of all ways to place queens in the first
;      k columns of the board.
; 
;           (define (queens board-size)
;             (define (queen-cols k)
;               (if (= k 0)
;                   (list empty-board)
;                   (filter
;                    (lambda (positions) (safe? k positions))
;                    (flatmap
;                     (lambda (rest-of-queens)
;                       (map (lambda (new-row)
;                              (adjoin-position new-row k rest-of-queens))
;                            (enumerate-interval 1 board-size)))
;                     (queen-cols (- k 1))))))
;             (queen-cols board-size))
; 
;      In this procedure `rest-of-queens' is a way to place k - 1 queens
;      in the first k - 1 columns, and `new-row' is a proposed row in
;      which to place the queen for the kth column.  Complete the program
;      by implementing the representation for sets of board positions,
;      including the procedure `adjoin-position', which adjoins a new
;      row-column position to a set of positions, and `empty-board',
;      which represents an empty set of positions.  You must also write
;      the procedure `safe?', which determines for a set of positions,
;      whether the queen in the kth column is safe with respect to the
;      others.  (Note that we need only check whether the new queen is
;      safe--the other queens are already guaranteed safe with respect to
;      each other.)
; 
; {{{3 Solution
; {{{2 Exercise 2.43:
; {{{3 Problem
;      Louis Reasoner is having a terrible time doing
;      *Note Exercise 2-42::.  His `queens' procedure seems to work, but
;      it runs extremely slowly.  (Louis never does manage to wait long
;      enough for it to solve even the 6*6 case.)  When Louis asks Eva Lu
;      Ator for help, she points out that he has interchanged the order
;      of the nested mappings in the `flatmap', writing it as
; 
;           (flatmap
;            (lambda (new-row)
;              (map (lambda (rest-of-queens)
;                     (adjoin-position new-row k rest-of-queens))
;                   (queen-cols (- k 1))))
;            (enumerate-interval 1 board-size))
; 
;      Explain why this interchange makes the program run slowly.
;      Estimate how long it will take Louis's program to solve the
;      eight-queens puzzle, assuming that the program in *Note Exercise
;      2-42:: solves the puzzle in time T.
; 
; {{{3 Solution
; 
; {{{1 2.2.4 Example: A Picture Language
; 
; {{{2 Exercise 2.44:
; {{{3 Problem
;      Define the procedure `up-split' used by
;      `corner-split'.  It is similar to `right-split', except that it
;      switches the roles of `below' and `beside'.
; 
; {{{3 Solution
; {{{2 Exercise 2.45:
; {{{3 Problem
;      `Right-split' and `up-split' can be expressed as
;      instances of a general splitting operation.  Define a procedure
;      `split' with the property that evaluating
; 
;           (define right-split (split beside below))
;           (define up-split (split below beside))
; 
;      produces procedures `right-split' and `up-split' with the same
;      behaviors as the ones already defined.
; 
; {{{3 Solution
; {{{2 Exercise 2.46:
; {{{3 Problem
;      A two-dimensional vector v running from the
;      origin to a point can be represented as a pair consisting of an
;      x-coordinate and a y-coordinate.  Implement a data abstraction for
;      vectors by giving a constructor `make-vect' and corresponding
;      selectors `xcor-vect' and `ycor-vect'.  In terms of your selectors
;      and constructor, implement procedures `add-vect', `sub-vect', and
;      `scale-vect' that perform the operations vector addition, vector
;      subtraction, and multiplying a vector by a scalar:
; 
;           (x_1, y_1) + (x_2, y_2) = (x_1 + x_2, y_1 + y_2)
;           (x_1, y_1) - (x_2, y_2) = (x_1 - x_2, y_1 - y_2)
;                        s * (x, y) = (sx, sy)
; 
; {{{3 Solution
; {{{2 Exercise 2.47:
; {{{3 Problem
;      Here are two possible constructors for frames:
; 
;           (define (make-frame origin edge1 edge2)
;             (list origin edge1 edge2))
; 
;           (define (make-frame origin edge1 edge2)
;             (cons origin (cons edge1 edge2)))
; 
;      For each constructor supply the appropriate selectors to produce an
;      implementation for frames.
; 
; {{{3 Solution
; {{{2 Exercise 2.48:
; {{{3 Problem
;      A directed line segment in the plane can be
;      represented as a pair of vectors--the vector running from the
;      origin to the start-point of the segment, and the vector running
;      from the origin to the end-point of the segment.  Use your vector
;      representation from *Note Exercise 2-46:: to define a
;      representation for segments with a constructor `make-segment' and
;      selectors `start-segment' and `end-segment'.
; 
; {{{3 Solution
; {{{2 Exercise 2.49:
; {{{3 Problem
;      Use `segments->painter' to define the following
;      primitive painters:
; 
;        a. The painter that draws the outline of the designated frame.
; 
;        b. The painter that draws an "X" by connecting opposite corners
;           of the frame.
; 
;        c. The painter that draws a diamond shape by connecting the
;           midpoints of the sides of the frame.
; 
;        d. The `wave' painter.
; 
; {{{3 Solution
; {{{2 Exercise 2.50:
; {{{3 Problem
;      Define the transformation `flip-horiz', which
;      flips painters horizontally, and transformations that rotate
;      painters counterclockwise by 180 degrees and 270 degrees.
; 
; {{{3 Solution
; {{{2 Exercise 2.51:
; {{{3 Problem
;      Define the `below' operation for painters.
;      `Below' takes two painters as arguments.  The resulting painter,
;      given a frame, draws with the first painter in the bottom of the
;      frame and with the second painter in the top.  Define `below' in
;      two different ways--first by writing a procedure that is analogous
;      to the `beside' procedure given above, and again in terms of
;      `beside' and suitable rotation operations (from *Note Exercise
;      2-50::).
; 
; {{{3 Solution
; {{{2 Exercise 2.52:
; {{{3 Problem
;      Make changes to the square limit of `wave' shown
;      in *Note Figure 2-9:: by working at each of the levels described
;      above.  In particular:
; 
;        a. Add some segments to the primitive `wave' painter of *Note
;           Exercise 2-49:: (to add a smile, for example).
; 
;        b. Change the pattern constructed by `corner-split' (for
;           example, by using only one copy of the `up-split' and
;           `right-split' images instead of two).
; 
;        c. Modify the version of `square-limit' that uses
;           `square-of-four' so as to assemble the corners in a different
;           pattern.  (For example, you might make the big Mr. Rogers
;           look outward from each corner of the square.)
; 
; {{{3 Solution
; 
; {{{1 2.3.1 Quotation
; 
; {{{2 Exercise 2.53:
; {{{3 Problem
;      What would the interpreter print in response to
;      evaluating each of the following expressions?
; 
;           (list 'a 'b 'c)
; 
;           (list (list 'george))
; 
;           (cdr '((x1 x2) (y1 y2)))
; 
;           (cadr '((x1 x2) (y1 y2)))
; 
;           (pair? (car '(a short list)))
; 
;           (memq 'red '((red shoes) (blue socks)))
; 
;           (memq 'red '(red shoes blue socks))
; 
; {{{3 Solution
; {{{2 Exercise 2.54:
; {{{3 Problem
;      Two lists are said to be `equal?' if they contain
;      equal elements arranged in the same order.  For example,
; 
;           (equal? '(this is a list) '(this is a list))
; 
;      is true, but
; 
;           (equal? '(this is a list) '(this (is a) list))
; 
;      is false.  To be more precise, we can define `equal?'  recursively
;      in terms of the basic `eq?' equality of symbols by saying that `a'
;      and `b' are `equal?' if they are both symbols and the symbols are
;      `eq?', or if they are both lists such that `(car a)' is `equal?'
;      to `(car b)' and `(cdr a)' is `equal?' to `(cdr b)'.  Using this
;      idea, implement `equal?' as a procedure.(5)
; 
; {{{3 Solution
; {{{2 Exercise 2.55:
; {{{3 Problem
;      Eva Lu Ator types to the interpreter the
;      expression
; 
;           (car ''abracadabra)
; 
;      To her surprise, the interpreter prints back `quote'.  Explain.
; 
; {{{3 Solution
; 
; {{{1 2.3.2 Example: Symbolic Differentiation
; 
; {{{2 Exercise 2.56:
; {{{3 Problem
;      Show how to extend the basic differentiator to
;      handle more kinds of expressions.  For instance, implement the
;      differentiation rule
; 
;           n_1   n_2
;           --- = ---  if and only if n_1 d_2 = n_2 d_1
;           d_1   d_2
; 
;      by adding a new clause to the `deriv' program and defining
;      appropriate procedures `exponentiation?', `base', `exponent', and
;      `make-exponentiation'.  (You may use the symbol `**' to denote
;      exponentiation.)  Build in the rules that anything raised to the
;      power 0 is 1 and anything raised to the power 1 is the thing
;      itself.
; 
; {{{3 Solution
; {{{2 Exercise 2.57:
; {{{3 Problem
;      Extend the differentiation program to handle sums
;      and products of arbitrary numbers of (two or more) terms.  Then
;      the last example above could be expressed as
; 
;           (deriv '(* x y (+ x 3)) 'x)
; 
;      Try to do this by changing only the representation for sums and
;      products, without changing the `deriv' procedure at all.  For
;      example, the `addend' of a sum would be the first term, and the
;      `augend' would be the sum of the rest of the terms.
; 
; {{{3 Solution
; {{{2 Exercise 2.58:
; {{{3 Problem
;      Suppose we want to modify the differentiation
;      program so that it works with ordinary mathematical notation, in
;      which `+' and `*' are infix rather than prefix operators.  Since
;      the differentiation program is defined in terms of abstract data,
;      we can modify it to work with different representations of
;      expressions solely by changing the predicates, selectors, and
;      constructors that define the representation of the algebraic
;      expressions on which the differentiator is to operate.
; 
;        a. Show how to do this in order to differentiate algebraic
;           expressions presented in infix form, such as `(x + (3 * (x +
;           (y + 2))))'.  To simplify the task, assume that `+' and `*'
;           always take two arguments and that expressions are fully
;           parenthesized.
; 
;        b. The problem becomes substantially harder if we allow standard
;           algebraic notation, such as `(x + 3 * (x + y + 2))', which
;           drops unnecessary parentheses and assumes that multiplication
;           is done before addition.  Can you design appropriate
;           predicates, selectors, and constructors for this notation
;           such that our derivative program still works?
; 
; {{{3 Solution
; 
; {{{1 2.3.3 Example: Representing Sets
; 
; {{{2 Exercise 2.59:
; {{{3 Problem
;      Implement the `union-set' operation for the
;      unordered-list representation of sets.
; 
; {{{3 Solution
; {{{2 Exercise 2.60:
; {{{3 Problem
;      We specified that a set would be represented as a
;      list with no duplicates.  Now suppose we allow duplicates.  For
;      instance, the set {1,2,3} could be represented as the list `(2 3 2
;      1 3 2 2)'.  Design procedures `element-of-set?', `adjoin-set',
;      `union-set', and `intersection-set' that operate on this
;      representation.  How does the efficiency of each compare with the
;      corresponding procedure for the non-duplicate representation?  Are
;      there applications for which you would use this representation in
;      preference to the non-duplicate one?
; 
; {{{3 Solution
; {{{2 Exercise 2.61:
; {{{3 Problem
;      Give an implementation of `adjoin-set' using the
;      ordered representation.  By analogy with `element-of-set?' show
;      how to take advantage of the ordering to produce a procedure that
;      requires on the average about half as many steps as with the
;      unordered representation.
; 
; {{{3 Solution
; {{{2 Exercise 2.62:
; {{{3 Problem
;      Give a [theta](n) implementation of `union-set'
;      for sets represented as ordered lists.
; 
; {{{3 Solution
; {{{2 Exercise 2.63:
; {{{3 Problem
;      Each of the following two procedures converts a
;      binary tree to a list.
; 
;           (define (tree->list-1 tree)
;             (if (null? tree)
;                 '()
;                 (append (tree->list-1 (left-branch tree))
;                         (cons (entry tree)
;                               (tree->list-1 (right-branch tree))))))
; 
;           (define (tree->list-2 tree)
;             (define (copy-to-list tree result-list)
;               (if (null? tree)
;                   result-list
;                   (copy-to-list (left-branch tree)
;                                 (cons (entry tree)
;                                       (copy-to-list (right-branch tree)
;                                                     result-list)))))
;             (copy-to-list tree '()))
; 
;        a. Do the two procedures produce the same result for every tree?
;           If not, how do the results differ?  What lists do the two
;           procedures produce for the trees in *Note Figure 2-16::?
; 
;        b. Do the two procedures have the same order of growth in the
;           number of steps required to convert a balanced tree with n
;           elements to a list?  If not, which one grows more slowly?
; 
; {{{3 Solution
; {{{2 Exercise 2.64:
; {{{3 Problem
;      The following procedure `list->tree' converts an
;      ordered list to a balanced binary tree.  The helper procedure
;      `partial-tree' takes as arguments an integer n and list of at
;      least n elements and constructs a balanced tree containing the
;      first n elements of the list.  The result returned by
;      `partial-tree' is a pair (formed with `cons') whose `car' is the
;      constructed tree and whose `cdr' is the list of elements not
;      included in the tree.
; 
;           (define (list->tree elements)
;             (car (partial-tree elements (length elements))))
; 
;           (define (partial-tree elts n)
;             (if (= n 0)
;                 (cons '() elts)
;                 (let ((left-size (quotient (- n 1) 2)))
;                   (let ((left-result (partial-tree elts left-size)))
;                     (let ((left-tree (car left-result))
;                           (non-left-elts (cdr left-result))
;                           (right-size (- n (+ left-size 1))))
;                       (let ((this-entry (car non-left-elts))
;                             (right-result (partial-tree (cdr non-left-elts)
;                                                         right-size)))
;                         (let ((right-tree (car right-result))
;                               (remaining-elts (cdr right-result)))
;                           (cons (make-tree this-entry left-tree right-tree)
;                                 remaining-elts))))))))
; 
;        a. Write a short paragraph explaining as clearly as you can how
;           `partial-tree' works.  Draw the tree produced by `list->tree'
;           for the list `(1 3 5 7 9 11)'.
; 
;        b. What is the order of growth in the number of steps required by
;           `list->tree' to convert a list of n elements?
; 
; {{{3 Solution
; {{{2 Exercise 2.65:
; {{{3 Problem
;      Use the results of *Note Exercise 2-63:: and
;      *Note Exercise 2-64:: to give [theta](n) implementations of
;      `union-set' and `intersection-set' for sets implemented as
;      (balanced) binary trees.(5)
; 
; {{{3 Solution
; {{{2 Exercise 2.66:
; {{{3 Problem
;      Implement the `lookup' procedure for the case
;      where the set of records is structured as a binary tree, ordered
;      by the numerical values of the keys.
; 
; 
; {{{3 Solution
; 
; {{{1 2.3.4 Example: Huffman Encoding Trees
; 
; {{{2 Exercise 2.67:
; {{{3 Problem
;      Define an encoding tree and a sample message:
; 
;           (define sample-tree
;             (make-code-tree (make-leaf 'A 4)
;                             (make-code-tree
;                              (make-leaf 'B 2)
;                              (make-code-tree (make-leaf 'D 1)
;                                              (make-leaf 'C 1)))))
; 
;           (define sample-message '(0 1 1 0 0 1 0 1 0 1 1 1 0))
; 
;      Use the `decode' procedure to decode the message, and give the
;      result.
; 
; {{{3 Solution
; {{{2 Exercise 2.68:
; {{{3 Problem
;      The `encode' procedure takes as arguments a
;      message and a tree and produces the list of bits that gives the
;      encoded message.
; 
;           (define (encode message tree)
;             (if (null? message)
;                 '()
;                 (append (encode-symbol (car message) tree)
;                         (encode (cdr message) tree))))
; 
;      `Encode-symbol' is a procedure, which you must write, that returns
;      the list of bits that encodes a given symbol according to a given
;      tree.  You should design `encode-symbol' so that it signals an
;      error if the symbol is not in the tree at all.  Test your
;      procedure by encoding the result you obtained in *Note Exercise
;      2-67:: with the sample tree and seeing whether it is the same as
;      the original sample message.
; 
; {{{3 Solution
; {{{2 Exercise 2.69:
; {{{3 Problem
;      The following procedure takes as its argument a
;      list of symbol-frequency pairs (where no symbol appears in more
;      than one pair) and generates a Huffman encoding tree according to
;      the Huffman algorithm.
; 
;           (define (generate-huffman-tree pairs)
;             (successive-merge (make-leaf-set pairs)))
; 
;      `Make-leaf-set' is the procedure given above that transforms the
;      list of pairs into an ordered set of leaves.  `Successive-merge'
;      is the procedure you must write, using `make-code-tree' to
;      successively merge the smallest-weight elements of the set until
;      there is only one element left, which is the desired Huffman tree.
;      (This procedure is slightly tricky, but not really complicated.
;      If you find yourself designing a complex procedure, then you are
;      almost certainly doing something wrong.  You can take significant
;      advantage of the fact that we are using an ordered set
;      representation.)
; 
; {{{3 Solution
; {{{2 Exercise 2.70:
; {{{3 Problem
;      The following eight-symbol alphabet with
;      associated relative frequencies was designed to efficiently encode
;      the lyrics of 1950s rock songs.  (Note that the "symbols" of an
;      "alphabet" need not be individual letters.)
; 
;           A     2 NA   16
;           BOOM  1 SHA  3
;           GET   2 YIP  9
;           JOB   2 WAH  1
; 
;      Use `generate-huffman-tree' (*Note Exercise 2-69::) to generate a
;      corresponding Huffman tree, and use `encode' (*Note Exercise
;      2-68::) to encode the following message:
; 
;           Get a job
; 
;           Sha na na na na na na na na
; 
;           Get a job
; 
;           Sha na na na na na na na na
; 
;           Wah yip yip yip yip yip yip yip yip yip
; 
;           Sha boom
; 
;      How many bits are required for the encoding?  What is the smallest
;      number of bits that would be needed to encode this song if we used
;      a fixed-length code for the eight-symbol alphabet?
; 
; {{{3 Solution
; {{{2 Exercise 2.71:
; {{{3 Problem
;      Suppose we have a Huffman tree for an alphabet of
;      n symbols, and that the relative frequencies of the symbols are 1,
;      2, 4, ..., 2^(n-1).  Sketch the tree for n=5; for n=10.  In such a
;      tree (for general n) how may bits are required to encode the most
;      frequent symbol?  the least frequent symbol?
; 
; {{{3 Solution
; {{{2 Exercise 2.72:
; {{{3 Problem
;      Consider the encoding procedure that you designed
;      in *Note Exercise 2-68::.  What is the order of growth in the
;      number of steps needed to encode a symbol?  Be sure to include the
;      number of steps needed to search the symbol list at each node
;      encountered.  To answer this question in general is difficult.
;      Consider the special case where the relative frequencies of the n
;      symbols are as described in *Note Exercise 2-71::, and give the
;      order of growth (as a function of n) of the number of steps needed
;      to encode the most frequent and least frequent symbols in the
;      alphabet.
; 
; {{{3 Solution
; 
; {{{1 2.4.3 Data-Directed Programming and Additivity
; 
; {{{2 Exercise 2.73:
; {{{3 Problem
;      Section *Note 2-3-2:: described a program that
;      performs symbolic differentiation:
; 
;           (define (deriv exp var)
;             (cond ((number? exp) 0)
;                   ((variable? exp) (if (same-variable? exp var) 1 0))
;                   ((sum? exp)
;                    (make-sum (deriv (addend exp) var)
;                              (deriv (augend exp) var)))
;                   ((product? exp)
;                    (make-sum
;                      (make-product (multiplier exp)
;                                    (deriv (multiplicand exp) var))
;                      (make-product (deriv (multiplier exp) var)
;                                    (multiplicand exp))))
;                   <MORE RULES CAN BE ADDED HERE>
;                   (else (error "unknown expression type -- DERIV" exp))))
; 
;      We can regard this program as performing a dispatch on the type of
;      the expression to be differentiated.  In this situation the "type
;      tag" of the datum is the algebraic operator symbol (such as `+')
;      and the operation being performed is `deriv'.  We can transform
;      this program into data-directed style by rewriting the basic
;      derivative procedure as
; 
;           (define (deriv exp var)
;              (cond ((number? exp) 0)
;                    ((variable? exp) (if (same-variable? exp var) 1 0))
;                    (else ((get 'deriv (operator exp)) (operands exp)
;                                                       var))))
; 
;           (define (operator exp) (car exp))
; 
;           (define (operands exp) (cdr exp))
; 
;        a. Explain what was done above.  Why can't we assimilate the
;           predicates `number?' and `same-variable?' into the
;           data-directed dispatch?
; 
;        b. Write the procedures for derivatives of sums and products,
;           and the auxiliary code required to install them in the table
;           used by the program above.
; 
;        c. Choose any additional differentiation rule that you like,
;           such as the one for exponents (*Note Exercise 2-56::), and
;           install it in this data-directed system.
; 
;        d. In this simple algebraic manipulator the type of an
;           expression is the algebraic operator that binds it together.
;           Suppose, however, we indexed the procedures in the opposite
;           way, so that the dispatch line in `deriv' looked like
; 
;                ((get (operator exp) 'deriv) (operands exp) var)
; 
;           What corresponding changes to the derivative system are
;           required?
; 
; {{{3 Solution
; {{{2 Exercise 2.74:
; {{{3 Problem
;      Insatiable Enterprises, Inc., is a highly
;      decentralized conglomerate company consisting of a large number of
;      independent divisions located all over the world.  The company's
;      computer facilities have just been interconnected by means of a
;      clever network-interfacing scheme that makes the entire network
;      appear to any user to be a single computer.  Insatiable's
;      president, in her first attempt to exploit the ability of the
;      network to extract administrative information from division files,
;      is dismayed to discover that, although all the division files have
;      been implemented as data structures in Scheme, the particular data
;      structure used varies from division to division.  A meeting of
;      division managers is hastily called to search for a strategy to
;      integrate the files that will satisfy headquarters' needs while
;      preserving the existing autonomy of the divisions.
; 
;      Show how such a strategy can be implemented with data-directed
;      programming.  As an example, suppose that each division's
;      personnel records consist of a single file, which contains a set
;      of records keyed on employees' names.  The structure of the set
;      varies from division to division.  Furthermore, each employee's
;      record is itself a set (structured differently from division to
;      division) that contains information keyed under identifiers such
;      as `address' and `salary'.  In particular:
; 
;        a. Implement for headquarters a `get-record' procedure that
;           retrieves a specified employee's record from a specified
;           personnel file.  The procedure should be applicable to any
;           division's file.  Explain how the individual divisions' files
;           should be structured.  In particular, what type information
;           must be supplied?
; 
;        b. Implement for headquarters a `get-salary' procedure that
;           returns the salary information from a given employee's record
;           from any division's personnel file.  How should the record be
;           structured in order to make this operation work?
; 
;        c. Implement for headquarters a `find-employee-record'
;           procedure.  This should search all the divisions' files for
;           the record of a given employee and return the record.  Assume
;           that this procedure takes as arguments an employee's name and
;           a list of all the divisions' files.
; 
;        d. When Insatiable takes over a new company, what changes must
;           be made in order to incorporate the new personnel information
;           into the central system?
; 
; {{{3 Solution
; {{{2 Exercise 2.75:
; {{{3 Problem
;      Implement the constructor `make-from-mag-ang' in
;      message-passing style.  This procedure should be analogous to the
;      `make-from-real-imag' procedure given above.
; 
; {{{3 Solution
; {{{2 Exercise 2.76:
; {{{3 Problem
;      As a large system with generic operations
;      evolves, new types of data objects or new operations may be needed.
;      For each of the three strategies--generic operations with explicit
;      dispatch, data-directed style, and message-passing-style--describe
;      the changes that must be made to a system in order to add new
;      types or new operations.  Which organization would be most
;      appropriate for a system in which new types must often be added?
;      Which would be most appropriate for a system in which new
;      operations must often be added?
; 
; {{{3 Solution
; 
; {{{1 2.5.1 Generic Arithmetic Operations
; 
; {{{2 Exercise 2.77:
; {{{3 Problem
;      Louis Reasoner tries to evaluate the expression
;      `(magnitude z)' where `z' is the object shown in *Note Figure
;      2-24::.  To his surprise, instead of the answer 5 he gets an error
;      message from `apply-generic', saying there is no method for the
;      operation `magnitude' on the types `(complex)'.  He shows this
;      interaction to Alyssa P. Hacker, who says "The problem is that the
;      complex-number selectors were never defined for `complex' numbers,
;      just for `polar' and `rectangular' numbers.  All you have to do to
;      make this work is add the following to the `complex' package:"
; 
;           (put 'real-part '(complex) real-part)
;           (put 'imag-part '(complex) imag-part)
;           (put 'magnitude '(complex) magnitude)
;           (put 'angle '(complex) angle)
; 
;      Describe in detail why this works.  As an example, trace through
;      all the procedures called in evaluating the expression `(magnitude
;      z)' where `z' is the object shown in *Note Figure 2-24::.  In
;      particular, how many times is `apply-generic' invoked?  What
;      procedure is dispatched to in each case?
; 
; {{{3 Solution
; {{{2 Exercise 2.78:
; {{{3 Problem
;      The internal procedures in the `scheme-number'
;      package are essentially nothing more than calls to the primitive
;      procedures `+', `-', etc.  It was not possible to use the
;      primitives of the language directly because our type-tag system
;      requires that each data object have a type attached to it.  In
;      fact, however, all Lisp implementations do have a type system,
;      which they use internally.  Primitive predicates such as `symbol?'
;      and `number?'  determine whether data objects have particular
;      types.  Modify the definitions of `type-tag', `contents', and
;      `attach-tag' from section *Note 2-4-2:: so that our generic system
;      takes advantage of Scheme's internal type system.  That is to say,
;      the system should work as before except that ordinary numbers
;      should be represented simply as Scheme numbers rather than as
;      pairs whose `car' is the symbol `scheme-number'.
; 
; {{{3 Solution
; {{{2 Exercise 2.79:
; {{{3 Problem
;      Define a generic equality predicate `equ?' that
;      tests the equality of two numbers, and install it in the generic
;      arithmetic package.  This operation should work for ordinary
;      numbers, rational numbers, and complex numbers.
; 
; {{{3 Solution
; {{{2 Exercise 2.80:
; {{{3 Problem
;      Define a generic predicate `=zero?' that tests if
;      its argument is zero, and install it in the generic arithmetic
;      package.  This operation should work for ordinary numbers, rational
;      numbers, and complex numbers.
; 
; {{{3 Solution
; 
; {{{1 2.5.2 Combining Data of Different Types
; 
; {{{2 Exercise 2.81:
; {{{3 Problem
;      Louis Reasoner has noticed that `apply-generic'
;      may try to coerce the arguments to each other's type even if they
;      already have the same type.  Therefore, he reasons, we need to put
;      procedures in the coercion table to "coerce" arguments of each
;      type to their own type.  For example, in addition to the
;      `scheme-number->complex' coercion shown above, he would do:
; 
;           (define (scheme-number->scheme-number n) n)
;           (define (complex->complex z) z)
;           (put-coercion 'scheme-number 'scheme-number
;                         scheme-number->scheme-number)
;           (put-coercion 'complex 'complex complex->complex)
; 
;        a. With Louis's coercion procedures installed, what happens if
;           `apply-generic' is called with two arguments of type
;           `scheme-number' or two arguments of type `complex' for an
;           operation that is not found in the table for those types?
;           For example, assume that we've defined a generic
;           exponentiation operation:
; 
;                (define (exp x y) (apply-generic 'exp x y))
; 
;           and have put a procedure for exponentiation in the
;           Scheme-number package but not in any other package:
; 
;                ;; following added to Scheme-number package
;                (put 'exp '(scheme-number scheme-number)
;                     (lambda (x y) (tag (expt x y)))) ; using primitive `expt'
; 
;           What happens if we call `exp' with two complex numbers as
;           arguments?
; 
;        b. Is Louis correct that something had to be done about coercion
;           with arguments of the same type, or does `apply-generic' work
;           correctly as is?
; 
;        c. Modify `apply-generic' so that it doesn't try coercion if the
;           two arguments have the same type.
; 
; {{{3 Solution
; {{{2 Exercise 2.82:
; {{{3 Problem
;      Show how to generalize `apply-generic' to handle
;      coercion in the general case of multiple arguments.  One strategy
;      is to attempt to coerce all the arguments to the type of the first
;      argument, then to the type of the second argument, and so on.
;      Give an example of a situation where this strategy (and likewise
;      the two-argument version given above) is not sufficiently general.
;      (Hint: Consider the case where there are some suitable mixed-type
;      operations present in the table that will not be tried.)
; 
; {{{3 Solution
; {{{2 Exercise 2.83:
; {{{3 Problem
;      Suppose you are designing a generic arithmetic
;      system for dealing with the tower of types shown in *Note Figure
;      2-25::: integer, rational, real, complex.  For each type (except
;      complex), design a procedure that raises objects of that type one
;      level in the tower.  Show how to install a generic `raise'
;      operation that will work for each type (except complex).
; 
; {{{3 Solution
; {{{2 Exercise 2.84:
; {{{3 Problem
;      Using the `raise' operation of *Note Exercise
;      2-83::, modify the `apply-generic' procedure so that it coerces
;      its arguments to have the same type by the method of successive
;      raising, as discussed in this section.  You will need to devise a
;      way to test which of two types is higher in the tower.  Do this in
;      a manner that is "compatible" with the rest of the system and will
;      not lead to problems in adding new levels to the tower.
; 
; {{{3 Solution
; {{{2 Exercise 2.85:
; {{{3 Problem
;      This section mentioned a method for "simplifying"
;      a data object by lowering it in the tower of types as far as
;      possible.  Design a procedure `drop' that accomplishes this for the
;      tower described in *Note Exercise 2-83::.  The key is to decide,
;      in some general way, whether an object can be lowered.  For
;      example, the complex number 1.5 + 0i can be lowered as far as
;      `real', the complex number 1 + 0i can be lowered as far as
;      `integer', and the complex number 2 + 3i cannot be lowered at all.
;      Here is a plan for determining whether an object can be lowered:
;      Begin by defining a generic operation `project' that "pushes" an
;      object down in the tower.  For example, projecting a complex
;      number would involve throwing away the imaginary part.  Then a
;      number can be dropped if, when we `project' it and `raise' the
;      result back to the type we started with, we end up with something
;      equal to what we started with.  Show how to implement this idea in
;      detail, by writing a `drop' procedure that drops an object as far
;      as possible.  You will need to design the various projection
;      operations(5) and install `project' as a generic operation in the
;      system.  You will also need to make use of a generic equality
;      predicate, such as described in *Note Exercise 2-79::.  Finally,
;      use `drop' to rewrite `apply-generic' from *Note Exercise 2-84::
;      so that it "simplifies" its answers.
; 
; {{{3 Solution
; {{{2 Exercise 2.86:
; {{{3 Problem
;      Suppose we want to handle complex numbers whose
;      real parts, imaginary parts, magnitudes, and angles can be either
;      ordinary numbers, rational numbers, or other numbers we might wish
;      to add to the system.  Describe and implement the changes to the
;      system needed to accommodate this.  You will have to define
;      operations such as `sine' and `cosine' that are generic over
;      ordinary numbers and rational numbers.
; 
; {{{3 Solution
; 
; {{{1 2.5.3 Example: Symbolic Algebra
; 
; {{{2 Exercise 2.87:
; {{{3 Problem
;      Install `=zero?' for polynomials in the generic
;      arithmetic package.  This will allow `adjoin-term' to work for
;      polynomials with coefficients that are themselves polynomials.
; 
; {{{3 Solution
; {{{2 Exercise 2.88:
; {{{3 Problem
;      Extend the polynomial system to include
;      subtraction of polynomials.  (Hint: You may find it helpful to
;      define a generic negation operation.)
; 
; {{{3 Solution
; {{{2 Exercise 2.89:
; {{{3 Problem
;      Define procedures that implement the term-list
;      representation described above as appropriate for dense
;      polynomials.
; 
; {{{3 Solution
; {{{2 Exercise 2.90:
; {{{3 Problem
;      Suppose we want to have a polynomial system that
;      is efficient for both sparse and dense polynomials.  One way to do
;      this is to allow both kinds of term-list representations in our
;      system.  The situation is analogous to the complex-number example
;      of section *Note 2-4::, where we allowed both rectangular and
;      polar representations.  To do this we must distinguish different
;      types of term lists and make the operations on term lists generic.
;      Redesign the polynomial system to implement this generalization.
;      This is a major effort, not a local change.
; 
; {{{3 Solution
; {{{2 Exercise 2.91:
; {{{3 Problem
;      A univariate polynomial can be divided by another
;      one to produce a polynomial quotient and a polynomial remainder.
;      For example,
; 
;           x^5 - 1
;           ------- = x^3 + x, remainder x - 1
;           x^2 - 1
; 
;      Division can be performed via long division.  That is, divide the
;      highest-order term of the dividend by the highest-order term of
;      the divisor.  The result is the first term of the quotient.  Next,
;      multiply the result by the divisor, subtract that from the
;      dividend, and produce the rest of the answer by recursively
;      dividing the difference by the divisor.  Stop when the order of the
;      divisor exceeds the order of the dividend and declare the dividend
;      to be the remainder.  Also, if the dividend ever becomes zero,
;      return zero as both quotient and remainder.
; 
;      We can design a `div-poly' procedure on the model of `add-poly' and
;      `mul-poly'. The procedure checks to see if the two polys have the
;      same variable.  If so, `div-poly' strips off the variable and
;      passes the problem to `div-terms', which performs the division
;      operation on term lists. `Div-poly' finally reattaches the
;      variable to the result supplied by `div-terms'.  It is convenient
;      to design `div-terms' to compute both the quotient and the
;      remainder of a division.  `Div-terms' can take two term lists as
;      arguments and return a list of the quotient term list and the
;      remainder term list.
; 
;      Complete the following definition of `div-terms' by filling in the
;      missing expressions.  Use this to implement `div-poly', which
;      takes two polys as arguments and returns a list of the quotient
;      and remainder polys.
; 
;           (define (div-terms L1 L2)
;             (if (empty-termlist? L1)
;                 (list (the-empty-termlist) (the-empty-termlist))
;                 (let ((t1 (first-term L1))
;                       (t2 (first-term L2)))
;                   (if (> (order t2) (order t1))
;                       (list (the-empty-termlist) L1)
;                       (let ((new-c (div (coeff t1) (coeff t2)))
;                             (new-o (- (order t1) (order t2))))
;                         (let ((rest-of-result
;                                <COMPUTE REST OF RESULT RECURSIVELY>
;                                ))
;                           <FORM COMPLETE RESULT>
;                           ))))))
; 
; {{{3 Solution
; {{{2 Exercise 2.92:
; {{{3 Problem
;      By imposing an ordering on variables, extend the
;      polynomial package so that addition and multiplication of
;      polynomials works for polynomials in different variables.  (This
;      is not easy!)
; 
; {{{3 Solution
; {{{2 Exercise 2.93:
; {{{3 Problem
;      Modify the rational-arithmetic package to use
;      generic operations, but change `make-rat' so that it does not
;      attempt to reduce fractions to lowest terms.  Test your system by
;      calling `make-rational' on two polynomials to produce a rational
;      function
; 
;           (define p1 (make-polynomial 'x '((2 1)(0 1))))
;           (define p2 (make-polynomial 'x '((3 1)(0 1))))
;           (define rf (make-rational p2 p1))
; 
;      Now add `rf' to itself, using `add'. You will observe that this
;      addition procedure does not reduce fractions to lowest terms.
; 
;      We can reduce polynomial fractions to lowest terms using the same
;      idea we used with integers: modifying `make-rat' to divide both
;      the numerator and the denominator by their greatest common
;      divisor.  The notion of "greatest common divisor" makes sense for
;      polynomials.  In fact, we can compute the GCD of two polynomials
;      using essentially the same Euclid's Algorithm that works for
;      integers.(7)  The integer version is
; 
;           (define (gcd a b)
;             (if (= b 0)
;                 a
;                 (gcd b (remainder a b))))
; 
;      Using this, we could make the obvious modification to define a GCD
;      operation that works on term lists:
; 
;           (define (gcd-terms a b)
;             (if (empty-termlist? b)
;                 a
;                 (gcd-terms b (remainder-terms a b))))
; 
;      where `remainder-terms' picks out the remainder component of the
;      list returned by the term-list division operation `div-terms' that
;      was implemented in *Note Exercise 2-91::.
; 
; {{{3 Solution
; {{{2 Exercise 2.94:
; {{{3 Problem
;      Using `div-terms', implement the procedure
;      `remainder-terms' and use this to define `gcd-terms' as above.
;      Now write a procedure `gcd-poly' that computes the polynomial GCD
;      of two polys.  (The procedure should signal an error if the two
;      polys are not in the same variable.)  Install in the system a
;      generic operation `greatest-common-divisor' that reduces to
;      `gcd-poly' for polynomials and to ordinary `gcd' for ordinary
;      numbers.  As a test, try
; 
;           (define p1 (make-polynomial 'x '((4 1) (3 -1) (2 -2) (1 2))))
;           (define p2 (make-polynomial 'x '((3 1) (1 -1))))
;           (greatest-common-divisor p1 p2)
; 
;      and check your result by hand.
; 
; {{{3 Solution
; {{{2 Exercise 2.95:
; {{{3 Problem
;      Define P_1, P_2, and P_3 to be the polynomials
; 
;           P_1 : x^2 - 2x + 1
; 
;           P_2 : 11x^2 + 7
; 
;           P_3 : 13x + 5
; 
;      Now define Q_1 to be the product of P_1 and P_2 and Q_2 to be the
;      product of P_1 and P_3, and use `greatest-common-divisor' (*Note
;      Exercise 2-94::) to compute the GCD of Q_1 and Q_2.  Note that the
;      answer is not the same as P_1.  This example introduces noninteger
;      operations into the computation, causing difficulties with the GCD
;      algorithm.(8)  To understand what is happening, try tracing
;      `gcd-terms' while computing the GCD or try performing the division
;      by hand.
; 
;      We can solve the problem exhibited in *Note Exercise 2-95:: if we
;      use the following modification of the GCD algorithm (which really
;      works only in the case of polynomials with integer coefficients).
;      Before performing any polynomial division in the GCD computation,
;      we multiply the dividend by an integer constant factor, chosen to
;      guarantee that no fractions will arise during the division
;      process.  Our answer will thus differ from the actual GCD by an
;      integer constant factor, but this does not matter in the case of
;      reducing rational functions to lowest terms; the GCD will be used
;      to divide both the numerator and denominator, so the integer
;      constant factor will cancel out.
; 
;      More precisely, if P and Q are polynomials, let O_1 be the order of
;      P (i.e., the order of the largest term of P) and let O_2 be the
;      order of Q.  Let c be the leading coefficient of Q.  Then it can be
;      shown that, if we multiply P by the "integerizing factor" c^(1+O_1
;      -O_2), the resulting polynomial can be divided by Q by using the
;      `div-terms' algorithm without introducing any fractions.  The
;      operation of multiplying the dividend by this constant and then
;      dividing is sometimes called the "pseudodivision" of P by Q.  The
;      remainder of the division is called the "pseudoremainder".
; 
;      *Exercise 2.96:*
;        a. Implement the procedure `pseudoremainder-terms', which is
;           just like `remainder-terms' except that it multiplies the
;           dividend by the integerizing factor described above before
;           calling `div-terms'.  Modify `gcd-terms' to use
;           `pseudoremainder-terms', and verify that
;           `greatest-common-divisor' now produces an answer with integer
;           coefficients on the example in *Note Exercise 2-95::.
; 
;        b. The GCD now has integer coefficients, but they are larger
;           than those of P_1.  Modify `gcd-terms' so that it removes
;           common factors from the coefficients of the answer by
;           dividing all the coefficients by their (integer) greatest
;           common divisor.
; 
; 
;      Thus, here is how to reduce a rational function to lowest terms:
; 
;         * Compute the GCD of the numerator and denominator, using the
;           version of `gcd-terms' from *Note Exercise 2-96::.
; 
;         * When you obtain the GCD, multiply both numerator and
;           denominator by the same integerizing factor before dividing
;           through by the GCD, so that division by the GCD will not
;           introduce any noninteger coefficients.  As the factor you can
;           use the leading coefficient of the GCD raised to the power 1
;           + O_1 - O_2, where O_2 is the order of the GCD and O_1 is the
;           maximum of the orders of the numerator and denominator.  This
;           will ensure that dividing the numerator and denominator by
;           the GCD will not introduce any fractions.
; 
;         * The result of this operation will be a numerator and
;           denominator with integer coefficients.  The coefficients will
;           normally be very large because of all of the integerizing
;           factors, so the last step is to remove the redundant factors
;           by computing the (integer) greatest common divisor of all the
;           coefficients of the numerator and the denominator and
;           dividing through by this factor.
; 
;      *Exercise 2.97:*
;        a. Implement this algorithm as a procedure `reduce-terms' that
;           takes two term lists `n' and `d' as arguments and returns a
;           list `nn', `dd', which are `n' and `d' reduced to lowest
;           terms via the algorithm given above.  Also write a procedure
;           `reduce-poly', analogous to `add-poly', that checks to see if
;           the two polys have the same variable.  If so, `reduce-poly'
;           strips off the variable and passes the problem to
;           `reduce-terms', then reattaches the variable to the two term
;           lists supplied by `reduce-terms'.
; 
;        b. Define a procedure analogous to `reduce-terms' that does what
;           the original `make-rat' did for integers:
; 
;                (define (reduce-integers n d)
;                  (let ((g (gcd n d)))
;                    (list (/ n g) (/ d g))))
; 
;           and define `reduce' as a generic operation that calls
;           `apply-generic' to dispatch to either `reduce-poly' (for
;           `polynomial' arguments) or `reduce-integers' (for
;           `scheme-number' arguments).  You can now easily make the
;           rational-arithmetic package reduce fractions to lowest terms
;           by having `make-rat' call `reduce' before combining the given
;           numerator and denominator to form a rational number.  The
;           system now handles rational expressions in either integers or
;           polynomials.  To test your program, try the example at the
;           beginning of this extended exercise:
; 
;                (define p1 (make-polynomial 'x '((1 1)(0 1))))
;                (define p2 (make-polynomial 'x '((3 1)(0 -1))))
;                (define p3 (make-polynomial 'x '((1 1))))
;                (define p4 (make-polynomial 'x '((2 1)(0 -1))))
; 
;                (define rf1 (make-rational p1 p2))
;                (define rf2 (make-rational p3 p4))
; 
;                (add rf1 rf2)
; 
;           See if you get the correct answer, correctly reduced to
;           lowest terms.
; 
;           The GCD computation is at the heart of any system that does
;           operations on rational functions.  The algorithm used above,
;           although mathematically straightforward, is extremely slow.
;           The slowness is due partly to the large number of division
;           operations and partly to the enormous size of the
;           intermediate coefficients generated by the pseudodivisions.
;           One of the active areas in the development of
;           algebraic-manipulation systems is the design of better
;           algorithms for computing polynomial GCDs.(9)
; 
; {{{3 Solution
; 
; {{{1 3.1.1 Local State Variables
; {{{2 Exercise 3.1:
; {{{3 Problem
;      An "accumulator" is a procedure that is called
;      repeatedly with a single numeric argument and accumulates its
;      arguments into a sum.  Each time it is called, it returns the
;      currently accumulated sum.  Write a procedure `make-accumulator'
;      that generates accumulators, each maintaining an independent sum.
;      The input to `make-accumulator' should specify the initial value
;      of the sum; for example
; 
;           (define A (make-accumulator 5))
; 
;           (A 10)
;           15
; 
;           (A 10)
;           25
; 
; {{{3 Solution
; {{{2 Exercise 3.2:
; {{{3 Problem
;      In software-testing applications, it is useful to
;      be able to count the number of times a given procedure is called
;      during the course of a computation.  Write a procedure
;      `make-monitored' that takes as input a procedure, `f', that itself
;      takes one input.  The result returned by `make-monitored' is a
;      third procedure, say `mf', that keeps track of the number of times
;      it has been called by maintaining an internal counter.  If the
;      input to `mf' is the special symbol `how-many-calls?', then `mf'
;      returns the value of the counter.  If the input is the special
;      symbol `reset-count', then `mf' resets the counter to zero.  For
;      any other input, `mf' returns the result of calling `f' on that
;      input and increments the counter.  For instance, we could make a
;      monitored version of the `sqrt' procedure:
; 
;           (define s (make-monitored sqrt))
; 
;           (s 100)
;           10
; 
;           (s 'how-many-calls?)
;           1
; 
; {{{3 Solution
; {{{2 Exercise 3.3:
; {{{3 Problem
;      Modify the `make-account' procedure so that it
;      creates password-protected accounts.  That is, `make-account'
;      should take a symbol as an additional argument, as in
; 
;           (define acc (make-account 100 'secret-password))
; 
;      The resulting account object should process a request only if it
;      is accompanied by the password with which the account was created,
;      and should otherwise return a complaint:
; 
;           ((acc 'secret-password 'withdraw) 40)
;           60
; 
;           ((acc 'some-other-password 'deposit) 50)
;           "Incorrect password"
; 
; {{{3 Solution
; {{{2 Exercise 3.4:
; {{{3 Problem
;      Modify the `make-account' procedure of *Note
;      Exercise 3-3:: by adding another local state variable so that, if
;      an account is accessed more than seven consecutive times with an
;      incorrect password, it invokes the procedure `call-the-cops'.
; 
; {{{3 Solution
; {{{1 3.1.2 The Benefits of Introducing Assignment
; {{{2 Exercise 3.5:
; {{{3 Problem
;      "Monte Carlo integration" is a method of
;      estimating definite integrals by means of Monte Carlo simulation.
;      Consider computing the area of a region of space described by a
;      predicate P(x, y) that is true for points (x, y) in the region and
;      false for points not in the region.  For example, the region
;      contained within a circle of radius 3 centered at (5, 7) is
;      described by the predicate that tests whether (x - 5)^2 + (y -
;      7)^2 <= 3^2.  To estimate the area of the region described by such
;      a predicate, begin by choosing a rectangle that contains the
;      region.  For example, a rectangle with diagonally opposite corners
;      at (2, 4) and (8, 10) contains the circle above.  The desired
;      integral is the area of that portion of the rectangle that lies in
;      the region.  We can estimate the integral by picking, at random,
;      points (x,y) that lie in the rectangle, and testing P(x, y) for
;      each point to determine whether the point lies in the region.  If
;      we try this with many points, then the fraction of points that
;      fall in the region should give an estimate of the proportion of
;      the rectangle that lies in the region.  Hence, multiplying this
;      fraction by the area of the entire rectangle should produce an
;      estimate of the integral.
; 
;      Implement Monte Carlo integration as a procedure
;      `estimate-integral' that takes as arguments a predicate `P', upper
;      and lower bounds `x1', `x2', `y1', and `y2' for the rectangle, and
;      the number of trials to perform in order to produce the estimate.
;      Your procedure should use the same `monte-carlo' procedure that
;      was used above to estimate [pi].  Use your `estimate-integral' to
;      produce an estimate of [pi] by measuring the area of a unit circle.
; 
;      You will find it useful to have a procedure that returns a number
;      chosen at random from a given range.  The following
;      `random-in-range' procedure implements this in terms of the
;      `random' procedure used in section *Note 1-2-6::, which returns a
;      nonnegative number less than its input.(3)
; 
;           (define (random-in-range low high)
;             (let ((range (- high low)))
;               (+ low (random range))))
; 
; {{{3 Solution
; {{{2 Exercise 3.6:
; {{{3 Problem
;      It is useful to be able to reset a random-number
;      generator to produce a sequence starting from a given value.
;      Design a new `rand' procedure that is called with an argument that
;      is either the symbol `generate' or the symbol `reset' and behaves
;      as follows: `(rand 'generate)' produces a new random number;
;      `((rand 'reset) <NEW-VALUE>)' resets the internal state variable
;      to the designated <NEW-VALUE>.  Thus, by resetting the state, one
;      can generate repeatable sequences.  These are very handy to have
;      when testing and debugging programs that use random numbers.
; {{{3 Solution
; 
; {{{1 3.1.3 The Costs of Introducing Assignment
; {{{2 Exercise 3.7:
; {{{3 Problem
;      Consider the bank account objects created by
;      `make-account', with the password modification described in *Note
;      Exercise 3-3::.  Suppose that our banking system requires the
;      ability to make joint accounts.  Define a procedure `make-joint'
;      that accomplishes this.  `Make-joint' should take three arguments.
;      The first is a password-protected account.  The second argument
;      must match the password with which the account was defined in
;      order for the `make-joint' operation to proceed.  The third
;      argument is a new password.  `Make-joint' is to create an
;      additional access to the original account using the new password.
;      For example, if `peter-acc' is a bank account with password
;      `open-sesame', then
; 
;           (define paul-acc
;             (make-joint peter-acc 'open-sesame 'rosebud))
; 
;      will allow one to make transactions on `peter-acc' using the name
;      `paul-acc' and the password `rosebud'.  You may wish to modify your
;      solution to *Note Exercise 3-3:: to accommodate this new feature
; 
; {{{3 Solution
; {{{2 Exercise 3.8:
; {{{3 Problem
;      When we defined the evaluation model in section
;      *Note 1-1-3::, we said that the first step in evaluating an
;      expression is to evaluate its subexpressions.  But we never
;      specified the order in which the subexpressions should be
;      evaluated (e.g., left to right or right to left).  When we
;      introduce assignment, the order in which the arguments to a
;      procedure are evaluated can make a difference to the result.
;      Define a simple procedure `f' such that evaluating `(+ (f 0) (f
;      1))' will return 0 if the arguments to `+' are evaluated from left
;      to right but will return 1 if the arguments are evaluated from
;      right to left.
; 
; {{{3 Solution
; {{{1 3.2.2 Applying Simple Procedures
; {{{2 Exercise 3.9:
; {{{3 Problem
;      In section *Note 1-2-1:: we used the substitution
;      model to analyze two procedures for computing factorials, a
;      recursive version
; 
;           (define (factorial n)
;             (if (= n 1)
;                 1
;                 (* n (factorial (- n 1)))))
; 
;      and an iterative version
; 
;           (define (factorial n)
;             (fact-iter 1 1 n))
; 
;           (define (fact-iter product counter max-count)
;             (if (> counter max-count)
;                 product
;                 (fact-iter (* counter product)
;                            (+ counter 1)
;                            max-count)))
; 
;      Show the environment structures created by evaluating `(factorial
;      6)' using each version of the `factorial' procedure.(1)
; 
; {{{3 Solution
; 
; {{{1 3.2.3 Frames as the Repository of Local State
; {{{2 Exercise 3.10:
; {{{3 Problem
;      In the `make-withdraw' procedure, the local
;      variable `balance' is created as a parameter of `make-withdraw'.
;      We could also create the local state variable explicitly, using
;      `let', as follows:
; 
;           (define (make-withdraw initial-amount)
;             (let ((balance initial-amount))
;               (lambda (amount)
;                 (if (>= balance amount)
;                     (begin (set! balance (- balance amount))
;                            balance)
;                     "Insufficient funds"))))
; 
;      Recall from section *Note 1-3-2:: that `let' is simply syntactic
;      sugar for a procedure call:
; 
;           (let ((<VAR> <EXP>)) <BODY>)
; 
;      is interpreted as an alternate syntax for
; 
;           ((lambda (<VAR>) <BODY>) <EXP>)
; 
;      Use the environment model to analyze this alternate version of
;      `make-withdraw', drawing figures like the ones above to illustrate
;      the interactions
; 
;           (define W1 (make-withdraw 100))
; 
;           (W1 50)
; 
;           (define W2 (make-withdraw 100))
; 
;      Show that the two versions of `make-withdraw' create objects with
;      the same behavior.  How do the environment structures differ for
;      the two versions?
; 
; {{{3 Solution
; 
; {{{1 3.2.4 Internal Definitions
; {{{2 Exercise 3.11:
; {{{3 Problem
;      In section *Note 3-2-3:: we saw how the
;      environment model described the behavior of procedures with local
;      state.  Now we have seen how internal definitions work.  A typical
;      message-passing procedure contains both of these aspects.
;      Consider the bank account procedure of section *Note 3-1-1:::
; 
;           (define (make-account balance)
;             (define (withdraw amount)
;               (if (>= balance amount)
;                   (begin (set! balance (- balance amount))
;                          balance)
;                   "Insufficient funds"))
;             (define (deposit amount)
;               (set! balance (+ balance amount))
;               balance)
;             (define (dispatch m)
;               (cond ((eq? m 'withdraw) withdraw)
;                     ((eq? m 'deposit) deposit)
;                     (else (error "Unknown request -- MAKE-ACCOUNT"
;                                  m))))
;             dispatch)
; 
;      Show the environment structure generated by the sequence of
;      interactions
; 
;           (define acc (make-account 50))
; 
;           ((acc 'deposit) 40)
;           90
; 
;           ((acc 'withdraw) 60)
;           30
; 
;      Where is the local state for `acc' kept?  Suppose we define another
;      account
; 
;           (define acc2 (make-account 100))
; 
;      How are the local states for the two accounts kept distinct?
;      Which parts of the environment structure are shared between `acc'
;      and `acc2'?
; 
; {{{3 Solution
; 
; {{{1 3.3.1 Mutable List Structure
; {{{2 Exercise 3.12:
; {{{3 Problem
;      The following procedure for appending lists was
;      introduced in section *Note 2-2-1:::
; 
;           (define (append x y)
;             (if (null? x)
;                 y
;                 (cons (car x) (append (cdr x) y))))
; 
;      `Append' forms a new list by successively `cons'ing the elements of
;      `x' onto `y'.  The procedure `append!' is similar to `append', but
;      it is a mutator rather than a constructor.  It appends the lists
;      by splicing them together, modifying the final pair of `x' so that
;      its `cdr' is now `y'.  (It is an error to call `append!' with an
;      empty `x'.)
; 
;           (define (append! x y)
;             (set-cdr! (last-pair x) y)
;             x)
; 
;      Here `last-pair' is a procedure that returns the last pair in its
;      argument:
; 
;           (define (last-pair x)
;             (if (null? (cdr x))
;                 x
;                 (last-pair (cdr x))))
; 
;      Consider the interaction
; 
;           (define x (list 'a 'b))
; 
;           (define y (list 'c 'd))
; 
;           (define z (append x y))
; 
;           z
;           (a b c d)
; 
;           (cdr x)
;           <RESPONSE>
; 
;           (define w (append! x y))
; 
;           w
;           (a b c d)
; 
;           (cdr x)
;           <RESPONSE>
; 
;      What are the missing <RESPONSE>s?  Draw box-and-pointer diagrams to
;      explain your answer.
; 
; {{{3 Solution
; {{{2 Exercise 3.13:
; {{{3 Problem
;      Consider the following `make-cycle' procedure,
;      which uses the `last-pair' procedure defined in *Note Exercise
;      3-12:::
; 
;           (define (make-cycle x)
;             (set-cdr! (last-pair x) x)
;             x)
; 
;      Draw a box-and-pointer diagram that shows the structure `z'
;      created by
; 
;           (define z (make-cycle (list 'a 'b 'c)))
; 
;      What happens if we try to compute `(last-pair z)'?
; 
; {{{3 Solution
; {{{2 Exercise 3.14:
; {{{3 Problem
;      The following procedure is quite useful, although
;      obscure:
; 
;           (define (mystery x)
;             (define (loop x y)
;               (if (null? x)
;                   y
;                   (let ((temp (cdr x)))
;                     (set-cdr! x y)
;                     (loop temp x))))
;             (loop x '()))
; 
;      `Loop' uses the "temporary" variable `temp' to hold the old value
;      of the `cdr' of `x', since the `set-cdr!'  on the next line
;      destroys the `cdr'.  Explain what `mystery' does in general.
;      Suppose `v' is defined by `(define v (list 'a 'b 'c 'd))'. Draw the
;      box-and-pointer diagram that represents the list to which `v' is
;      bound.  Suppose that we now evaluate `(define w (mystery v))'. Draw
;      box-and-pointer diagrams that show the structures `v' and `w' after
;      evaluating this expression.  What would be printed as the values
;      of `v' and `w'?
; 
; {{{3 Solution
; {{{2 Exercise 3.15:
; {{{3 Problem
;      Draw box-and-pointer diagrams to explain the
;      effect of `set-to-wow!' on the structures `z1' and `z2' above.
; 
; {{{3 Solution
; {{{2 Exercise 3.16:
; {{{3 Problem
;      Ben Bitdiddle decides to write a procedure to
;      count the number of pairs in any list structure.  "It's easy," he
;      reasons.  "The number of pairs in any structure is the number in
;      the `car' plus the number in the `cdr' plus one more to count the
;      current pair."  So Ben writes the following procedure:
; 
;           (define (count-pairs x)
;             (if (not (pair? x))
;                 0
;                 (+ (count-pairs (car x))
;                    (count-pairs (cdr x))
;                    1)))
; 
;      Show that this procedure is not correct.  In particular, draw
;      box-and-pointer diagrams representing list structures made up of
;      exactly three pairs for which Ben's procedure would return 3;
;      return 4; return 7; never return at all.
; 
; {{{3 Solution
; {{{2 Exercise 3.17:
; {{{3 Problem
;      Devise a correct version of the `count-pairs'
;      procedure of *Note Exercise 3-16:: that returns the number of
;      distinct pairs in any structure.  (Hint: Traverse the structure,
;      maintaining an auxiliary data structure that is used to keep track
;      of which pairs have already been counted.)
; 
; {{{3 Solution
; {{{2 Exercise 3.18:
; {{{3 Problem
;      Write a procedure that examines a list and
;      determines whether it contains a cycle, that is, whether a program
;      that tried to find the end of the list by taking successive `cdr's
;      would go into an infinite loop.  *Note Exercise 3-13:: constructed
;      such lists.
; 
; {{{3 Solution
; {{{2 Exercise 3.19:
; {{{3 Problem
;      Redo *Note Exercise 3-18:: using an algorithm
;      that takes only a constant amount of space.  (This requires a very
;      clever idea.)
; 
; {{{3 Solution
; {{{2 Exercise 3.20:
; {{{3 Problem
;      Draw environment diagrams to illustrate the
;      evaluation of the sequence of expressions
; 
;           (define x (cons 1 2))
;           (define z (cons x x))
;           (set-car! (cdr z) 17)
; 
;           (car x)
;           17
; 
;      using the procedural implementation of pairs given above.  (Compare
;      *Note Exercise 3-11::.)
; 
; {{{3 Solution
; 
; {{{1 3.3.2 Representing Queues
; {{{2 Exercise 3.21:
; {{{3 Problem
;      Ben Bitdiddle decides to test the queue
;      implementation described above.  He types in the procedures to the
;      Lisp interpreter and proceeds to try them out:
; 
;           (define q1 (make-queue))
; 
;           (insert-queue! q1 'a)
;           ((a) a)
; 
;           (insert-queue! q1 'b)
;           ((a b) b)
; 
;           (delete-queue! q1)
;           ((b) b)
; 
;           (delete-queue! q1)
;           (() b)
; 
;      "It's all wrong!" he complains.  "The interpreter's response shows
;      that the last item is inserted into the queue twice.  And when I
;      delete both items, the second `b' is still there, so the queue
;      isn't empty, even though it's supposed to be."  Eva Lu Ator
;      suggests that Ben has misunderstood what is happening.  "It's not
;      that the items are going into the queue twice," she explains.
;      "It's just that the standard Lisp printer doesn't know how to make
;      sense of the queue representation.  If you want to see the queue
;      printed correctly, you'll have to define your own print procedure
;      for queues." Explain what Eva Lu is talking about.  In particular,
;      show why Ben's examples produce the printed results that they do.
;      Define a procedure `print-queue' that takes a queue as input and
;      prints the sequence of items in the queue.
; 
; {{{3 Solution
; {{{2 Exercise 3.22:
; {{{3 Problem
;      Instead of representing a queue as a pair of
;      pointers, we can build a queue as a procedure with local state.
;      The local state will consist of pointers to the beginning and the
;      end of an ordinary list.  Thus, the `make-queue' procedure will
;      have the form
; 
;           (define (make-queue)
;             (let ((front-ptr ... )
;                   (rear-ptr ... ))
;               <DEFINITIONS OF INTERNAL PROCEDURES>
;               (define (dispatch m) ...)
;               dispatch))
; 
;      Complete the definition of `make-queue' and provide
;      implementations of the queue operations using this representation.
; 
; {{{3 Solution
; {{{2 Exercise 3.23:
; {{{3 Problem
;      A "deque" ("double-ended queue") is a sequence in
;      which items can be inserted and deleted at either the front or the
;      rear.  Operations on deques are the constructor `make-deque', the
;      predicate `empty-deque?', selectors `front-deque' and
;      `rear-deque', and mutators `front-insert-deque!',
;      `rear-insert-deque!', `front-delete-deque!', and
;      `rear-delete-deque!'.  Show how to represent deques using pairs,
;      and give implementations of the operations.(2)  All operations
;      should be accomplished in [theta](1) steps.
; 
; {{{1 3.3.3 Representing Tables
; {{{3 Solution
; {{{2 Exercise 3.24:
; {{{3 Problem
;      In the table implementations above, the keys are
;      tested for equality using `equal?' (called by `assoc').  This is
;      not always the appropriate test.  For instance, we might have a
;      table with numeric keys in which we don't need an exact match to
;      the number we're looking up, but only a number within some
;      tolerance of it.  Design a table constructor `make-table' that
;      takes as an argument a `same-key?' procedure that will be used to
;      test "equality" of keys.  `Make-table' should return a `dispatch'
;      procedure that can be used to access appropriate `lookup' and
;      `insert!' procedures for a local table.
; 
; {{{3 Solution
; {{{2 Exercise 3.25:
; {{{3 Problem
;      Generalizing one- and two-dimensional tables,
;      show how to implement a table in which values are stored under an
;      arbitrary number of keys and different values may be stored under
;      different numbers of keys.  The `lookup' and `insert!' procedures
;      should take as input a list of keys used to access the table.
; 
; {{{3 Solution
; {{{2 Exercise 3.26:
; {{{3 Problem
;      To search a table as implemented above, one needs
;      to scan through the list of records.  This is basically the
;      unordered list representation of section *Note 2-3-3::.  For large
;      tables, it may be more efficient to structure the table in a
;      different manner.  Describe a table implementation where the (key,
;      value) records are organized using a binary tree, assuming that
;      keys can be ordered in some way (e.g., numerically or
;      alphabetically).  (Compare *Note Exercise 2-66:: of *Note Chapter
;      2::.)
; 
; {{{3 Solution
; {{{2 Exercise 3.27:
; {{{3 Problem
;      "Memoization" (also called "tabulation") is a
;      technique that enables a procedure to record, in a local table,
;      values that have previously been computed.  This technique can
;      make a vast difference in the performance of a program.  A memoized
;      procedure maintains a table in which values of previous calls are
;      stored using as keys the arguments that produced the values.  When
;      the memoized procedure is asked to compute a value, it first
;      checks the table to see if the value is already there and, if so,
;      just returns that value.  Otherwise, it computes the new value in
;      the ordinary way and stores this in the table.  As an example of
;      memoization, recall from section *Note 1-2-2:: the exponential
;      process for computing Fibonacci numbers:
; 
;           (define (fib n)
;             (cond ((= n 0) 0)
;                   ((= n 1) 1)
;                   (else (+ (fib (- n 1))
;                            (fib (- n 2))))))
; 
;      The memoized version of the same procedure is
; 
;           (define memo-fib
;             (memoize (lambda (n)
;                        (cond ((= n 0) 0)
;                              ((= n 1) 1)
;                              (else (+ (memo-fib (- n 1))
;                                       (memo-fib (- n 2))))))))
; 
;      where the memoizer is defined as
; 
;           (define (memoize f)
;             (let ((table (make-table)))
;               (lambda (x)
;                 (let ((previously-computed-result (lookup x table)))
;                   (or previously-computed-result
;                       (let ((result (f x)))
;                         (insert! x result table)
;                         result))))))
; 
;      Draw an environment diagram to analyze the computation of
;      `(memo-fib 3)'.  Explain why `memo-fib' computes the nth Fibonacci
;      number in a number of steps proportional to n.  Would the scheme
;      still work if we had simply defined `memo-fib' to be `(memoize
;      fib)'?
; 
; {{{3 Solution
; 
; {{{1 3.3.4 A Simulator for Digital Circuits
; {{{2 Exercise 3.28:
; {{{3 Problem
;      Define an or-gate as a primitive function box.
;      Your `or-gate' constructor should be similar to `and-gate'.
; 
; {{{3 Solution
; {{{2 Exercise 3.29:
; {{{3 Problem
;      Another way to construct an or-gate is as a
;      compound digital logic device, built from and-gates and inverters.
;      Define a procedure `or-gate' that accomplishes this.  What is the
;      delay time of the or-gate in terms of `and-gate-delay' and
;      `inverter-delay'?
; 
; {{{3 Solution
; {{{2 Exercise 3.30:
; {{{3 Problem
;      *Note Figure 3-27:: shows a "ripple-carry adder"
;      formed by stringing together n full-adders.  This is the simplest
;      form of parallel adder for adding two n-bit binary numbers.  The
;      inputs A_1, A_2, A_3, ..., A_n and B_1, B_2, B_3, ..., B_n are the
;      two binary numbers to be added (each A_k and B_k is a 0 or a 1).
;      The circuit generates S_1, S_2, S_3, ..., S_n, the n bits of the
;      sum, and C, the carry from the addition.  Write a procedure
;      `ripple-carry-adder' that generates this circuit.  The procedure
;      should take as arguments three lists of n wires each--the A_k, the
;      B_k, and the S_k--and also another wire C.  The major drawback of
;      the ripple-carry adder is the need to wait for the carry signals
;      to propagate.  What is the delay needed to obtain the complete
;      output from an n-bit ripple-carry adder, expressed in terms of the
;      delays for and-gates, or-gates, and inverters?
; 
;      *Figure 3.27:* A ripple-carry adder for n-bit numbers.
; 
;              :                                              :   :
;              : A_1 B_1   C_1   A_2 B_2   C_2   A_3 B_3   C_3:   : A_n B_n C_n=0
;              :  |   |   +---+   |   |   +---+   |   |   +-----  :  |   |   +-
;              |  |   |   |   |   |   |   |   |   |   |   |   :   :  |   |   |
;              : ++---+---++  |  ++---+---++  |  ++---+---++  :   : ++---+---++
;              : |   FA    |  |  |   FA    |  |  |   FA    |  :   : |   FA    |
;              : +--+---+--+  |  +--+---+--+  |  +--+---+--+  :   : +--+---+--+
;              :    |   |     |     |   |     |     |   |     :   :    |   |
;           C ------+   |     +-----+   |     +-----+   |     :  ------+   |
;              :        |       C_1     |       C_2     |     :   :C_(n-1) |
;              :        |               |               |     :   :        |
;                      S_1             S_2             S_3                S_n
; 
; {{{3 Solution
; {{{2 Exercise 3.31:
; {{{3 Problem
;      The internal procedure `accept-action-procedure!'
;      defined in `make-wire' specifies that when a new action procedure
;      is added to a wire, the procedure is immediately run.  Explain why
;      this initialization is necessary.  In particular, trace through the
;      half-adder example in the paragraphs above and say how the
;      system's response would differ if we had defined
;      `accept-action-procedure!' as
; 
;           (define (accept-action-procedure! proc)
;             (set! action-procedures (cons proc action-procedures)))
; 
; {{{3 Solution
; {{{2 Exercise 3.32:
; {{{3 Problem
;      The procedures to be run during each time segment
;      of the agenda are kept in a queue.  Thus, the procedures for each
;      segment are called in the order in which they were added to the
;      agenda (first in, first out).  Explain why this order must be
;      used.  In particular, trace the behavior of an and-gate whose
;      inputs change from 0,1 to 1,0 in the same segment and say how the
;      behavior would differ if we stored a segment's procedures in an
;      ordinary list, adding and removing procedures only at the front
;      (last in, first out).
; 
; {{{3 Solution
; {{{1 3.3.5 Propagation of Constraints
; {{{2 Exercise 3.33:
; {{{3 Problem
;      Using primitive multiplier, adder, and constant
;      constraints, define a procedure `averager' that takes three
;      connectors `a', `b', and `c' as inputs and establishes the
;      constraint that the value of `c' is the average of the values of
;      `a' and `b'.
; 
; {{{3 Solution
; {{{2 Exercise 3.34:
; {{{3 Problem
;      Louis Reasoner wants to build a squarer, a
;      constraint device with two terminals such that the value of
;      connector `b' on the second terminal will always be the square of
;      the value `a' on the first terminal.  He proposes the following
;      simple device made from a multiplier:
; 
;           (define (squarer a b)
;             (multiplier a a b))
; 
;      There is a serious flaw in this idea.  Explain.
; 
; {{{3 Solution
; {{{2 Exercise 3.35:
; {{{3 Problem
;      Ben Bitdiddle tells Louis that one way to avoid
;      the trouble in *Note Exercise 3-34:: is to define a squarer as a
;      new primitive constraint.  Fill in the missing portions in Ben's
;      outline for a procedure to implement such a constraint:
; 
;           (define (squarer a b)
;             (define (process-new-value)
;               (if (has-value? b)
;                   (if (< (get-value b) 0)
;                       (error "square less than 0 -- SQUARER" (get-value b))
;                       <ALTERNATIVE1>)
;                   <ALTERNATIVE2>))
;             (define (process-forget-value) <BODY1>)
;             (define (me request) <BODY2>)
;             <REST OF DEFINITION>
;             me)
; 
; {{{3 Solution
; {{{2 Exercise 3.36:
; {{{3 Problem
;      Suppose we evaluate the following sequence of
;      expressions in the global environment:
; 
;           (define a (make-connector))
;           (define b (make-connector))
;           (set-value! a 10 'user)
; 
;      At some time during evaluation of the `set-value!', the following
;      expression from the connector's local procedure is evaluated:
; 
;           (for-each-except setter inform-about-value constraints)
; 
;      Draw an environment diagram showing the environment in which the
;      above expression is evaluated.
; 
; {{{3 Solution
; {{{2 Exercise 3.37:
; {{{3 Problem
;      The `celsius-fahrenheit-converter' procedure is
;      cumbersome when compared with a more expression-oriented style of
;      definition, such as
; 
;           (define (celsius-fahrenheit-converter x)
;             (c+ (c* (c/ (cv 9) (cv 5))
;                     x)
;                 (cv 32)))
; 
;           (define C (make-connector))
;           (define F (celsius-fahrenheit-converter C))
; 
;      Here `c+', `c*', etc. are the "constraint" versions of the
;      arithmetic operations.  For example, `c+' takes two connectors as
;      arguments and returns a connector that is related to these by an
;      adder constraint:
; 
;           (define (c+ x y)
;             (let ((z (make-connector)))
;               (adder x y z)
;               z))
; 
;      Define analogous procedures `c-', `c*', `c/', and `cv' (constant
;      value) that enable us to define compound constraints as in the
;      converter example above.(3)
; 
; {{{3 Solution
; 
; {{{1 3.4.1 The Nature of Time in Concurrent Systems
; {{{2 Exercise 3.38:
; {{{3 Problem
;      Suppose that Peter, Paul, and Mary share a joint
;      bank account that initially contains $100.  Concurrently, Peter
;      deposits $10, Paul withdraws $20, and Mary withdraws half the
;      money in the account, by executing the following commands:
; 
;           Peter: (set! balance (+ balance 10))
;           Paul:  (set! balance (- balance 20))
;           Mary:  (set! balance (- balance (/ balance 2)))
; 
;        a. List all the different possible values for `balance' after
;           these three transactions have been completed, assuming that
;           the banking system forces the three processes to run
;           sequentially in some order.
; 
;        b. What are some other values that could be produced if the
;           system allows the processes to be interleaved?  Draw timing
;           diagrams like the one in *Note Figure 3-29:: to explain how
;           these values can occur.
; 
; {{{3 Solution
; 
; {{{1 3.4.2 Mechanisms for Controlling Concurrency
; {{{2 Exercise 3.39:
; {{{3 Problem
;      Which of the five possibilities in the parallel
;      execution shown above remain if we instead serialize execution as
;      follows:
; 
;           (define x 10)
; 
;           (define s (make-serializer))
; 
;           (parallel-execute (lambda () (set! x ((s (lambda () (* x x))))))
;                             (s (lambda () (set! x (+ x 1)))))
; 
; {{{3 Solution
; {{{2 Exercise 3.40:
; {{{3 Problem
;      Give all possible values of `x' that can result
;      from executing
; 
;           (define x 10)
; 
;           (parallel-execute (lambda () (set! x (* x x)))
;                             (lambda () (set! x (* x x x))))
; 
;      Which of these possibilities remain if we instead use serialized
;      procedures:
; 
;           (define x 10)
; 
;           (define s (make-serializer))
; 
;           (parallel-execute (s (lambda () (set! x (* x x))))
;                             (s (lambda () (set! x (* x x x)))))
; 
; {{{3 Solution
; {{{2 Exercise 3.41:
; {{{3 Problem
;      Ben Bitdiddle worries that it would be better to
;      implement the bank account as follows (where the commented line
;      has been changed):
; 
;           (define (make-account balance)
;             (define (withdraw amount)
;               (if (>= balance amount)
;                   (begin (set! balance (- balance amount))
;                          balance)
;                   "Insufficient funds"))
;             (define (deposit amount)
;               (set! balance (+ balance amount))
;               balance)
;             ;; continued on next page
; 
;             (let ((protected (make-serializer)))
;               (define (dispatch m)
;                 (cond ((eq? m 'withdraw) (protected withdraw))
;                       ((eq? m 'deposit) (protected deposit))
;                       ((eq? m 'balance)
;                        ((protected (lambda () balance)))) ; serialized
;                       (else (error "Unknown request -- MAKE-ACCOUNT"
;                                    m))))
;               dispatch))
; 
;      because allowing unserialized access to the bank balance can
;      result in anomalous behavior.  Do you agree?  Is there any
;      scenario that demonstrates Ben's concern?
; 
; {{{3 Solution
; {{{2 Exercise 3.42:
; {{{3 Problem
;      Ben Bitdiddle suggests that it's a waste of time
;      to create a new serialized procedure in response to every
;      `withdraw' and `deposit' message.  He says that `make-account'
;      could be changed so that the calls to `protected' are done outside
;      the `dispatch' procedure.  That is, an account would return the
;      same serialized procedure (which was created at the same time as
;      the account) each time it is asked for a withdrawal procedure.
; 
;           (define (make-account balance)
;             (define (withdraw amount)
;               (if (>= balance amount)
;                   (begin (set! balance (- balance amount))
;                          balance)
;                   "Insufficient funds"))
;             (define (deposit amount)
;               (set! balance (+ balance amount))
;               balance)
;             (let ((protected (make-serializer)))
;               (let ((protected-withdraw (protected withdraw))
;                     (protected-deposit (protected deposit)))
;                 (define (dispatch m)
;                   (cond ((eq? m 'withdraw) protected-withdraw)
;                         ((eq? m 'deposit) protected-deposit)
;                         ((eq? m 'balance) balance)
;                         (else (error "Unknown request -- MAKE-ACCOUNT"
;                                      m))))
;                 dispatch)))
; 
;      Is this a safe change to make?  In particular, is there any
;      difference in what concurrency is allowed by these two versions of
;      `make-account' ?
; 
; {{{3 Solution
; {{{2 Exercise 3.43:
; {{{3 Problem
;      Suppose that the balances in three accounts start
;      out as $10, $20, and $30, and that multiple processes run,
;      exchanging the balances in the accounts.  Argue that if the
;      processes are run sequentially, after any number of concurrent
;      exchanges, the account balances should be $10, $20, and $30 in
;      some order.  Draw a timing diagram like the one in *Note Figure
;      3-29:: to show how this condition can be violated if the exchanges
;      are implemented using the first version of the account-exchange
;      program in this section.  On the other hand, argue that even with
;      this `exchange' program, the sum of the balances in the accounts
;      will be preserved.  Draw a timing diagram to show how even this
;      condition would be violated if we did not serialize the
;      transactions on individual accounts.
; 
; {{{3 Solution
; {{{2 Exercise 3.44:
; {{{3 Problem
;      Consider the problem of transferring an amount
;      from one account to another.  Ben Bitdiddle claims that this can
;      be accomplished with the following procedure, even if there are
;      multiple people concurrently transferring money among multiple
;      accounts, using any account mechanism that serializes deposit and
;      withdrawal transactions, for example, the version of
;      `make-account' in the text above.
; 
;           (define (transfer from-account to-account amount)
;             ((from-account 'withdraw) amount)
;             ((to-account 'deposit) amount))
; 
;      Louis Reasoner claims that there is a problem here, and that we
;      need to use a more sophisticated method, such as the one required
;      for dealing with the exchange problem.  Is Louis right?  If not,
;      what is the essential difference between the transfer problem and
;      the exchange problem?  (You should assume that the balance in
;      `from-account' is at least `amount'.)
; 
; {{{3 Solution
; {{{2 Exercise 3.45:
; {{{3 Problem
;      Louis Reasoner thinks our bank-account system is
;      unnecessarily complex and error-prone now that deposits and
;      withdrawals aren't automatically serialized.  He suggests that
;      `make-account-and-serializer' should have exported the serializer
;      (for use by such procedures as `serialized-exchange') in addition
;      to (rather than instead of) using it to serialize accounts and
;      deposits as `make-account' did.  He proposes to redefine accounts
;      as follows:
; 
;           (define (make-account-and-serializer balance)
;             (define (withdraw amount)
;               (if (>= balance amount)
;                   (begin (set! balance (- balance amount))
;                          balance)
;                   "Insufficient funds"))
;             (define (deposit amount)
;               (set! balance (+ balance amount))
;               balance)
;             (let ((balance-serializer (make-serializer)))
;               (define (dispatch m)
;                 (cond ((eq? m 'withdraw) (balance-serializer withdraw))
;                       ((eq? m 'deposit) (balance-serializer deposit))
;                       ((eq? m 'balance) balance)
;                       ((eq? m 'serializer) balance-serializer)
;                       (else (error "Unknown request -- MAKE-ACCOUNT"
;                                    m))))
;               dispatch))
; 
;      Then deposits are handled as with the original `make-account':
; 
;           (define (deposit account amount)
;            ((account 'deposit) amount))
; 
;      Explain what is wrong with Louis's reasoning.  In particular,
;      consider what happens when `serialized-exchange' is called.
; 
; {{{3 Solution
; {{{2 Exercise 3.46:
; {{{3 Problem
;      Suppose that we implement `test-and-set!'  using
;      an ordinary procedure as shown in the text, without attempting to
;      make the operation atomic.  Draw a timing diagram like the one in
;      *Note Figure 3-29:: to demonstrate how the mutex implementation
;      can fail by allowing two processes to acquire the mutex at the
;      same time.
; 
; {{{3 Solution
; {{{2 Exercise 3.47:
; {{{3 Problem
;      A semaphore (of size n) is a generalization of a
;      mutex.  Like a mutex, a semaphore supports acquire and release
;      operations, but it is more general in that up to n processes can
;      acquire it concurrently.  Additional processes that attempt to
;      acquire the semaphore must wait for release operations.  Give
;      implementations of semaphores
; 
;        a. in terms of mutexes
; 
;        b. in terms of atomic `test-and-set!' operations.
; 
; {{{3 Solution
; {{{2 Exercise 3.48:
; {{{3 Problem
;      Explain in detail why the deadlock-avoidance
;      method described above, (i.e., the accounts are numbered, and each
;      process attempts to acquire the smaller-numbered account first)
;      avoids deadlock in the exchange problem.  Rewrite
;      `serialized-exchange' to incorporate this idea.  (You will also
;      need to modify `make-account' so that each account is created with
;      a number, which can be accessed by sending an appropriate message.)
; 
; {{{3 Solution
; {{{2 Exercise 3.49:
; {{{3 Problem
;      Give a scenario where the deadlock-avoidance
;      mechanism described above does not work.  (Hint: In the exchange
;      problem, each process knows in advance which accounts it will need
;      to get access to.  Consider a situation where a process must get
;      access to some shared resources before it can know which
;      additional shared resources it will require.)
; 
; {{{3 Solution
; 
; {{{1 3.5.1 Streams Are Delayed Lists
; {{{2 Exercise 3.50:
; {{{3 Problem
;      Complete the following definition, which
;      generalizes `stream-map' to allow procedures that take multiple
;      arguments, analogous to `map' in section *Note 2-2-3::, footnote
;      *Note Footnote 12::.
; 
;           (define (stream-map proc . argstreams)
;             (if (<??> (car argstreams))
;                 the-empty-stream
;                 (<??>
;                  (apply proc (map <??> argstreams))
;                  (apply stream-map
;                         (cons proc (map <??> argstreams))))))
; 
; {{{3 Solution
; {{{2 Exercise 3.51:
; {{{3 Problem
;      In order to take a closer look at delayed
;      evaluation, we will use the following procedure, which simply
;      returns its argument after printing it:
; 
;           (define (show x)
;             (display-line x)
;             x)
; 
;      What does the interpreter print in response to evaluating each
;      expression in the following sequence?(7)
; 
;           (define x (stream-map show (stream-enumerate-interval 0 10)))
; 
;           (stream-ref x 5)
; 
;           (stream-ref x 7)
; 
; {{{3 Solution
; {{{2 Exercise 3.52:
; {{{3 Problem
;      Consider the sequence of expressions
; 
;           (define sum 0)
; 
;           (define (accum x)
;             (set! sum (+ x sum))
;             sum)
; 
;           (define seq (stream-map accum (stream-enumerate-interval 1 20)))
;           (define y (stream-filter even? seq))
;           (define z (stream-filter (lambda (x) (= (remainder x 5) 0))
;                                    seq))
; 
;           (stream-ref y 7)
; 
;           (display-stream z)
; 
;      What is the value of `sum' after each of the above expressions is
;      evaluated?  What is the printed response to evaluating the
;      `stream-ref' and `display-stream' expressions?  Would these
;      responses differ if we had implemented `(delay <EXP>)' simply as
;      `(lambda () <EXP>)' without using the optimization provided by
;      `memo-proc'?  Explain
; 
; {{{3 Solution
; 
; {{{1 3.5.2 Infinite Streams
; {{{3 Solution
; {{{2 Exercise 3.53:
; {{{3 Problem
;      Without running the program, describe the
;      elements of the stream defined by
; 
;           (define s (cons-stream 1 (add-streams s s)))
; 
; {{{3 Solution
; {{{2 Exercise 3.54:
; {{{3 Problem
;      Define a procedure `mul-streams', analogous to
;      `add-streams', that produces the elementwise product of its two
;      input streams.  Use this together with the stream of `integers' to
;      complete the following definition of the stream whose nth element
;      (counting from 0) is n + 1 factorial:
; 
;           (define factorials (cons-stream 1 (mul-streams <??> <??>)))
; 
; {{{3 Solution
; {{{2 Exercise 3.55:
; {{{3 Problem
;      Define a procedure `partial-sums' that takes as
;      argument a stream S and returns the stream whose elements are S_0,
;      S_0 + S_1, S_0 + S_1 + S_2, ....  For example, `(partial-sums
;      integers)' should be the stream 1, 3, 6, 10, 15, ....
; 
; {{{3 Solution
; {{{2 Exercise 3.56:
; {{{3 Problem
;      A famous problem, first raised by R. Hamming, is
;      to enumerate, in ascending order with no repetitions, all positive
;      integers with no prime factors other than 2, 3, or 5.  One obvious
;      way to do this is to simply test each integer in turn to see
;      whether it has any factors other than 2, 3, and 5.  But this is
;      very inefficient, since, as the integers get larger, fewer and
;      fewer of them fit the requirement.  As an alternative, let us call
;      the required stream of numbers `S' and notice the following facts
;      about it.
; 
;         * `S' begins with 1.
; 
;         * The elements of `(scale-stream S 2)' are also elements of `S'.
; 
;         * The same is true for `(scale-stream S 3)' and `(scale-stream
;           5 S)'.
; 
;         * These are all the elements of `S'.
; 
; 
;      Now all we have to do is combine elements from these sources.  For
;      this we define a procedure `merge' that combines two ordered
;      streams into one ordered result stream, eliminating repetitions:
; 
;           (define (merge s1 s2)
;             (cond ((stream-null? s1) s2)
;                   ((stream-null? s2) s1)
;                   (else
;                    (let ((s1car (stream-car s1))
;                          (s2car (stream-car s2)))
;                      (cond ((< s1car s2car)
;                             (cons-stream s1car (merge (stream-cdr s1) s2)))
;                            ((> s1car s2car)
;                             (cons-stream s2car (merge s1 (stream-cdr s2))))
;                            (else
;                             (cons-stream s1car
;                                          (merge (stream-cdr s1)
;                                                 (stream-cdr s2)))))))))
; 
;      Then the required stream may be constructed with `merge', as
;      follows:
; 
;           (define S (cons-stream 1 (merge <??> <??>)))
; 
;      Fill in the missing expressions in the places marked <??> above.
; 
; {{{3 Solution
; {{{2 Exercise 3.57:
; {{{3 Problem
;      How many additions are performed when we compute
;      the nth Fibonacci number using the definition of `fibs' based on
;      the `add-streams' procedure?  Show that the number of additions
;      would be exponentially greater if we had implemented `(delay
;      <EXP>)' simply as `(lambda () <EXP>)', without using the
;      optimization provided by the `memo-proc' procedure described in
;      section *Note 3-5-1::.(5)
; 
; {{{3 Solution
; {{{2 Exercise 3.58:
; {{{3 Problem
;      Give an interpretation of the stream computed by
;      the following procedure:
; 
;           (define (expand num den radix)
;             (cons-stream
;              (quotient (* num radix) den)
;              (expand (remainder (* num radix) den) den radix)))
; 
;      (`Quotient' is a primitive that returns the integer quotient of two
;      integers.)  What are the successive elements produced by `(expand
;      1 7 10)'?  What is produced by `(expand 3 8 10)'?
; 
; {{{3 Solution
; {{{2 Exercise 3.59:
; {{{3 Problem
;      In section *Note 2-5-3:: we saw how to implement
;      a polynomial arithmetic system representing polynomials as lists
;      of terms.  In a similar way, we can work with "power series", such
;      as
; 
;                          x^2     x^3       x^4
;           e^x = 1 + x + ----- + ----- + --------- + ...
;                           2     3 * 2   4 * 3 * 2
; 
;                        x^2       x^4
;           cos x = 1 - ----- + --------- - ...
;                         2     4 * 3 * 2
; 
;                        x^3         x^5
;           sin x = x - ----- + ------------- - ...
;                       3 * 2   5 * 4 * 3 * 2
; 
;      represented as infinite streams.  We will represent the series a_0
;      + a_1 x + a_2 x^2 + a_3 x^3 + ... as the stream whose elements are
;      the coefficients a_0, a_1, a_2, a_3, ....
; 
;        a. The integral of the series a_0 + a_1 x + a_2 x^2 + a_3 x^3 +
;           ... is the series
; 
;                             1             1             1
;                c + a_0 x + --- x_1 r^2 + --- a_2 r^3 + --- a_3 r^4 + ...
;                             2             3             4
; 
;           where c is any constant.  Define a procedure
;           `integrate-series' that takes as input a stream a_0, a_1,
;           a_2, ... representing a power series and returns the stream
;           a_0, (1/2)a_1, (1/3)a_2, ... of coefficients of the
;           non-constant terms of the integral of the series.  (Since the
;           result has no constant term, it doesn't represent a power
;           series; when we use `integrate-series', we will `cons' on the
;           appropriate constant.)
; 
;        b. The function x |-> e^x is its own derivative.  This implies
;           that e^x and the integral of e^x are the same series, except
;           for the constant term, which is e^0 = 1.  Accordingly, we can
;           generate the series for e^x as
; 
;                (define exp-series
;                  (cons-stream 1 (integrate-series exp-series)))
; 
;           Show how to generate the series for sine and cosine, starting
;           from the facts that the derivative of sine is cosine and the
;           derivative of cosine is the negative of sine:
; 
;                (define cosine-series
;                  (cons-stream 1 <??>))
; 
;                (define sine-series
;                  (cons-stream 0 <??>))
; 
; {{{3 Solution
; {{{2 Exercise 3.60:
; {{{3 Problem
;      With power series represented as streams of
;      coefficients as in *Note Exercise 3-59::, adding series is
;      implemented by `add-streams'.  Complete the definition of the
;      following procedure for multiplying series:
; 
;           (define (mul-series s1 s2)
;             (cons-stream <??> (add-streams <??> <??>)))
; 
;      You can test your procedure by verifying that sin^2 x + cos^2 x =
;      1, using the series from *Note Exercise 3-59::.
; 
; {{{3 Solution
; {{{2 Exercise 3.61:
; {{{3 Problem
;      Let S be a power series (*Note Exercise 3-59::)
;      whose constant term is 1.  Suppose we want to find the power
;      series 1/S, that is, the series X such that S * X = 1.  Write S =
;      1 + S_R where S_R is the part of S after the constant term.  Then
;      we can solve for X as follows:
; 
;                   S * X = 1
;           (1 + S_R) * X = 1
;             X + S_R * X = 1
;                       X = 1 - S_R * X
; 
;      In other words, X is the power series whose constant term is 1 and
;      whose higher-order terms are given by the negative of S_R times X.
;      Use this idea to write a procedure `invert-unit-series' that
;      computes 1/S for a power series S with constant term 1.  You will
;      need to use `mul-series' from *Note Exercise 3-60::.
; 
; {{{3 Solution
; {{{2 Exercise 3.62:
; {{{3 Problem
;      Use the results of *Note Exercise 3-60:: and
;      *Note Exercise 3-61:: to define a procedure `div-series' that
;      divides two power series.  `Div-series' should work for any two
;      series, provided that the denominator series begins with a nonzero
;      constant term.  (If the denominator has a zero constant term, then
;      `div-series' should signal an error.)  Show how to use
;      `div-series' together with the result of *Note Exercise 3-59:: to
;      generate the power series for tangent.
; 
; {{{3 Solution
; 
; {{{1 3.5.3 Exploiting the Stream Paradigm
; {{{2 Exercise 3.63:
; {{{3 Problem
;      Louis Reasoner asks why the `sqrt-stream'
;      procedure was not written in the following more straightforward
;      way, without the local variable `guesses':
; 
;           (define (sqrt-stream x)
;             (cons-stream 1.0
;                          (stream-map (lambda (guess)
;                                        (sqrt-improve guess x))
;                                      (sqrt-stream x))))
; 
;      Alyssa P. Hacker replies that this version of the procedure is
;      considerably less efficient because it performs redundant
;      computation.  Explain Alyssa's answer.  Would the two versions
;      still differ in efficiency if our implementation of `delay' used
;      only `(lambda () <EXP>)' without using the optimization provided
;      by `memo-proc' (section *Note 3-5-1::)?
; 
; {{{3 Solution
; {{{2 Exercise 3.64:
; {{{3 Problem
;      Write a procedure `stream-limit' that takes as
;      arguments a stream and a number (the tolerance).  It should
;      examine the stream until it finds two successive elements that
;      differ in absolute value by less than the tolerance, and return
;      the second of the two elements.  Using this, we could compute
;      square roots up to a given tolerance by
; 
;           (define (sqrt x tolerance)
;             (stream-limit (sqrt-stream x) tolerance))
; 
; {{{3 Solution
; {{{2 Exercise 3.65:
; {{{3 Problem
;      Use the series
; 
;                       1     1     1
;           ln 2 = 1 - --- + --- - --- + ...
;                       2     3     4
; 
;      to compute three sequences of approximations to the natural
;      logarithm of 2, in the same way we did above for [pi].  How
;      rapidly do these sequences converge?
; 
; {{{3 Solution
; {{{2 Exercise 3.66:
; {{{3 Problem
;      Examine the stream `(pairs integers integers)'.
;      Can you make any general comments about the order in which the
;      pairs are placed into the stream? For example, about how many
;      pairs precede the pair (1,100)?  the pair (99,100)? the pair
;      (100,100)? (If you can make precise mathematical statements here,
;      all the better. But feel free to give more qualitative answers if
;      you find yourself getting bogged down.)
; 
; {{{3 Solution
; {{{2 Exercise 3.67:
; {{{3 Problem
;      Modify the `pairs' procedure so that `(pairs
;      integers integers)' will produce the stream of _all_ pairs of
;      integers (i,j) (without the condition i <= j).  Hint: You will
;      need to mix in an additional stream.
; 
; {{{3 Solution
; {{{2 Exercise 3.68:
; {{{3 Problem
;      Louis Reasoner thinks that building a stream of
;      pairs from three parts is unnecessarily complicated.  Instead of
;      separating the pair (S_0,T_0) from the rest of the pairs in the
;      first row, he proposes to work with the whole first row, as
;      follows:
; 
;           (define (pairs s t)
;             (interleave
;              (stream-map (lambda (x) (list (stream-car s) x))
;                          t)
;              (pairs (stream-cdr s) (stream-cdr t))))
; 
;      Does this work?  Consider what happens if we evaluate `(pairs
;      integers integers)' using Louis's definition of `pairs'.
; 
; {{{3 Solution
; {{{2 Exercise 3.69:
; {{{3 Problem
;      Write a procedure `triples' that takes three
;      infinite streams, S, T, and U, and produces the stream of triples
;      (S_i,T_j,U_k) such that i <= j <= k.  Use `triples' to generate
;      the stream of all Pythagorean triples of positive integers, i.e.,
;      the triples (i,j,k) such that i <= j and i^2 + j^2 = k^2.
; 
; {{{3 Solution
; {{{2 Exercise 3.70:
; {{{3 Problem
;      It would be nice to be able to generate streams
;      in which the pairs appear in some useful order, rather than in the
;      order that results from an _ad hoc_ interleaving process.  We can
;      use a technique similar to the `merge' procedure of *Note Exercise
;      3-56::, if we define a way to say that one pair of integers is
;      "less than" another.  One way to do this is to define a "weighting
;      function" W(i,j) and stipulate that (i_1,j_1) is less than
;      (i_2,j_2) if W(i_1,j_1) < W(i_2,j_2).  Write a procedure
;      `merge-weighted' that is like `merge', except that
;      `merge-weighted' takes an additional argument `weight', which is a
;      procedure that computes the weight of a pair, and is used to
;      determine the order in which elements should appear in the
;      resulting merged stream.(5)  Using this, generalize `pairs' to a
;      procedure `weighted-pairs' that takes two streams, together with a
;      procedure that computes a weighting function, and generates the
;      stream of pairs, ordered according to weight.  Use your procedure
;      to generate
; 
;        a. the stream of all pairs of positive integers (i,j) with i <= j
;           ordered according to the sum i + j
; 
;        b. the stream of all pairs of positive integers (i,j) with i <=
;           j, where neither i nor j is divisible by 2, 3, or 5, and the
;           pairs are ordered according to the sum 2 i + 3 j + 5 i j.
; 
; {{{3 Solution
; {{{2 Exercise 3.71:
; {{{3 Problem
;      Numbers that can be expressed as the sum of two
;      cubes in more than one way are sometimes called "Ramanujan
;      numbers", in honor of the mathematician Srinivasa Ramanujan.(6)
;      Ordered streams of pairs provide an elegant solution to the
;      problem of computing these numbers.  To find a number that can be
;      written as the sum of two cubes in two different ways, we need
;      only generate the stream of pairs of integers (i,j) weighted
;      according to the sum i^3 + j^3 (see *Note Exercise 3-70::), then
;      search the stream for two consecutive pairs with the same weight.
;      Write a procedure to generate the Ramanujan numbers.  The first
;      such number is 1,729.  What are the next five?
; 
; {{{3 Solution
; {{{2 Exercise 3.72:
; {{{3 Problem
;      In a similar way to *Note Exercise 3-71::
;      generate a stream of all numbers that can be written as the sum of
;      two squares in three different ways (showing how they can be so
;      written).
; 
; {{{3 Solution
; {{{2 Exercise 3.73:
; {{{3 Problem
;      We can model electrical circuits using streams to
;      represent the values of currents or voltages at a sequence of
;      times.  For instance, suppose we have an "RC circuit" consisting
;      of a resistor of resistance R and a capacitor of capacitance C in
;      series.  The voltage response v of the circuit to an injected
;      current i is determined by the formula in *Note Figure 3-33::,
;      whose structure is shown by the accompanying signal-flow diagram.
; 
;      Write a procedure `RC' that models this circuit.  `RC' should take
;      as inputs the values of R, C, and dt and should return a procedure
;      that takes as inputs a stream representing the current i and an
;      initial value for the capacitor voltage v_0 and produces as output
;      the stream of voltages v.  For example, you should be able to use
;      `RC' to model an RC circuit with R = 5 ohms, C = 1 farad, and a
;      0.5-second time step by evaluating `(define RC1 (RC 5 1 0.5))'.
;      This defines `RC1' as a procedure that takes a stream representing
;      the time sequence of currents and an initial capacitor voltage and
;      produces the output stream of voltages.
; 
;      *Figure 3.33:* An RC circuit and the associated signal-flow
;      diagram.
; 
;             +                 -
;            ->----'\/\/\,---| |---
;             i                 C
; 
;                         / t
;                         |  i
;            v  =  v   +  |      dt + R i
;                   0     |
;                         / 0
; 
;                    +--------------+
;                +-->|   scale: R   |---------------------+   |\_
;                |   +--------------+                     |   |  \_
;                |                                        +-->|    \   v
;             i  |   +--------------+     +------------+      | add >--->
;            ----+-->|  scale: 1/C  |---->|  integral  |----->|   _/
;                    +--------------+     +------------+      | _/
;                                                             |/
; 
; {{{3 Solution
; {{{2 Exercise 3.74:
; {{{3 Problem
;      Alyssa P. Hacker is designing a system to process
;      signals coming from physical sensors.  One important feature she
;      wishes to produce is a signal that describes the "zero crossings"
;      of the input signal.  That is, the resulting signal should be + 1
;      whenever the input signal changes from negative to positive, - 1
;      whenever the input signal changes from positive to negative, and 0
;      otherwise.  (Assume that the sign of a 0 input is positive.)  For
;      example, a typical input signal with its associated zero-crossing
;      signal would be
; 
;           ... 1  2  1.5  1  0.5  -0.1  -2  -3  -2  -0.5  0.2  3  4 ...
;           ...  0  0    0  0    0     -1  0   0   0     0    1  0  0 ...
; 
;      In Alyssa's system, the signal from the sensor is represented as a
;      stream `sense-data' and the stream `zero-crossings' is the
;      corresponding stream of zero crossings.  Alyssa first writes a
;      procedure `sign-change-detector' that takes two values as
;      arguments and compares the signs of the values to produce an
;      appropriate 0, 1, or - 1.  She then constructs her zero-crossing
;      stream as follows:
; 
;           (define (make-zero-crossings input-stream last-value)
;             (cons-stream
;              (sign-change-detector (stream-car input-stream) last-value)
;              (make-zero-crossings (stream-cdr input-stream)
;                                   (stream-car input-stream))))
; 
;           (define zero-crossings (make-zero-crossings sense-data 0))
; 
;      Alyssa's boss, Eva Lu Ator, walks by and suggests that this
;      program is approximately equivalent to the following one, which
;      uses the generalized version of `stream-map' from *Note Exercise
;      3-50:::
; 
;           (define zero-crossings
;             (stream-map sign-change-detector sense-data <EXPRESSION>))
; 
;      Complete the program by supplying the indicated <EXPRESSION>.
; 
; {{{3 Solution
; {{{2 Exercise 3.75:
; {{{3 Problem
;      Unfortunately, Alyssa's zero-crossing detector in
;      *Note Exercise 3-74:: proves to be insufficient, because the noisy
;      signal from the sensor leads to spurious zero crossings.  Lem E.
;      Tweakit, a hardware specialist, suggests that Alyssa smooth the
;      signal to filter out the noise before extracting the zero
;      crossings.  Alyssa takes his advice and decides to extract the
;      zero crossings from the signal constructed by averaging each value
;      of the sense data with the previous value.  She explains the
;      problem to her assistant, Louis Reasoner, who attempts to
;      implement the idea, altering Alyssa's program as follows:
; 
;           (define (make-zero-crossings input-stream last-value)
;             (let ((avpt (/ (+ (stream-car input-stream) last-value) 2)))
;               (cons-stream (sign-change-detector avpt last-value)
;                            (make-zero-crossings (stream-cdr input-stream)
;                                                 avpt))))
; 
;      This does not correctly implement Alyssa's plan.  Find the bug
;      that Louis has installed and fix it without changing the structure
;      of the program.  (Hint: You will need to increase the number of
;      arguments to `make-zero-crossings'.)
; 
; {{{3 Solution
; {{{2 Exercise 3.76:
; {{{3 Problem
;      Eva Lu Ator has a criticism of Louis's approach
;      in *Note Exercise 3-75::.  The program he wrote is not modular,
;      because it intermixes the operation of smoothing with the
;      zero-crossing extraction.  For example, the extractor should not
;      have to be changed if Alyssa finds a better way to condition her
;      input signal.  Help Louis by writing a procedure `smooth' that
;      takes a stream as input and produces a stream in which each
;      element is the average of two successive input stream elements.
;      Then use `smooth' as a component to implement the zero-crossing
;      detector in a more modular style.
; 
; {{{3 Solution
; 
; {{{1 3.5.4 Streams and Delayed Evaluation
; {{{2 Exercise 3.77:
; {{{3 Problem
;      The `integral' procedure used above was analogous
;      to the "implicit" definition of the infinite stream of integers in
;      section *Note 3-5-2::.  Alternatively, we can give a definition of
;      `integral' that is more like `integers-starting-from' (also in
;      section *Note 3-5-2::):
; 
;           (define (integral integrand initial-value dt)
;             (cons-stream initial-value
;                          (if (stream-null? integrand)
;                              the-empty-stream
;                              (integral (stream-cdr integrand)
;                                        (+ (* dt (stream-car integrand))
;                                           initial-value)
;                                        dt))))
; 
;      When used in systems with loops, this procedure has the same
;      problem as does our original version of `integral'.  Modify the
;      procedure so that it expects the `integrand' as a delayed argument
;      and hence can be used in the `solve' procedure shown above.
; 
;      *Figure 3.35:* Signal-flow diagram for the solution to a
;      second-order linear differential equation.
; 
;                          dy_0                y_0
;                           |                   |
;                           V                   V
;              ddy     +----------+    dy  +----------+    y
;           +--------->| integral +-----*--+ integral +--*--->
;           |          +----------+     |  +----------+  |
;           |                           |                |
;           |            +----------+   |                |
;           |     __/|<--+ scale: a |<--+                |
;           |   _/   |   +----------+                    |
;           +--<_add |                                   |
;                \__ |   +----------+                    |
;                   \|<--+ scale: b |<-------------------+
;                        +----------+
; 
; {{{3 Solution
; {{{2 Exercise 3.78:
; {{{3 Problem
;      Consider the problem of designing a
;      signal-processing system to study the homogeneous second-order
;      linear differential equation
; 
;           d^2 y        d y
;           -----  -  a -----  -  by  =  0
;           d t^2        d t
; 
;      The output stream, modeling y, is generated by a network that
;      contains a loop. This is because the value of d^2y/dt^2 depends
;      upon the values of y and dy/dt and both of these are determined by
;      integrating d^2y/dt^2.  The diagram we would like to encode is
;      shown in *Note Figure 3-35::.  Write a procedure `solve-2nd' that
;      takes as arguments the constants a, b, and dt and the initial
;      values y_0 and dy_0 for y and dy/dt and generates the stream of
;      successive values of y.
; 
; {{{3 Solution
; {{{2 Exercise 3.79:
; {{{3 Problem
;      Generalize the `solve-2nd' procedure of *Note
;      Exercise 3-78:: so that it can be used to solve general
;      second-order differential equations d^2 y/dt^2 = f(dy/dt, y).
; 
; {{{3 Solution
; {{{2 Exercise 3.80:
; {{{3 Problem
;      A "series RLC circuit" consists of a resistor, a
;      capacitor, and an inductor connected in series, as shown in *Note
;      Figure 3-36::.  If R, L, and C are the resistance, inductance, and
;      capacitance, then the relations between voltage (v) and current
;      (i) for the three components are described by the equations
; 
;           v_R = i_R R
; 
;                    d_(i L)
;           v_L = L ---------
;                      d t
; 
;                    d v_C
;           i_C = C -------
;                     d t
; 
;      and the circuit connections dictate the relations
; 
;           i_R = i_L = -i_C
; 
;           v_C = v_L + v_R
; 
;      Combining these equations shows that the state of the circuit
;      (summarized by v_C, the voltage across the capacitor, and i_L, the
;      current in the inductor) is described by the pair of differential
;      equations
; 
;           d v_C        i_L
;           -----  =  -  ---
;            d t          C
; 
;           d i_L      1           R
;           -----  =  --- v_C  -  --- i_L
;            d t       L           L
; 
;      The signal-flow diagram representing this system of differential
;      equations is shown in *Note Figure 3-37::.
; 
;      *Figure 3.36:* A series RLC circuit.
;                    + v_R -
;              i_R
;           +--->----'\/\/\,--------+
;           |                       |  i_L
;          \|/          R          \|/
;        +  |  i_C                  |_   +
;          -+-                      __)
;      v_C -+- C                   (_)   v_L
;           |                       __)
;        -  |                       |    -
;           +-----------------------+
; 
;      *Figure 3.37:* A signal-flow diagram for the solution to a series
;      RLC circuit.
; 
;                            +-------------+
;           +----------------+  scale: l/L |<--+
;           |                +-------------+   |
;           |                                  |
;           |                +-------------+   |  v_C
;           |       dv_C +-->|   integral  +---*------>
;           |            |   +-------------+
;           |            |        ^
;           |            |        | v_(C_0)
;           |            |
;           |            |   +-------------+
;           |            +---+ scale: -l/C |<--+
;           |                +-------------+   |
;           |  |\__                            |
;           +->|   \_  di_L  +-------------+   |  i_L
;              | add_>------>|   integral  +---*------>
;           +->| __/         +-------------+   |
;           |  |/                 ^            |
;           |                     | i_(L_0)    |
;           |                                  |
;           |                +-------------+   |
;           +----------------+ scale: -R/L |<--+
;                            +-------------+
; 
;    Write a procedure `RLC' that takes as arguments the parameters R, L,
; and C of the circuit and the time increment dt.  In a manner similar to
; that of the `RC' procedure of *Note Exercise 3-73::, `RLC' should
; produce a procedure that takes the initial values of the state
; variables, v_(C_0) and i_(L_0), and produces a pair (using `cons') of
; the streams of states v_C and i_L.  Using `RLC', generate the pair of
; streams that models the behavior of a series RLC circuit with R = 1
; ohm, C = 0.2 farad, L = 1 henry, dt = 0.1 second, and initial values
; i_(L_0) = 0 amps and v_(C_0) = 10 volts.
; 
; {{{3 Solution
; 
; {{{1 3.5.5 Modularity of Functional Programs and Modularity of Objects
; {{{2 Exercise 3.81:
; {{{3 Problem
;      *Note Exercise 3-6:: discussed generalizing the
;      random-number generator to allow one to reset the random-number
;      sequence so as to produce repeatable sequences of "random"
;      numbers.  Produce a stream formulation of this same generator that
;      operates on an input stream of requests to `generate' a new random
;      number or to `reset' the sequence to a specified value and that
;      produces the desired stream of random numbers.  Don't use
;      assignment in your solution.
; 
; {{{3 Solution
; {{{2 Exercise 3.82:
; {{{3 Problem
;      Redo *Note Exercise 3-5:: on Monte Carlo
;      integration in terms of streams.  The stream version of
;      `estimate-integral' will not have an argument telling how many
;      trials to perform.  Instead, it will produce a stream of estimates
;      based on successively more trials.
; 
; {{{3 Solution
; 
; {{{1 4.1.1 The Core of the Evaluator
; {{{2 Exercise 4.1:
; {{{3 Problem
;      Notice that we cannot tell whether the
;      metacircular evaluator evaluates operands from left to right or
;      from right to left.  Its evaluation order is inherited from the
;      underlying Lisp: If the arguments to `cons' in `list-of-values'
;      are evaluated from left to right, then `list-of-values' will
;      evaluate operands from left to right; and if the arguments to
;      `cons' are evaluated from right to left, then `list-of-values'
;      will evaluate operands from right to left.
; 
;      Write a version of `list-of-values' that evaluates operands from
;      left to right regardless of the order of evaluation in the
;      underlying Lisp.  Also write a version of `list-of-values' that
;      evaluates operands from right to left.
; 
; {{{3 Solution
; 
; {{{1 4.1.2 Representing Expressions
; {{{2 Exercise 4.2:
; {{{3 Problem
;      Louis Reasoner plans to reorder the `cond' clauses
;      in `eval' so that the clause for procedure applications appears
;      before the clause for assignments.  He argues that this will make
;      the interpreter more efficient: Since programs usually contain more
;      applications than assignments, definitions, and so on, his
;      modified `eval' will usually check fewer clauses than the original
;      `eval' before identifying the type of an expression.
; 
;        a. What is wrong with Louis's plan?  (Hint: What will Louis's
;           evaluator do with the expression `(define x 3)'?)
; 
;        b. Louis is upset that his plan didn't work.  He is willing to
;           go to any lengths to make his evaluator recognize procedure
;           applications before it checks for most other kinds of
;           expressions.  Help him by changing the syntax of the
;           evaluated language so that procedure applications start with
;           `call'.  For example, instead of `(factorial 3)' we will now
;           have to write `(call factorial 3)' and instead of `(+ 1 2)'
;           we will have to write `(call + 1 2)'.
; 
; {{{3 Solution
; {{{2 Exercise 4.3:
; {{{3 Problem
;      Rewrite `eval' so that the dispatch is done in
;      data-directed style.  Compare this with the data-directed
;      differentiation procedure of *Note Exercise 2-73::.  (You may use
;      the `car' of a compound expression as the type of the expression,
;      as is appropriate for the syntax implemented in this section.)
; 
; {{{3 Solution
; {{{2 Exercise 4.4:
; {{{3 Problem
;      Recall the definitions of the special forms `and'
;      and `or' from *Note Chapter 1:::
; 
;         * `and': The expressions are evaluated from left to right.  If
;           any expression evaluates to false, false is returned; any
;           remaining expressions are not evaluated.  If all the
;           expressions evaluate to true values, the value of the last
;           expression is returned.  If there are no expressions then
;           true is returned.
; 
;         * `or': The expressions are evaluated from left to right.  If
;           any expression evaluates to a true value, that value is
;           returned; any remaining expressions are not evaluated.  If
;           all expressions evaluate to false, or if there are no
;           expressions, then false is returned.
; 
; 
;      Install `and' and `or' as new special forms for the evaluator by
;      defining appropriate syntax procedures and evaluation procedures
;      `eval-and' and `eval-or'.  Alternatively, show how to implement
;      `and' and `or' as derived expressions.
; 
; {{{3 Solution
; {{{2 Exercise 4.5:
; {{{3 Problem
;      Scheme allows an additional syntax for `cond'
;      clauses, `(<TEST> => <RECIPIENT>)'.  If <TEST> evaluates to a true
;      value, then <RECIPIENT> is evaluated.  Its value must be a
;      procedure of one argument; this procedure is then invoked on the
;      value of the <TEST>, and the result is returned as the value of
;      the `cond' expression.  For example
; 
;           (cond ((assoc 'b '((a 1) (b 2))) => cadr)
;                 (else false))
; 
;      returns 2.  Modify the handling of `cond' so that it supports this
;      extended syntax.
; 
; {{{3 Solution
; {{{2 Exercise 4.6:
; {{{3 Problem
;      `Let' expressions are derived expressions, because
; 
;           (let ((<VAR_1> <EXP_1>) ... (<VAR_N> <EXP_N>))
;             <BODY>)
; 
;      is equivalent to
; 
;           ((lambda (<VAR_1> ... <VAR_N>)
;              <BODY>)
;            <EXP_1>
;            ...
;            <EXP_N>)
; 
;      Implement a syntactic transformation `let->combination' that
;      reduces evaluating `let' expressions to evaluating combinations of
;      the type shown above, and add the appropriate clause to `eval' to
;      handle `let' expressions.
; 
; {{{3 Solution
; {{{2 Exercise 4.7:
; {{{3 Problem
;      `Let*' is similar to `let', except that the
;      bindings of the `let' variables are performed sequentially from
;      left to right, and each binding is made in an environment in which
;      all of the preceding bindings are visible.  For example
; 
;           (let* ((x 3)
;                  (y (+ x 2))
;                  (z (+ x y 5)))
;             (* x z))
; 
;      returns 39.  Explain how a `let*' expression can be rewritten as a
;      set of nested `let' expressions, and write a procedure
;      `let*->nested-lets' that performs this transformation.  If we have
;      already implemented `let' (*Note Exercise 4-6::) and we want to
;      extend the evaluator to handle `let*', is it sufficient to add a
;      clause to `eval' whose action is
; 
;           (eval (let*->nested-lets exp) env)
; 
;      or must we explicitly expand `let*' in terms of non-derived
;      expressions?
; 
; {{{3 Solution
; {{{2 Exercise 4.8:
; {{{3 Problem
;      "Named `let'" is a variant of `let' that has the
;      form
; 
;           (let <VAR> <BINDINGS> <BODY>)
; 
;      The <BINDINGS> and <BODY> are just as in ordinary `let', except
;      that <VAR> is bound within <BODY> to a procedure whose body is
;      <BODY> and whose parameters are the variables in the <BINDINGS>.
;      Thus, one can repeatedly execute the <BODY> by invoking the
;      procedure named <VAR>.  For example, the iterative Fibonacci
;      procedure (section *Note 1-2-2::) can be rewritten using named
;      `let' as follows:
; 
;           (define (fib n)
;             (let fib-iter ((a 1)
;                            (b 0)
;                            (count n))
;               (if (= count 0)
;                   b
;                   (fib-iter (+ a b) a (- count 1)))))
; 
;      Modify `let->combination' of *Note Exercise 4-6:: to also support
;      named `let'.
; 
; {{{3 Solution
; {{{2 Exercise 4.9:
; {{{3 Problem
;      Many languages support a variety of iteration
;      constructs, such as `do', `for', `while', and `until'.  In Scheme,
;      iterative processes can be expressed in terms of ordinary
;      procedure calls, so special iteration constructs provide no
;      essential gain in computational power.  On the other hand, such
;      constructs are often convenient.  Design some iteration
;      constructs, give examples of their use, and show how to implement
;      them as derived expressions.
; 
; {{{3 Solution
; {{{2 Exercise 4.10:
; {{{3 Problem
;      By using data abstraction, we were able to write
;      an `eval' procedure that is independent of the particular syntax
;      of the language to be evaluated.  To illustrate this, design and
;      implement a new syntax for Scheme by modifying the procedures in
;      this section, without changing `eval' or `apply'.
; 
; {{{3 Solution
; 
; {{{1 4.1.3 Evaluator Data Structures
; {{{2 Exercise 4.11:
; {{{3 Problem
;      Instead of representing a frame as a pair of
;      lists, we can represent a frame as a list of bindings, where each
;      binding is a name-value pair.  Rewrite the environment operations
;      to use this alternative representation.
; 
; {{{3 Solution
; {{{2 Exercise 4.12:
; {{{3 Problem
;      The procedures `set-variable-value!',
;      `define-variable!', and `lookup-variable-value' can be expressed
;      in terms of more abstract procedures for traversing the
;      environment structure.  Define abstractions that capture the
;      common patterns and redefine the three procedures in terms of these
;      abstractions.
; 
; {{{3 Solution
; {{{2 Exercise 4.13:
; {{{3 Problem
;      Scheme allows us to create new bindings for
;      variables by means of `define', but provides no way to get rid of
;      bindings.  Implement for the evaluator a special form
;      `make-unbound!' that removes the binding of a given symbol from the
;      environment in which the `make-unbound!' expression is evaluated.
;      This problem is not completely specified.  For example, should we
;      remove only the binding in the first frame of the environment?
;      Complete the specification and justify any choices you make.
; 
; {{{3 Solution
; 
; {{{1 4.1.4 Running the Evaluator as a Program
; {{{2 Exercise 4.14:
; {{{3 Problem
;      Eva Lu Ator and Louis Reasoner are each
;      experimenting with the metacircular evaluator.  Eva types in the
;      definition of `map', and runs some test programs that use it.
;      They work fine.  Louis, in contrast, has installed the system
;      version of `map' as a primitive for the metacircular evaluator.
;      When he tries it, things go terribly wrong.  Explain why Louis's
;      `map' fails even though Eva's works.
; 
; {{{3 Solution
; 
; {{{1 4.1.5 Data as Programs
; {{{2 Exercise 4.15:
; {{{3 Problem
;      Given a one-argument procedure `p' and an object
;      `a', `p' is said to "halt" on `a' if evaluating the expression `(p
;      a)' returns a value (as opposed to terminating with an error
;      message or running forever).  Show that it is impossible to write
;      a procedure `halts?' that correctly determines whether `p' halts
;      on `a' for any procedure `p' and object `a'.  Use the following
;      reasoning: If you had such a procedure `halts?', you could
;      implement the following program:
; 
;           (define (run-forever) (run-forever))
; 
;           (define (try p)
;             (if (halts? p p)
;                 (run-forever)
;                 'halted))
; 
;      Now consider evaluating the expression `(try try)' and show that
;      any possible outcome (either halting or running forever) violates
;      the intended behavior of `halts?'.(5)
; 
; {{{3 Solution
; 
; {{{1 4.1.6 Internal Definitions
; {{{2 Exercise 4.16:
; {{{3 Problem
;      In this exercise we implement the method just
;      described for interpreting internal definitions.  We assume that
;      the evaluator supports `let' (see *Note Exercise 4-6::).
; 
;        a. Change `lookup-variable-value' (section *Note 4-1-3::) to
;           signal an error if the value it finds is the symbol
;           `*unassigned*'.
; 
;        b. Write a procedure `scan-out-defines' that takes a procedure
;           body and returns an equivalent one that has no internal
;           definitions, by making the transformation described above.
; 
;        c. Install `scan-out-defines' in the interpreter, either in
;           `make-procedure' or in `procedure-body' (see section *Note
;           4-1-3::).  Which place is better?  Why?
; 
; {{{3 Solution
; {{{2 Exercise 4.17:
; {{{3 Problem
;      Draw diagrams of the environment in effect when
;      evaluating the expression <E3> in the procedure in the text,
;      comparing how this will be structured when definitions are
;      interpreted sequentially with how it will be structured if
;      definitions are scanned out as described.  Why is there an extra
;      frame in the transformed program?  Explain why this difference in
;      environment structure can never make a difference in the behavior
;      of a correct program.  Design a way to make the interpreter
;      implement the "simultaneous" scope rule for internal definitions
;      without constructing the extra frame.
; 
; {{{3 Solution
; {{{2 Exercise 4.18:
; {{{3 Problem
;      Consider an alternative strategy for scanning out
;      definitions that translates the example in the text to
; 
;           (lambda <VARS>
;             (let ((u '*unassigned*)
;                   (v '*unassigned*))
;               (let ((a <E1>)
;                     (b <E2>))
;                 (set! u a)
;                 (set! v b))
;               <E3>))
; 
;      Here `a' and `b' are meant to represent new variable names, created
;      by the interpreter, that do not appear in the user's program.
;      Consider the `solve' procedure from section *Note 3-5-4:::
; 
;           (define (solve f y0 dt)
;             (define y (integral (delay dy) y0 dt))
;             (define dy (stream-map f y))
;             y)
; 
;      Will this procedure work if internal definitions are scanned out
;      as shown in this exercise?  What if they are scanned out as shown
;      in the text?  Explain.
; 
; {{{3 Solution
; {{{2 Exercise 4.19:
; {{{3 Problem
;      Ben Bitdiddle, Alyssa P. Hacker, and Eva Lu Ator
;      are arguing about the desired result of evaluating the expression
; 
;           (let ((a 1))
;             (define (f x)
;               (define b (+ a x))
;               (define a 5)
;               (+ a b))
;             (f 10))
; 
;      Ben asserts that the result should be obtained using the
;      sequential rule for `define': `b' is defined to be 11, then `a' is
;      defined to be 5, so the result is 16.  Alyssa objects that mutual
;      recursion requires the simultaneous scope rule for internal
;      procedure definitions, and that it is unreasonable to treat
;      procedure names differently from other names.  Thus, she argues
;      for the mechanism implemented in *Note Exercise 4-16::.  This
;      would lead to `a' being unassigned at the time that the value for
;      `b' is to be computed.  Hence, in Alyssa's view the procedure
;      should produce an error.  Eva has a third opinion.  She says that
;      if the definitions of `a' and `b' are truly meant to be
;      simultaneous, then the value 5 for `a' should be used in
;      evaluating `b'.  Hence, in Eva's view `a' should be 5, `b' should
;      be 15, and the result should be 20.  Which (if any) of these
;      viewpoints do you support?  Can you devise a way to implement
;      internal definitions so that they behave as Eva prefers?(3)
; 
; {{{3 Solution
; {{{2 Exercise 4.20:
; {{{3 Problem
;      Because internal definitions look sequential but
;      are actually simultaneous, some people prefer to avoid them
;      entirely, and use the special form `letrec' instead.  `Letrec'
;      looks like `let', so it is not surprising that the variables it
;      binds are bound simultaneously and have the same scope as each
;      other.  The sample procedure `f' above can be written without
;      internal definitions, but with exactly the same meaning, as
; 
;           (define (f x)
;             (letrec ((even?
;                       (lambda (n)
;                         (if (= n 0)
;                             true
;                             (odd? (- n 1)))))
;                      (odd?
;                       (lambda (n)
;                         (if (= n 0)
;                             false
;                             (even? (- n 1))))))
;               <REST OF BODY OF `F'>))
; 
;      `Letrec' expressions, which have the form
; 
;           (letrec ((<VAR_1> <EXP_1>) ... (<VAR_N> <EXP_N>))
;             <BODY>)
; 
;      are a variation on `let' in which the expressions <EXP_K> that
;      provide the initial values for the variables <VAR_K> are evaluated
;      in an environment that includes all the `letrec' bindings.  This
;      permits recursion in the bindings, such as the mutual recursion of
;      `even?' and `odd?' in the example above, or the evaluation of 10
;      factorial with
; 
;           (letrec ((fact
;                     (lambda (n)
;                       (if (= n 1)
;                           1
;                           (* n (fact (- n 1)))))))
;             (fact 10))
; 
;        a. Implement `letrec' as a derived expression, by transforming a
;           `letrec' expression into a `let' expression as shown in the
;           text above or in *Note Exercise 4-18::.  That is, the
;           `letrec' variables should be created with a `let' and then be
;           assigned their values with `set!'.
; 
;        b. Louis Reasoner is confused by all this fuss about internal
;           definitions.  The way he sees it, if you don't like to use
;           `define' inside a procedure, you can just use `let'.
;           Illustrate what is loose about his reasoning by drawing an
;           environment diagram that shows the environment in which the
;           <REST OF BODY OF `F'> is evaluated during evaluation of the
;           expression `(f 5)', with `f' defined as in this exercise.
;           Draw an environment diagram for the same evaluation, but with
;           `let' in place of `letrec' in the definition of `f'.
; 
; {{{3 Solution
; {{{2 Exercise 4.21:
; {{{3 Problem
;      Amazingly, Louis's intuition in *Note Exercise
;      4-20:: is correct.  It is indeed possible to specify recursive
;      procedures without using `letrec' (or even `define'), although the
;      method for accomplishing this is much more subtle than Louis
;      imagined.  The following expression computes 10 factorial by
;      applying a recursive factorial procedure:(4)
; 
;           ((lambda (n)
;              ((lambda (fact)
;                 (fact fact n))
;               (lambda (ft k)
;                 (if (= k 1)
;                     1
;                     (* k (ft ft (- k 1)))))))
;            10)
; 
;        a. Check (by evaluating the expression) that this really does
;           compute factorials.  Devise an analogous expression for
;           computing Fibonacci numbers.
; 
;        b. Consider the following procedure, which includes mutually
;           recursive internal definitions:
; 
;                (define (f x)
;                  (define (even? n)
;                    (if (= n 0)
;                        true
;                        (odd? (- n 1))))
;                  (define (odd? n)
;                    (if (= n 0)
;                        false
;                        (even? (- n 1))))
;                  (even? x))
; 
;           Fill in the missing expressions to complete an alternative
;           definition of `f', which uses neither internal definitions
;           nor `letrec':
; 
;                (define (f x)
;                  ((lambda (even? odd?)
;                     (even? even? odd? x))
;                   (lambda (ev? od? n)
;                     (if (= n 0) true (od? <??> <??> <??>)))
;                   (lambda (ev? od? n)
;                     (if (= n 0) false (ev? <??> <??> <??>)))))
; 
; {{{3 Solution
; 
; {{{1 4.1.7 Separating Syntactic Analysis from Execution
; {{{2 Exercise 4.22:
; {{{3 Problem
;      Extend the evaluator in this section to support
;      the special form `let'.  (See *Note Exercise 4-6::.)
; 
; {{{3 Solution
; {{{2 Exercise 4.23:
; {{{3 Problem
;      Alyssa P. Hacker doesn't understand why
;      `analyze-sequence' needs to be so complicated.  All the other
;      analysis procedures are straightforward transformations of the
;      corresponding evaluation procedures (or `eval' clauses) in section
;      *Note 4-1-1::.  She expected `analyze-sequence' to look like this:
; 
;           (define (analyze-sequence exps)
;             (define (execute-sequence procs env)
;               (cond ((null? (cdr procs)) ((car procs) env))
;                     (else ((car procs) env)
;                           (execute-sequence (cdr procs) env))))
;             (let ((procs (map analyze exps)))
;               (if (null? procs)
;                   (error "Empty sequence -- ANALYZE"))
;               (lambda (env) (execute-sequence procs env))))
; 
;      Eva Lu Ator explains to Alyssa that the version in the text does
;      more of the work of evaluating a sequence at analysis time.
;      Alyssa's sequence-execution procedure, rather than having the
;      calls to the individual execution procedures built in, loops
;      through the procedures in order to call them: In effect, although
;      the individual expressions in the sequence have been analyzed, the
;      sequence itself has not been.
; 
;      Compare the two versions of `analyze-sequence'.  For example,
;      consider the common case (typical of procedure bodies) where the
;      sequence has just one expression.  What work will the execution
;      procedure produced by Alyssa's program do?  What about the
;      execution procedure produced by the program in the text above?
;      How do the two versions compare for a sequence with two
;      expressions?
; 
; {{{3 Solution
; {{{2 Exercise 4.24:
; {{{3 Problem
;      Design and carry out some experiments to compare
;      the speed of the original metacircular evaluator with the version
;      in this section.  Use your results to estimate the fraction of time
;      that is spent in analysis versus execution for various procedures.
; 
; {{{3 Solution
; 
; {{{1 4.2.1 Normal Order and Applicative Order
; {{{2 Exercise 4.25:
; {{{3 Problem
;      Suppose that (in ordinary applicative-order
;      Scheme) we define `unless' as shown above and then define
;      `factorial' in terms of `unless' as
; 
;           (define (factorial n)
;             (unless (= n 1)
;                     (* n (factorial (- n 1)))
;                     1))
; 
;      What happens if we attempt to evaluate `(factorial 5)'?  Will our
;      definitions work in a normal-order language?
; 
; {{{3 Solution
; {{{2 Exercise 4.26:
; {{{3 Problem
;      Ben Bitdiddle and Alyssa P. Hacker disagree over
;      the importance of lazy evaluation for implementing things such as
;      `unless'.  Ben points out that it's possible to implement `unless'
;      in applicative order as a special form.  Alyssa counters that, if
;      one did that, `unless' would be merely syntax, not a procedure
;      that could be used in conjunction with higher-order procedures.
;      Fill in the details on both sides of the argument.  Show how to
;      implement `unless' as a derived expression (like `cond' or `let'),
;      and give an example of a situation where it might be useful to
;      have `unless' available as a procedure, rather than as a special
;      form.
; 
; {{{3 Solution
; 
; {{{1 4.2.2 An Interpreter with Lazy Evaluation
; {{{2 Exercise 4.27:
; {{{3 Problem
;      Suppose we type in the following definitions to
;      the lazy evaluator:
; 
;           (define count 0)
; 
;           (define (id x)
;             (set! count (+ count 1))
;             x)
; 
;      Give the missing values in the following sequence of interactions,
;      and explain your answers.(5)
; 
;           (define w (id (id 10)))
; 
;           ;;; L-Eval input:
;           count
;           ;;; L-Eval value:
;           <RESPONSE>
; 
;           ;;; L-Eval input:
;           w
;           ;;; L-Eval value:
;           <RESPONSE>
; 
;           ;;; L-Eval input:
;           count
;           ;;; L-Eval value:
;           <RESPONSE>
; 
; {{{3 Solution
; {{{2 Exercise 4.28:
; {{{3 Problem
;      `Eval' uses `actual-value' rather than `eval' to
;      evaluate the operator before passing it to `apply', in order to
;      force the value of the operator.  Give an example that
;      demonstrates the need for this forcing.
; 
; {{{3 Solution
; {{{2 Exercise 4.29:
; {{{3 Problem
;      Exhibit a program that you would expect to run
;      much more slowly without memoization than with memoization.  Also,
;      consider the following interaction, where the `id' procedure is
;      defined as in *Note Exercise 4-27:: and `count' starts at 0:
; 
;           (define (square x)
;             (* x x))
; 
;           ;;; L-Eval input:
;           (square (id 10))
;           ;;; L-Eval value:
;           <RESPONSE>
; 
;           ;;; L-Eval input:
;           count
;           ;;; L-Eval value:
;           <RESPONSE>
; 
;      Give the responses both when the evaluator memoizes and when it
;      does not.
; 
; {{{3 Solution
; {{{2 Exercise 4.30:
; {{{3 Problem
;      Cy D. Fect, a reformed C programmer, is worried
;      that some side effects may never take place, because the lazy
;      evaluator doesn't force the expressions in a sequence.  Since the
;      value of an expression in a sequence other than the last one is
;      not used (the expression is there only for its effect, such as
;      assigning to a variable or printing), there can be no subsequent
;      use of this value (e.g., as an argument to a primitive procedure)
;      that will cause it to be forced.  Cy thus thinks that when
;      evaluating sequences, we must force all expressions in the
;      sequence except the final one.  He proposes to modify
;      `eval-sequence' from section *Note 4-1-1:: to use `actual-value'
;      rather than `eval':
; 
;           (define (eval-sequence exps env)
;             (cond ((last-exp? exps) (eval (first-exp exps) env))
;                   (else (actual-value (first-exp exps) env)
;                         (eval-sequence (rest-exps exps) env))))
; 
;        a. Ben Bitdiddle thinks Cy is wrong.  He shows Cy the `for-each'
;           procedure described in *Note Exercise 2-23::, which gives an
;           important example of a sequence with side effects:
; 
;                (define (for-each proc items)
;                  (if (null? items)
;                      'done
;                      (begin (proc (car items))
;                             (for-each proc (cdr items)))))
; 
;           He claims that the evaluator in the text (with the original
;           `eval-sequence') handles this correctly:
; 
;                ;;; L-Eval input:
;                (for-each (lambda (x) (newline) (display x))
;                          (list 57 321 88))
;                57
;                321
;                88
;                ;;; L-Eval value:
;                done
; 
;           Explain why Ben is right about the behavior of `for-each'.
; 
;        b. Cy agrees that Ben is right about the `for-each' example, but
;           says that that's not the kind of program he was thinking
;           about when he proposed his change to `eval-sequence'.  He
;           defines the following two procedures in the lazy evaluator:
; 
;                (define (p1 x)
;                  (set! x (cons x '(2)))
;                  x)
; 
;                (define (p2 x)
;                  (define (p e)
;                    e
;                    x)
;                  (p (set! x (cons x '(2)))))
; 
;           What are the values of `(p1 1)' and `(p2 1)' with the original
;           `eval-sequence'?  What would the values be with Cy's proposed
;           change to `eval-sequence'?
; 
;        c. Cy also points out that changing `eval-sequence' as he
;           proposes does not affect the behavior of the example in part
;           a.  Explain why this is true.
; 
;        d. How do you think sequences ought to be treated in the lazy
;           evaluator?  Do you like Cy's approach, the approach in the
;           text, or some other approach?
; 
; {{{3 Solution
; {{{2 Exercise 4.31:
; {{{3 Problem
;      The approach taken in this section is somewhat
;      unpleasant, because it makes an incompatible change to Scheme.  It
;      might be nicer to implement lazy evaluation as an "upward-compatible
;      extension", that is, so that ordinary Scheme programs will work as
;      before.  We can do this by extending the syntax of procedure
;      declarations to let the user control whether or not arguments are
;      to be delayed.  While we're at it, we may as well also give the
;      user the choice between delaying with and without memoization.
;      For example, the definition
; 
;           (define (f a (b lazy) c (d lazy-memo))
;             ...)
; 
;      would define `f' to be a procedure of four arguments, where the
;      first and third arguments are evaluated when the procedure is
;      called, the second argument is delayed, and the fourth argument is
;      both delayed and memoized.  Thus, ordinary procedure definitions
;      will produce the same behavior as ordinary Scheme, while adding
;      the `lazy-memo' declaration to each parameter of every compound
;      procedure will produce the behavior of the lazy evaluator defined
;      in this section. Design and implement the changes required to
;      produce such an extension to Scheme.  You will have to implement
;      new syntax procedures to handle the new syntax for `define'.  You
;      must also arrange for `eval' or `apply' to determine when
;      arguments are to be delayed, and to force or delay arguments
;      accordingly, and you must arrange for forcing to memoize or not,
;      as appropriate.
; 
; {{{3 Solution
; 
; {{{1 4.2.3 Streams as Lazy Lists
; {{{2 Exercise 4.32:
; {{{3 Problem
;      Give some examples that illustrate the difference
;      between the streams of *Note Chapter 3:: and the "lazier" lazy
;      lists described in this section.  How can you take advantage of
;      this extra laziness?
; 
; {{{3 Solution
; {{{2 Exercise 4.33:
; {{{3 Problem
;      Ben Bitdiddle tests the lazy list implementation
;      given above by evaluating the expression
; 
;           (car '(a b c))
; 
;      To his surprise, this produces an error.  After some thought, he
;      realizes that the "lists" obtained by reading in quoted
;      expressions are different from the lists manipulated by the new
;      definitions of `cons', `car', and `cdr'.  Modify the evaluator's
;      treatment of quoted expressions so that quoted lists typed at the
;      driver loop will produce true lazy lists.
; 
; {{{3 Solution
; {{{2 Exercise 4.34:
; {{{3 Problem
;      Modify the driver loop for the evaluator so that
;      lazy pairs and lists will print in some reasonable way.  (What are
;      you going to do about infinite lists?)  You may also need to modify
;      the representation of lazy pairs so that the evaluator can
;      identify them in order to print them.
; 
; {{{3 Solution
; 
; {{{1 4.3.1 Amb and Search
; {{{2 Exercise 4.35:
; {{{3 Problem
;      Write a procedure `an-integer-between' that
;      returns an integer between two given bounds.  This can be used to
;      implement a procedure that finds Pythagorean triples, i.e.,
;      triples of integers (i,j,k) between the given bounds such that i
;      <= j and i^2 + j^2 = k^2, as follows:
; 
;           (define (a-pythagorean-triple-between low high)
;             (let ((i (an-integer-between low high)))
;               (let ((j (an-integer-between i high)))
;                 (let ((k (an-integer-between j high)))
;                   (require (= (+ (* i i) (* j j)) (* k k)))
;                   (list i j k)))))
; 
; {{{3 Solution
; {{{2 Exercise 4.36:
; {{{3 Problem
;      *Note Exercise 3-69:: discussed how to generate
;      the stream of _all_ Pythagorean triples, with no upper bound on
;      the size of the integers to be searched.  Explain why simply
;      replacing `an-integer-between' by `an-integer-starting-from' in
;      the procedure in *Note Exercise 4-35:: is not an adequate way to
;      generate arbitrary Pythagorean triples.  Write a procedure that
;      actually will accomplish this.  (That is, write a procedure for
;      which repeatedly typing `try-again' would in principle eventually
;      generate all Pythagorean triples.)
; 
; {{{3 Solution
; {{{2 Exercise 4.37:
; {{{3 Problem
;      Ben Bitdiddle claims that the following method
;      for generating Pythagorean triples is more efficient than the one
;      in *Note Exercise 4-35::.  Is he correct?  (Hint: Consider the
;      number of possibilities that must be explored.)
; 
;           (define (a-pythagorean-triple-between low high)
;             (let ((i (an-integer-between low high))
;                   (hsq (* high high)))
;               (let ((j (an-integer-between i high)))
;                 (let ((ksq (+ (* i i) (* j j))))
;                   (require (>= hsq ksq))
;                   (let ((k (sqrt ksq)))
;                     (require (integer? k))
;                     (list i j k))))))
; 
; {{{3 Solution
; 
; {{{1 4.3.2 Examples of Nondeterministic Programs
; {{{2 Exercise 4.38:
; {{{3 Problem
;      Modify the multiple-dwelling procedure to omit
;      the requirement that Smith and Fletcher do not live on adjacent
;      floors.  How many solutions are there to this modified puzzle?
; 
; {{{3 Solution
; {{{2 Exercise 4.39:
; {{{3 Problem
;      Does the order of the restrictions in the
;      multiple-dwelling procedure affect the answer? Does it affect the
;      time to find an answer?  If you think it matters, demonstrate a
;      faster program obtained from the given one by reordering the
;      restrictions.  If you think it does not matter, argue your case.
; 
; {{{3 Solution
; {{{2 Exercise 4.40:
; {{{3 Problem
;      In the multiple dwelling problem, how many sets
;      of assignments are there of people to floors, both before and
;      after the requirement that floor assignments be distinct?  It is
;      very inefficient to generate all possible assignments of people to
;      floors and then leave it to backtracking to eliminate them.  For
;      example, most of the restrictions depend on only one or two of the
;      person-floor variables, and can thus be imposed before floors have
;      been selected for all the people.  Write and demonstrate a much
;      more efficient nondeterministic procedure that solves this problem
;      based upon generating only those possibilities that are not already
;      ruled out by previous restrictions.  (Hint: This will require a
;      nest of `let' expressions.)
; 
; {{{3 Solution
; {{{2 Exercise 4.41:
; {{{3 Problem
;      Write an ordinary Scheme program to solve the
;      multiple dwelling puzzle.
; 
; {{{3 Solution
; {{{2 Exercise 4.42:
; {{{3 Problem
;      Solve the following "Liars" puzzle (from Phillips
;      1934):
; 
;      Five schoolgirls sat for an examination.  Their parents--so they
;      thought--showed an undue degree of interest in the result.  They
;      therefore agreed that, in writing home about the examination, each
;      girl should make one true statement and one untrue one.  The
;      following are the relevant passages from their letters:
; 
;         * Betty: "Kitty was second in the examination.  I was only
;           third."
; 
;         * Ethel: "You'll be glad to hear that I was on top.  Joan was
;           second."
; 
;         * Joan: "I was third, and poor old Ethel was bottom."
; 
;         * Kitty: "I came out second.  Mary was only fourth."
; 
;         * Mary: "I was fourth.  Top place was taken by Betty."
; 
; 
;      What in fact was the order in which the five girls were placed?
; 
; {{{3 Solution
; {{{2 Exercise 4.43:
; {{{3 Problem
;      Use the `amb' evaluator to solve the following
;      puzzle:(2)
; 
;           Mary Ann Moore's father has a yacht and so has each of his
;           four friends: Colonel Downing, Mr. Hall, Sir Barnacle Hood,
;           and Dr.  Parker.  Each of the five also has one daughter and
;           each has named his yacht after a daughter of one of the
;           others.  Sir Barnacle's yacht is the Gabrielle, Mr. Moore
;           owns the Lorna; Mr. Hall the Rosalind.  The Melissa, owned by
;           Colonel Downing, is named after Sir Barnacle's daughter.
;           Gabrielle's father owns the yacht that is named after Dr.
;           Parker's daughter.  Who is Lorna's father?
; 
;      Try to write the program so that it runs efficiently (see *Note
;      Exercise 4-40::).  Also determine how many solutions there are if
;      we are not told that Mary Ann's last name is Moore.
; 
; {{{3 Solution
; {{{2 Exercise 4.44:
; {{{3 Problem
;      *Note Exercise 2-42:: described the "eight-queens
;      puzzle" of placing queens on a chessboard so that no two attack
;      each other.  Write a nondeterministic program to solve this puzzle.
; 
; {{{3 Solution
; {{{2 Exercise 4.45:
; {{{3 Problem
;      With the grammar given above, the following
;      sentence can be parsed in five different ways: "The professor
;      lectures to the student in the class with the cat."  Give the five
;      parses and explain the differences in shades of meaning among them.
; 
; {{{3 Solution
; {{{2 Exercise 4.46:
; {{{3 Problem
;      The evaluators in sections *Note 4-1:: and *Note
;      4-2:: do not determine what order operands are evaluated in.  We
;      will see that the `amb' evaluator evaluates them from left to
;      right.  Explain why our parsing program wouldn't work if the
;      operands were evaluated in some other order.
; 
; {{{3 Solution
; {{{2 Exercise 4.47:
; {{{3 Problem
;      Louis Reasoner suggests that, since a verb phrase
;      is either a verb or a verb phrase followed by a prepositional
;      phrase, it would be much more straightforward to define the
;      procedure `parse-verb-phrase' as follows (and similarly for noun
;      phrases):
; 
;           (define (parse-verb-phrase)
;             (amb (parse-word verbs)
;                  (list 'verb-phrase
;                        (parse-verb-phrase)
;                        (parse-prepositional-phrase))))
; 
;      Does this work?  Does the program's behavior change if we
;      interchange the order of expressions in the `amb'
; 
; {{{3 Solution
; {{{2 Exercise 4.48:
; {{{3 Problem
;      Extend the grammar given above to handle more
;      complex sentences.  For example, you could extend noun phrases and
;      verb phrases to include adjectives and adverbs, or you could
;      handle compound sentences.(6)
; 
; {{{3 Solution
; {{{2 Exercise 4.49:
; {{{3 Problem
;      Alyssa P. Hacker is more interested in generating
;      interesting sentences than in parsing them.  She reasons that by
;      simply changing the procedure `parse-word' so that it ignores the
;      "input sentence" and instead always succeeds and generates an
;      appropriate word, we can use the programs we had built for parsing
;      to do generation instead.  Implement Alyssa's idea, and show the
;      first half-dozen or so sentences generated.(7)
; 
; {{{3 Solution
; 
; {{{1 4.3.3 Implementing the `Amb' Evaluator
; {{{2 Exercise 4.50:
; {{{3 Problem
;      Implement a new special form `ramb' that is like
;      `amb' except that it searches alternatives in a random order,
;      rather than from left to right.  Show how this can help with
;      Alyssa's problem in *Note Exercise 4-49::.
; 
; {{{3 Solution
; {{{2 Exercise 4.51:
; {{{3 Problem
;      Implement a new kind of assignment called
;      `permanent-set!' that is not undone upon failure.  For example, we
;      can choose two distinct elements from a list and count the number
;      of trials required to make a successful choice as follows:
; 
;           (define count 0)
; 
;           (let ((x (an-element-of '(a b c)))
;                 (y (an-element-of '(a b c))))
;             (permanent-set! count (+ count 1))
;             (require (not (eq? x y)))
;             (list x y count))
;           ;;; Starting a new problem
;           ;;; Amb-Eval value:
;           (a b 2)
; 
;           ;;; Amb-Eval input:
;           try-again
;           ;;; Amb-Eval value:
;           (a c 3)
; 
;      What values would have been displayed if we had used `set!' here
;      rather than `permanent-set!' ?
; 
; {{{3 Solution
; {{{2 Exercise 4.52:
; {{{3 Problem
;      Implement a new construct called `if-fail' that
;      permits the user to catch the failure of an expression.  `If-fail'
;      takes two expressions.  It evaluates the first expression as usual
;      and returns as usual if the evaluation succeeds.  If the evaluation
;      fails, however, the value of the second expression is returned, as
;      in the following example:
; 
;           ;;; Amb-Eval input:
;           (if-fail (let ((x (an-element-of '(1 3 5))))
;                      (require (even? x))
;                      x)
;                    'all-odd)
;           ;;; Starting a new problem
;           ;;; Amb-Eval value:
;           all-odd
; 
;           ;;; Amb-Eval input:
;           (if-fail (let ((x (an-element-of '(1 3 5 8))))
;                      (require (even? x))
;                      x)
;                    'all-odd)
;           ;;; Starting a new problem
;           ;;; Amb-Eval value:
;           8
; 
; {{{3 Solution
; {{{2 Exercise 4.53:
; {{{3 Problem
;      With `permanent-set!' as described in *Note
;      Exercise 4-51:: and `if-fail' as in *Note Exercise 4-52::, what
;      will be the result of evaluating
; 
;           (let ((pairs '()))
;             (if-fail (let ((p (prime-sum-pair '(1 3 5 8) '(20 35 110))))
;                        (permanent-set! pairs (cons p pairs))
;                        (amb))
;                      pairs))
; 
; {{{3 Solution
; {{{2 Exercise 4.54:
; {{{3 Problem
;      If we had not realized that `require' could be
;      implemented as an ordinary procedure that uses `amb', to be
;      defined by the user as part of a nondeterministic program, we
;      would have had to implement it as a special form.  This would
;      require syntax procedures
; 
;           (define (require? exp) (tagged-list? exp 'require))
; 
;           (define (require-predicate exp) (cadr exp))
; 
;      and a new clause in the dispatch in `analyze'
; 
;           ((require? exp) (analyze-require exp))
; 
;      as well the procedure `analyze-require' that handles `require'
;      expressions.  Complete the following definition of
;      `analyze-require'.
; 
;           (define (analyze-require exp)
;             (let ((pproc (analyze (require-predicate exp))))
;               (lambda (env succeed fail)
;                 (pproc env
;                        (lambda (pred-value fail2)
;                          (if <??>
;                              <??>
;                              (succeed 'ok fail2)))
;                        fail))))
; 
; {{{3 Solution
; 
; {{{1 4.4.1 Deductive Information Retrieval
; {{{2 Exercise 4.55:
; {{{3 Problem
;      Give simple queries that retrieve the following
;      information from the data base:
; 
;        1. all people supervised by Ben Bitdiddle;
; 
;        2. the names and jobs of all people in the accounting division;
; 
;        3. the names and addresses of all people who live in Slumerville.
; 
; {{{3 Solution
; {{{2 Exercise 4.55:
; {{{3 Problem
;      Give simple queries that retrieve the following
;      information from the data base:
; 
;        1. all people supervised by Ben Bitdiddle;
; 
;        2. the names and jobs of all people in the accounting division;
; 
;        3. the names and addresses of all people who live in Slumerville.
; 
; {{{3 Solution
; {{{2 Exercise 4.56:
; {{{3 Problem
;      Formulate compound queries that retrieve the
;      following information:
; 
;        a. the names of all people who are supervised by Ben Bitdiddle,
;           together with their addresses;
; 
;        b. all people whose salary is less than Ben Bitdiddle's,
;           together with their salary and Ben Bitdiddle's salary;
; 
;        c. all people who are supervised by someone who is not in the
;           computer division, together with the supervisor's name and
;           job.
; 
; {{{3 Solution
; {{{2 Exercise 4.57:
; {{{3 Problem
;      Define a rule that says that person 1 can replace
;      person 2 if either person 1 does the same job as person 2 or
;      someone who does person 1's job can also do person 2's job, and if
;      person 1 and person 2 are not the same person. Using your rule,
;      give queries that find the following:
; 
;        a. all people who can replace Cy D. Fect;
; 
;        b. all people who can replace someone who is being paid more
;           than they are, together with the two salaries.
; 
; {{{3 Solution
; {{{2 Exercise 4.58:
; {{{3 Problem
;      Define a rule that says that a person is a "big
;      shot" in a division if the person works in the division but does
;      not have a supervisor who works in the division.
; 
; {{{3 Solution
; {{{2 Exercise 4.59:
; {{{3 Problem
;      Ben Bitdiddle has missed one meeting too many.
;      Fearing that his habit of forgetting meetings could cost him his
;      job, Ben decides to do something about it.  He adds all the weekly
;      meetings of the firm to the Microshaft data base by asserting the
;      following:
; 
;           (meeting accounting (Monday 9am))
;           (meeting administration (Monday 10am))
;           (meeting computer (Wednesday 3pm))
;           (meeting administration (Friday 1pm))
; 
;      Each of the above assertions is for a meeting of an entire
;      division.  Ben also adds an entry for the company-wide meeting
;      that spans all the divisions.  All of the company's employees
;      attend this meeting.
; 
;           (meeting whole-company (Wednesday 4pm))
; 
;        a. On Friday morning, Ben wants to query the data base for all
;           the meetings that occur that day.  What query should he use?
; 
;        b. Alyssa P. Hacker is unimpressed.  She thinks it would be much
;           more useful to be able to ask for her meetings by specifying
;           her name.  So she designs a rule that says that a person's
;           meetings include all `whole-company' meetings plus all
;           meetings of that person's division.  Fill in the body of
;           Alyssa's rule.
; 
;                (rule (meeting-time ?person ?day-and-time)
;                      <RULE-BODY>)
; 
;        c. Alyssa arrives at work on Wednesday morning and wonders what
;           meetings she has to attend that day.  Having defined the
;           above rule, what query should she make to find this out?
; 
; {{{3 Solution
; {{{2 Exercise 4.60:
; {{{3 Problem
;      By giving the query
; 
;           (lives-near ?person (Hacker Alyssa P))
; 
;      Alyssa P. Hacker is able to find people who live near her, with
;      whom she can ride to work.  On the other hand, when she tries to
;      find all pairs of people who live near each other by querying
; 
;           (lives-near ?person-1 ?person-2)
; 
;      she notices that each pair of people who live near each other is
;      listed twice; for example,
; 
;           (lives-near (Hacker Alyssa P) (Fect Cy D))
;           (lives-near (Fect Cy D) (Hacker Alyssa P))
; 
;      Why does this happen?  Is there a way to find a list of people who
;      live near each other, in which each pair appears only once?
;      Explain.
; 
; {{{3 Solution
; {{{2 Exercise 4.61:
; {{{3 Problem
;      The following rules implement a `next-to'
;      relation that finds adjacent elements of a list:
; 
;           (rule (?x next-to ?y in (?x ?y . ?u)))
; 
;           (rule (?x next-to ?y in (?v . ?z))
;                 (?x next-to ?y in ?z))
; 
;      What will the response be to the following queries?
; 
;           (?x next-to ?y in (1 (2 3) 4))
; 
;           (?x next-to 1 in (2 1 3 1))
; 
; {{{3 Solution
; {{{2 Exercise 4.62:
; {{{3 Problem
;      Define rules to implement the `last-pair'
;      operation of *Note Exercise 2-17::, which returns a list
;      containing the last element of a nonempty list.  Check your rules
;      on queries such as `(last-pair (3) ?x)', `(last-pair (1 2 3) ?x)',
;      and `(last-pair (2 ?x) (3))'.  Do your rules work correctly on
;      queries such as `(last-pair ?x (3))' ?
; 
; {{{3 Solution
; {{{2 Exercise 4.63:
; {{{3 Problem
;      The following data base (see Genesis 4) traces
;      the genealogy of the descendants of Ada back to Adam, by way of
;      Cain:
; 
;           (son Adam Cain)
;           (son Cain Enoch)
;           (son Enoch Irad)
;           (son Irad Mehujael)
;           (son Mehujael Methushael)
;           (son Methushael Lamech)
;           (wife Lamech Ada)
;           (son Ada Jabal)
;           (son Ada Jubal)
; 
;      Formulate rules such as "If S is the son of f, and f is the son of
;      G, then S is the grandson of G" and "If W is the wife of M, and S
;      is the son of W, then S is the son of M" (which was supposedly
;      more true in biblical times than today) that will enable the query
;      system to find the grandson of Cain; the sons of Lamech; the
;      grandsons of Methushael.  (See *Note Exercise 4-69:: for some
;      rules to deduce more complicated relationships.)
; 
; {{{3 Solution
; 
; {{{1 4.4.3 Is Logic Programming Mathematical Logic?
; {{{2 Exercise 4.64:
; {{{3 Problem
;      Louis Reasoner mistakenly deletes the
;      `outranked-by' rule (section *Note 4-4-1::) from the data base.
;      When he realizes this, he quickly reinstalls it.  Unfortunately,
;      he makes a slight change in the rule, and types it in as
; 
;           (rule (outranked-by ?staff-person ?boss)
;                 (or (supervisor ?staff-person ?boss)
;                     (and (outranked-by ?middle-manager ?boss)
;                          (supervisor ?staff-person ?middle-manager))))
; 
;      Just after Louis types this information into the system, DeWitt
;      Aull comes by to find out who outranks Ben Bitdiddle. He issues
;      the query
; 
;           (outranked-by (Bitdiddle Ben) ?who)
; 
;      After answering, the system goes into an infinite loop.  Explain
;      why.
; 
; {{{3 Solution
; {{{2 Exercise 4.65:
; {{{3 Problem
;      Cy D. Fect, looking forward to the day when he
;      will rise in the organization, gives a query to find all the
;      wheels (using the `wheel' rule of section *Note 4-4-1::):
; 
;           (wheel ?who)
; 
;      To his surprise, the system responds
; 
;           ;;; Query results:
;           (wheel (Warbucks Oliver))
;           (wheel (Bitdiddle Ben))
;           (wheel (Warbucks Oliver))
;           (wheel (Warbucks Oliver))
;           (wheel (Warbucks Oliver))
; 
;      Why is Oliver Warbucks listed four times?
; 
; {{{3 Solution
; {{{2 Exercise 4.66:
; {{{3 Problem
;      Ben has been generalizing the query system to
;      provide statistics about the company.  For example, to find the
;      total salaries of all the computer programmers one will be able to
;      say
; 
;           (sum ?amount
;                (and (job ?x (computer programmer))
;                     (salary ?x ?amount)))
; 
;      In general, Ben's new system allows expressions of the form
; 
;           (accumulation-function <VARIABLE>
;                                  <QUERY PATTERN>)
; 
;      where `accumulation-function' can be things like `sum', `average',
;      or `maximum'.  Ben reasons that it should be a cinch to implement
;      this.  He will simply feed the query pattern to `qeval'.  This
;      will produce a stream of frames.  He will then pass this stream
;      through a mapping function that extracts the value of the
;      designated variable from each frame in the stream and feed the
;      resulting stream of values to the accumulation function.  Just as
;      Ben completes the implementation and is about to try it out, Cy
;      walks by, still puzzling over the `wheel' query result in exercise
;      *Note Exercise 4-65::.  When Cy shows Ben the system's response,
;      Ben groans, "Oh, no, my simple accumulation scheme won't work!"
; 
;      What has Ben just realized?  Outline a method he can use to
;      salvage the situation.
; 
; {{{3 Solution
; {{{2 Exercise 4.67:
; {{{3 Problem
;      Devise a way to install a loop detector in the
;      query system so as to avoid the kinds of simple loops illustrated
;      in the text and in *Note Exercise 4-64::.  The general idea is that
;      the system should maintain some sort of history of its current
;      chain of deductions and should not begin processing a query that
;      it is already working on.  Describe what kind of information
;      (patterns and frames) is included in this history, and how the
;      check should be made.  (After you study the details of the
;      query-system implementation in section *Note 4-4-4::, you may want
;      to modify the system to include your loop detector.)
; 
; {{{3 Solution
; {{{2 Exercise 4.68:
; {{{3 Problem
;      Define rules to implement the `reverse' operation
;      of *Note Exercise 2-18::, which returns a list containing the same
;      elements as a given list in reverse order.  (Hint: Use
;      `append-to-form'.)  Can your rules answer both `(reverse (1 2 3)
;      ?x)' and `(reverse ?x (1 2 3))' ?
; 
; {{{3 Solution
; {{{2 Exercise 4.69:
; {{{3 Problem
;      Beginning with the data base and the rules you
;      formulated in *Note Exercise 4-63::, devise a rule for adding
;      "greats" to a grandson relationship. This should enable the system
;      to deduce that Irad is the great-grandson of Adam, or that Jabal
;      and Jubal are the great-great-great-great-great-grandsons of Adam.
;      (Hint: Represent the fact about Irad, for example, as `((great
;      grandson) Adam Irad)'.  Write rules that determine if a list ends
;      in the word `grandson'.  Use this to express a rule that allows
;      one to derive the relationship `((great .  ?rel) ?x ?y)', where
;      `?rel' is a list ending in `grandson'.)  Check your rules on
;      queries such as `((great grandson) ?g ?ggs)' and `(?relationship
;      Adam Irad)'.
; 
; {{{3 Solution
; 
; {{{1 4.4.4.5 Maintaining the Data Base
; {{{2 Exercise 4.70:
; {{{3 Problem
;      What is the purpose of the `let' bindings in the
;      procedures `add-assertion!' and `add-rule!' ?  What would be wrong
;      with the following implementation of `add-assertion!' ?  Hint:
;      Recall the definition of the infinite stream of ones in section
;      *Note 3-5-2::: `(define ones (cons-stream 1 ones))'.
; 
;           (define (add-assertion! assertion)
;             (store-assertion-in-index assertion)
;             (set! THE-ASSERTIONS
;                   (cons-stream assertion THE-ASSERTIONS))
;             'ok)
; 
; {{{3 Solution
; 
; {{{1 4.4.4.8 Frames and Bindings
; {{{2 Exercise 4.71:
; {{{3 Problem
;      Louis Reasoner wonders why the `simple-query' and
;      `disjoin' procedures (section *Note 4-4-4-2::) are implemented
;      using explicit `delay' operations, rather than being defined as
;      follows:
; 
;           (define (simple-query query-pattern frame-stream)
;             (stream-flatmap
;              (lambda (frame)
;                (stream-append (find-assertions query-pattern frame)
;                               (apply-rules query-pattern frame)))
;              frame-stream))
; 
;           (define (disjoin disjuncts frame-stream)
;             (if (empty-disjunction? disjuncts)
;                 the-empty-stream
;                 (interleave
;                  (qeval (first-disjunct disjuncts) frame-stream)
;                  (disjoin (rest-disjuncts disjuncts) frame-stream))))
; 
;      Can you give examples of queries where these simpler definitions
;      would lead to undesirable behavior?
; 
; {{{3 Solution
; {{{2 Exercise 4.72:
; {{{3 Problem
;      Why do `disjoin' and `stream-flatmap' interleave
;      the streams rather than simply append them?  Give examples that
;      illustrate why interleaving works better.  (Hint: Why did we use
;      `interleave' in section *Note 3-5-3::?)
; 
; {{{3 Solution
; {{{2 Exercise 4.73:
; {{{3 Problem
;      Why does `flatten-stream' use `delay' explicitly?
;      What would be wrong with defining it as follows:
; 
;           (define (flatten-stream stream)
;             (if (stream-null? stream)
;                 the-empty-stream
;                 (interleave
;                  (stream-car stream)
;                  (flatten-stream (stream-cdr stream)))))
; 
; {{{3 Solution
; {{{2 Exercise 4.74:
; {{{3 Problem
;      Alyssa P. Hacker proposes to use a simpler
;      version of `stream-flatmap' in `negate', `lisp-value', and
;      `find-assertions'.  She observes that the procedure that is mapped
;      over the frame stream in these cases always produces either the
;      empty stream or a singleton stream, so no interleaving is needed
;      when combining these streams.
; 
;        a. Fill in the missing expressions in Alyssa's program.
; 
;                (define (simple-stream-flatmap proc s)
;                  (simple-flatten (stream-map proc s)))
; 
;                (define (simple-flatten stream)
;                  (stream-map <??>
;                              (stream-filter <??> stream)))
; 
;        b. Does the query system's behavior change if we change it in
;           this way?
; 
; {{{3 Solution
; {{{2 Exercise 4.75:
; {{{3 Problem
;      Implement for the query language a new special
;      form called `unique'.  `Unique' should succeed if there is
;      precisely one item in the data base satisfying a specified query.
;      For example,
; 
;           (unique (job ?x (computer wizard)))
; 
;      should print the one-item stream
; 
;           (unique (job (Bitdiddle Ben) (computer wizard)))
; 
;      since Ben is the only computer wizard, and
; 
;           (unique (job ?x (computer programmer)))
; 
;      should print the empty stream, since there is more than one
;      computer programmer.  Moreover,
; 
;           (and (job ?x ?j) (unique (job ?anyone ?j)))
; 
;      should list all the jobs that are filled by only one person, and
;      the people who fill them.
; 
;      There are two parts to implementing `unique'.  The first is to
;      write a procedure that handles this special form, and the second
;      is to make `qeval' dispatch to that procedure.  The second part is
;      trivial, since `qeval' does its dispatching in a data-directed
;      way.  If your procedure is called `uniquely-asserted', all you
;      need to do is
; 
;           (put 'unique 'qeval uniquely-asserted)
; 
;      and `qeval' will dispatch to this procedure for every query whose
;      `type' (`car') is the symbol `unique'.
; 
;      The real problem is to write the procedure `uniquely-asserted'.
;      This should take as input the `contents' (`cdr') of the `unique'
;      query, together with a stream of frames.  For each frame in the
;      stream, it should use `qeval' to find the stream of all extensions
;      to the frame that satisfy the given query.  Any stream that does
;      not have exactly one item in it should be eliminated.  The
;      remaining streams should be passed back to be accumulated into one
;      big stream that is the result of the `unique' query.  This is
;      similar to the implementation of the `not' special form.
; 
;      Test your implementation by forming a query that lists all people
;      who supervise precisely one person.
; 
; {{{3 Solution
; {{{2 Exercise 4.76:
; {{{3 Problem
;      Our implementation of `and' as a series
;      combination of queries (*Note Figure 4-5::) is elegant, but it is
;      inefficient because in processing the second query of the `and' we
;      must scan the data base for each frame produced by the first
;      query.  If the data base has n elements, and a typical query
;      produces a number of output frames proportional to n (say n/k),
;      then scanning the data base for each frame produced by the first
;      query will require n^2/k calls to the pattern matcher.  Another
;      approach would be to process the two clauses of the `and'
;      separately, then look for all pairs of output frames that are
;      compatible.  If each query produces n/k output frames, then this
;      means that we must perform n^2/k^2 compatibility checks--a factor
;      of k fewer than the number of matches required in our current
;      method.
; 
;      Devise an implementation of `and' that uses this strategy.  You
;      must implement a procedure that takes two frames as inputs, checks
;      whether the bindings in the frames are compatible, and, if so,
;      produces a frame that merges the two sets of bindings.  This
;      operation is similar to unification.
; 
; {{{3 Solution
; {{{2 Exercise 4.77:
; {{{3 Problem
;      In section *Note 4-4-3:: we saw that `not' and
;      `lisp-value' can cause the query language to give "wrong" answers
;      if these filtering operations are applied to frames in which
;      variables are unbound.  Devise a way to fix this shortcoming.  One
;      idea is to perform the filtering in a "delayed" manner by
;      appending to the frame a "promise" to filter that is fulfilled
;      only when enough variables have been bound to make the operation
;      possible.  We could wait to perform filtering until all other
;      operations have been performed.  However, for efficiency's sake, we
;      would like to perform filtering as soon as possible so as to cut
;      down on the number of intermediate frames generated.
; 
; {{{3 Solution
; {{{2 Exercise 4.78:
; {{{3 Problem
;      Redesign the query language as a nondeterministic
;      program to be implemented using the evaluator of section *Note
;      4-3::, rather than as a stream process.  In this approach, each
;      query will produce a single answer (rather than the stream of all
;      answers) and the user can type `try-again' to see more answers.
;      You should find that much of the mechanism we built in this
;      section is subsumed by nondeterministic search and backtracking.
;      You will probably also find, however, that your new query language
;      has subtle differences in behavior from the one implemented here.
;      Can you find examples that illustrate this difference?
; 
; {{{3 Solution
; {{{2 Exercise 4.79:
; {{{3 Problem
;      When we implemented the Lisp evaluator in section
;      *Note 4-1::, we saw how to use local environments to avoid name
;      conflicts between the parameters of procedures.  For example, in
;      evaluating
; 
;           (define (square x)
;             (* x x))
; 
;           (define (sum-of-squares x y)
;             (+ (square x) (square y)))
; 
;           (sum-of-squares 3 4)
; 
;      there is no confusion between the `x' in `square' and the `x' in
;      `sum-of-squares', because we evaluate the body of each procedure
;      in an environment that is specially constructed to contain
;      bindings for the local variables.  In the query system, we used a
;      different strategy to avoid name conflicts in applying rules.
;      Each time we apply a rule we rename the variables with new names
;      that are guaranteed to be unique.  The analogous strategy for the
;      Lisp evaluator would be to do away with local environments and
;      simply rename the variables in the body of a procedure each time
;      we apply the procedure.
; 
;      Implement for the query language a rule-application method that
;      uses environments rather than renaming.  See if you can build on
;      your environment structure to create constructs in the query
;      language for dealing with large systems, such as the rule analog
;      of block-structured procedures.  Can you relate any of this to the
;      problem of making deductions in a context (e.g., "If I supposed
;      that P were true, then I would be able to deduce A and B.") as a
;      method of problem solving?  (This problem is open-ended.  A good
;      answer is probably worth a Ph.D.)
; 
; {{{3 Solution
; 
; {{{1 5.1 Designing Register Machines
; {{{2 Exercise 5.1:
; {{{3 Problem
;      Design a register machine to compute factorials
;      using the iterative algorithm specified by the following
;      procedure.  Draw data-path and controller diagrams for this
;      machine.
; 
;           (define (factorial n)
;             (define (iter product counter)
;               (if (> counter n)
;                   product
;                   (iter (* counter product)
;                         (+ counter 1))))
;             (iter 1 1))
; 
; {{{3 Solution
; {{{2 Exercise 5.1:
; {{{3 Problem
;      Design a register machine to compute factorials
;      using the iterative algorithm specified by the following
;      procedure.  Draw data-path and controller diagrams for this
;      machine.
; 
;           (define (factorial n)
;             (define (iter product counter)
;               (if (> counter n)
;                   product
;                   (iter (* counter product)
;                         (+ counter 1))))
;             (iter 1 1))
; 
; {{{1 5.1.1 A Language for Describing Register Machines
; {{{3 Solution
; {{{2 Exercise 5.2:
; {{{3 Problem
;      Use the register-machine language to describe the
;      iterative factorial machine of *Note Exercise 5-1::.
; 
; {{{1 5.1.2 Abstraction in Machine Design
; {{{3 Solution
; {{{2 Exercise 5.3:
; {{{3 Problem
;      Design a machine to compute square roots using
;      Newton's method, as described in section *Note 1-1-7:::
; 
;           (define (sqrt x)
;             (define (good-enough? guess)
;               (< (abs (- (square guess) x)) 0.001))
;             (define (improve guess)
;               (average guess (/ x guess)))
;             (define (sqrt-iter guess)
;               (if (good-enough? guess)
;                   guess
;                   (sqrt-iter (improve guess))))
;             (sqrt-iter 1.0))
; 
;      Begin by assuming that `good-enough?' and `improve' operations are
;      available as primitives.  Then show how to expand these in terms
;      of arithmetic operations.  Describe each version of the `sqrt'
;      machine design by drawing a data-path diagram and writing a
;      controller definition in the register-machine language.
; 
; {{{1 5.1.4 Using a Stack to Implement Recursion
; {{{3 Solution
; {{{2 Exercise 5.4:
; {{{3 Problem
;      Specify register machines that implement each of
;      the following procedures.  For each machine, write a controller
;      instruction sequence and draw a diagram showing the data paths.
; 
;        a. Recursive exponentiation:
; 
;                (define (expt b n)
;                  (if (= n 0)
;                      1
;                      (* b (expt b (- n 1)))))
; 
;        b. Iterative exponentiation:
; 
;                (define (expt b n)
;                  (define (expt-iter counter product)
;                    (if (= counter 0)
;                        product
;                        (expt-iter (- counter 1) (* b product))))
;                  (expt-iter n 1))
; 
; {{{3 Solution
; {{{2 Exercise 5.5:
; {{{3 Problem
;      Hand-simulate the factorial and Fibonacci
;      machines, using some nontrivial input (requiring execution of at
;      least one recursive call).  Show the contents of the stack at each
;      significant point in the execution.
; 
; {{{3 Solution
; {{{2 Exercise 5.6:
; {{{3 Problem
;      Ben Bitdiddle observes that the Fibonacci
;      machine's controller sequence has an extra `save' and an extra
;      `restore', which can be removed to make a faster machine.  Where
;      are these instructions?
; 
; {{{3 Solution
; 
; {{{1 5.2 A Register Machine Simulator
; {{{2 Exercise 5.7:
; {{{3 Problem
;      Use the simulator to test the machines you
;      designed in *Note Exercise 5-4::.
; 
; {{{3 Solution
; 
; {{{1 5.2.2 The Assembler
; {{{2 Exercise 5.8:
; {{{3 Problem
;      The following register-machine code is ambiguous,
;      because the label `here' is defined more than once:
; 
;           start
;             (goto (label here))
;           here
;             (assign a (const 3))
;             (goto (label there))
;           here
;             (assign a (const 4))
;             (goto (label there))
;           there
; 
;      With the simulator as written, what will the contents of register
;      `a' be when control reaches `there'?  Modify the `extract-labels'
;      procedure so that the assembler will signal an error if the same
;      label name is used to indicate two different locations.
; 
; {{{3 Solution
; 
; {{{1 5.2.3 Generating Execution Procedures for Instructions
; {{{2 Exercise 5.9:
; {{{3 Problem
;      The treatment of machine operations above permits
;      them to operate on labels as well as on constants and the contents
;      of registers.  Modify the expression-processing procedures to
;      enforce the condition that operations can be used only with
;      registers and constants.
; 
; {{{3 Solution
; {{{2 Exercise 5.10:
; {{{3 Problem
;      Design a new syntax for register-machine
;      instructions and modify the simulator to use your new syntax.  Can
;      you implement your new syntax without changing any part of the
;      simulator except the syntax procedures in this section?
; 
; {{{3 Solution
; {{{2 Exercise 5.11:
; {{{3 Problem
;      When we introduced `save' and `restore' in
;      section *Note 5-1-4::, we didn't specify what would happen if you
;      tried to restore a register that was not the last one saved, as in
;      the sequence
; 
;           (save y)
;           (save x)
;           (restore y)
; 
;      There are several reasonable possibilities for the meaning of
;      `restore':
; 
;        a. `(restore y)' puts into `y' the last value saved on the stack,
;           regardless of what register that value came from.  This is
;           the way our simulator behaves.  Show how to take advantage of
;           this behavior to eliminate one instruction from the Fibonacci
;           machine of section *Note 5-1-4:: (*Note Figure 5-12::).
; 
;        b. `(restore y)' puts into `y' the last value saved on the
;           stack, but only if that value was saved from `y'; otherwise,
;           it signals an error.  Modify the simulator to behave this
;           way.  You will have to change `save' to put the register name
;           on the stack along with the value.
; 
;        c. `(restore y)' puts into `y' the last value saved from `y'
;           regardless of what other registers were saved after `y' and
;           not restored.  Modify the simulator to behave this way.  You
;           will have to associate a separate stack with each register.
;           You should make the `initialize-stack' operation initialize
;           all the register stacks.
; 
; {{{3 Solution
; {{{2 Exercise 5.12:
; {{{3 Problem
;      The simulator can be used to help determine the
;      data paths required for implementing a machine with a given
;      controller.  Extend the assembler to store the following
;      information in the machine model:
; 
;         * a list of all instructions, with duplicates removed, sorted
;           by instruction type (`assign', `goto', and so on);
; 
;         * a list (without duplicates) of the registers used to hold
;           entry points (these are the registers referenced by `goto'
;           instructions);
; 
;         * a list (without duplicates) of the registers that are `save'd
;           or `restore'd;
; 
;         * for each register, a list (without duplicates) of the sources
;           from which it is assigned (for example, the sources for
;           register `val' in the factorial machine of *Note Figure
;           5-11:: are `(const 1)' and `((op *) (reg n) (reg val))').
; 
; 
;      Extend the message-passing interface to the machine to provide
;      access to this new information.  To test your analyzer, define the
;      Fibonacci machine from *Note Figure 5-12:: and examine the lists
;      you constructed.
; 
; {{{3 Solution
; {{{2 Exercise 5.13:
; {{{3 Problem
;      Modify the simulator so that it uses the
;      controller sequence to determine what registers the machine has
;      rather than requiring a list of registers as an argument to
;      `make-machine'.  Instead of pre-allocating the registers in
;      `make-machine', you can allocate them one at a time when they are
;      first seen during assembly of the instructions.
; 
; {{{3 Solution
; 
; {{{1 5.2.4 Monitoring Machine Performance
; {{{2 Exercise 5.14:
; {{{3 Problem
;      Measure the number of pushes and the maximum
;      stack depth required to compute n! for various small values of n
;      using the factorial machine shown in *Note Figure 5-11::.  From
;      your data determine formulas in terms of n for the total number of
;      push operations and the maximum stack depth used in computing n!
;      for any n > 1. Note that each of these is a linear function of n
;      and is thus determined by two constants.  In order to get the
;      statistics printed, you will have to augment the factorial machine
;      with instructions to initialize the stack and print the
;      statistics.  You may want to also modify the machine so that it
;      repeatedly reads a value for n, computes the factorial, and prints
;      the result (as we did for the GCD machine in *Note Figure 5-4::),
;      so that you will not have to repeatedly invoke
;      `get-register-contents', `set-register-contents!', and `start'.
; 
; {{{3 Solution
; {{{2 Exercise 5.15:
; {{{3 Problem
;      Add counting "instruction counting" to the
;      register machine simulation.  That is, have the machine model keep
;      track of the number of instructions executed.  Extend the machine
;      model's interface to accept a new message that prints the value of
;      the instruction count and resets the count to zero.
; 
; {{{3 Solution
; {{{2 Exercise 5.16:
; {{{3 Problem
;      Augment the simulator to provide for "instruction
;      tracing".  That is, before each instruction is executed, the
;      simulator should print the text of the instruction.  Make the
;      machine model accept `trace-on' and `trace-off' messages to turn
;      tracing on and off.
; 
; {{{3 Solution
; {{{2 Exercise 5.17:
; {{{3 Problem
;      Extend the instruction tracing of *Note Exercise
;      5-16:: so that before printing an instruction, the simulator
;      prints any labels that immediately precede that instruction in the
;      controller sequence.  Be careful to do this in a way that does not
;      interfere with instruction counting (*Note Exercise 5-15::).  You
;      will have to make the simulator retain the necessary label
;      information.
; 
; {{{3 Solution
; {{{2 Exercise 5.18:
; {{{3 Problem
;      Modify the `make-register' procedure of section
;      *Note 5-2-1:: so that registers can be traced.  Registers should
;      accept messages that turn tracing on and off.  When a register is
;      traced, assigning a value to the register should print the name of
;      the register, the old contents of the register, and the new
;      contents being assigned.  Extend the interface to the machine
;      model to permit you to turn tracing on and off for designated
;      machine registers.
; 
; {{{3 Solution
; {{{2 Exercise 5.19:
; {{{3 Problem
;      Alyssa P. Hacker wants a "breakpoint" feature in
;      the simulator to help her debug her machine designs.  You have
;      been hired to install this feature for her.  She wants to be able
;      to specify a place in the controller sequence where the simulator
;      will stop and allow her to examine the state of the machine.  You
;      are to implement a procedure
; 
;           (set-breakpoint <MACHINE> <LABEL> <N>)
; 
;      that sets a breakpoint just before the nth instruction after the
;      given label.  For example,
; 
;           (set-breakpoint gcd-machine 'test-b 4)
; 
;      installs a breakpoint in `gcd-machine' just before the assignment
;      to register `a'.  When the simulator reaches the breakpoint it
;      should print the label and the offset of the breakpoint and stop
;      executing instructions.  Alyssa can then use
;      `get-register-contents' and `set-register-contents!' to manipulate
;      the state of the simulated machine.  She should then be able to
;      continue execution by saying
; 
;           (proceed-machine <MACHINE>)
; 
;      She should also be able to remove a specific breakpoint by means of
; 
;           (cancel-breakpoint <MACHINE> <LABEL> <N>)
; 
;      or to remove all breakpoints by means of
; 
;           (cancel-all-breakpoints <MACHINE>)
; 
; {{{3 Solution
; 
; {{{1 5.3.1 Memory as Vectors
; {{{2 Exercise 5.20:
; {{{3 Problem
;      Draw the box-and-pointer representation and the
;      memory-vector representation (as in *Note Figure 5-14::) of the
;      list structure produced by
; 
;           (define x (cons 1 2))
;           (define y (list x x))
; 
;      with the `free' pointer initially `p1'.  What is the final value of
;      `free' ?  What pointers represent the values of `x' and `y' ?
; 
; {{{3 Solution
; {{{2 Exercise 5.21:
; {{{3 Problem
;      Implement register machines for the following
;      procedures.  Assume that the list-structure memory operations are
;      available as machine primitives.
; 
;        a. Recursive `count-leaves':
; 
;                (define (count-leaves tree)
;                  (cond ((null? tree) 0)
;                        ((not (pair? tree)) 1)
;                        (else (+ (count-leaves (car tree))
;                                 (count-leaves (cdr tree))))))
; 
;        b. Recursive `count-leaves' with explicit counter:
; 
;                (define (count-leaves tree)
;                  (define (count-iter tree n)
;                    (cond ((null? tree) n)
;                          ((not (pair? tree)) (+ n 1))
;                          (else (count-iter (cdr tree)
;                                            (count-iter (car tree) n)))))
;                  (count-iter tree 0))
; 
; {{{3 Solution
; {{{2 Exercise 5.22:
; {{{3 Problem
;      *Note Exercise 3-12:: of section *Note 3-3-1::
;      presented an `append' procedure that appends two lists to form a
;      new list and an `append!' procedure that splices two lists
;      together.  Design a register machine to implement each of these
;      procedures.  Assume that the list-structure memory operations are
;      available as primitive operations.
; 
; {{{3 Solution
; 
; {{{1 5.4.3 Conditionals, Assignments, and Definitions
; {{{2 Exercise 5.23:
; {{{3 Problem
;      Extend the evaluator to handle derived
;      expressions such as `cond', `let', and so on (section *Note
;      4-1-2::).  You may "cheat" and assume that the syntax transformers
;      such as `cond->if' are available as machine operations.(1)
; 
; {{{3 Solution
; {{{2 Exercise 5.24:
; {{{3 Problem
;      Implement `cond' as a new basic special form
;      without reducing it to `if'.  You will have to construct a loop
;      that tests the predicates of successive `cond' clauses until you
;      find one that is true, and then use `ev-sequence' to evaluate the
;      actions of the clause.
; 
; {{{3 Solution
; {{{2 Exercise 5.25:
; {{{3 Problem
;      Modify the evaluator so that it uses normal-order
;      evaluation, based on the lazy evaluator of section *Note 4-2::.
; 
; {{{3 Solution
; 
; {{{1 5.4.4 Running the Evaluator
; {{{2 Exercise 5.26:
; {{{3 Problem
;      Use the monitored stack to explore the
;      tail-recursive property of the evaluator (section *Note 5-4-2::).
;      Start the evaluator and define the iterative `factorial' procedure
;      from section *Note 1-2-1:::
; 
;           (define (factorial n)
;             (define (iter product counter)
;               (if (> counter n)
;                   product
;                   (iter (* counter product)
;                         (+ counter 1))))
;             (iter 1 1))
; 
;      Run the procedure with some small values of n.  Record the maximum
;      stack depth and the number of pushes required to compute n! for
;      each of these values.
; 
;        a. You will find that the maximum depth required to evaluate n!
;           is independent of n.  What is that depth?
; 
;        b. Determine from your data a formula in terms of n for the
;           total number of push operations used in evaluating n! for any
;           n >= 1.  Note that the number of operations used is a linear
;           function of n and is thus determined by two constants.
; 
; {{{3 Solution
; {{{2 Exercise 5.27:
; {{{3 Problem
;      For comparison with *Note Exercise 5-26::,
;      explore the behavior of the following procedure for computing
;      factorials recursively:
; 
;           (define (factorial n)
;             (if (= n 1)
;                 1
;                 (* (factorial (- n 1)) n)))
; 
;      By running this procedure with the monitored stack, determine, as
;      a function of n, the maximum depth of the stack and the total
;      number of pushes used in evaluating n! for n >= 1.  (Again, these
;      functions will be linear.)  Summarize your experiments by filling
;      in the following table with the appropriate expressions in terms
;      of n:
; 
;                          Maximum depth       Number of pushes
; 
;           Recursive
;           factorial
; 
;           Iterative
;           factorial
; 
;      The maximum depth is a measure of the amount of space used by the
;      evaluator in carrying out the computation, and the number of
;      pushes correlates well with the time required.
; 
; {{{3 Solution
; {{{2 Exercise 5.28:
; {{{3 Problem
;      Modify the definition of the evaluator by
;      changing `eval-sequence' as described in section *Note 5-4-2:: so
;      that the evaluator is no longer tail-recursive.  Rerun your
;      experiments from *Note Exercise 5-26:: and *Note Exercise 5-27::
;      to demonstrate that both versions of the `factorial' procedure now
;      require space that grows linearly with their input.
; 
; {{{3 Solution
; {{{2 Exercise 5.29:
; {{{3 Problem
;      Monitor the stack operations in the
;      tree-recursive Fibonacci computation:
; 
;           (define (fib n)
;             (if (< n 2)
;                 n
;                 (+ (fib (- n 1)) (fib (- n 2)))))
; 
;        a. Give a formula in terms of n for the maximum depth of the
;           stack required to compute _Fib_(n) for n >= 2.  Hint: In
;           section *Note 1-2-2:: we argued that the space used by this
;           process grows linearly with n.
; 
;        b. Give a formula for the total number of pushes used to compute
;           _Fib_(n) for n >= 2.  You should find that the number of
;           pushes (which correlates well with the time used) grows
;           exponentially with n.  Hint: Let S(n) be the number of pushes
;           used in computing _Fib_(n).  You should be able to argue that
;           there is a formula that expresses S(n) in terms of S(n - 1),
;           S(n - 2), and some fixed "overhead" constant k that is
;           independent of n.  Give the formula, and say what k is.  Then
;           show that S(n) can be expressed as a _Fib_(n + 1) + b and
;           give the values of a and b.
; 
; {{{3 Solution
; {{{2 Exercise 5.30:
; {{{3 Problem
;      Our evaluator currently catches and signals only
;      two kinds of errors--unknown expression types and unknown
;      procedure types.  Other errors will take us out of the evaluator
;      read-eval-print loop.  When we run the evaluator using the
;      register-machine simulator, these errors are caught by the
;      underlying Scheme system.  This is analogous to the computer
;      crashing when a user program makes an error.(4)  It is a large
;      project to make a real error system work, but it is well worth the
;      effort to understand what is involved here.
; 
;        a. Errors that occur in the evaluation process, such as an
;           attempt to access an unbound variable, could be caught by
;           changing the lookup operation to make it return a
;           distinguished condition code, which cannot be a possible
;           value of any user variable.  The evaluator can test for this
;           condition code and then do what is necessary to go to
;           `signal-error'.  Find all of the places in the evaluator
;           where such a change is necessary and fix them.  This is lots
;           of work.
; 
;        b. Much worse is the problem of handling errors that are
;           signaled by applying primitive procedures, such as an attempt
;           to divide by zero or an attempt to extract the `car' of a
;           symbol.  In a professionally written high-quality system,
;           each primitive application is checked for safety as part of
;           the primitive.  For example, every call to `car' could first
;           check that the argument is a pair.  If the argument is not a
;           pair, the application would return a distinguished condition
;           code to the evaluator, which would then report the failure.
;           We could arrange for this in our register-machine simulator by
;           making each primitive procedure check for applicability and
;           returning an appropriate distinguished condition code on
;           failure. Then the `primitive-apply' code in the evaluator can
;           check for the condition code and go to `signal-error' if
;           necessary.  Build this structure and make it work.  This is a
;           major project.
; 
; {{{3 Solution
; 
; {{{1 5.5.1 Structure of the Compiler
; {{{2 Exercise 5.31:
; {{{3 Problem
;      In evaluating a procedure application, the
;      explicit-control evaluator always saves and restores the `env'
;      register around the evaluation of the operator, saves and restores
;      `env' around the evaluation of each operand (except the final
;      one), saves and restores `argl' around the evaluation of each
;      operand, and saves and restores `proc' around the evaluation of
;      the operand sequence.  For each of the following combinations, say
;      which of these `save' and `restore' operations are superfluous and
;      thus could be eliminated by the compiler's `preserving' mechanism:
; 
;           (f 'x 'y)
; 
;           ((f) 'x 'y)
; 
;           (f (g 'x) y)
; 
;           (f (g 'x) 'y)
; 
; {{{3 Solution
; {{{2 Exercise 5.32:
; {{{3 Problem
;      Using the `preserving' mechanism, the compiler
;      will avoid saving and restoring `env' around the evaluation of the
;      operator of a combination in the case where the operator is a
;      symbol.  We could also build such optimizations into the
;      evaluator.  Indeed, the explicit-control evaluator of section
;      *Note 5-4:: already performs a similar optimization, by treating
;      combinations with no operands as a special case.
; 
;        a. Extend the explicit-control evaluator to recognize as a
;           separate class of expressions combinations whose operator is
;           a symbol, and to take advantage of this fact in evaluating
;           such expressions.
; 
;        b. Alyssa P. Hacker suggests that by extending the evaluator to
;           recognize more and more special cases we could incorporate
;           all the compiler's optimizations, and that this would
;           eliminate the advantage of compilation altogether.  What do
;           you think of this idea?
; 
; {{{3 Solution
; 
; {{{1 5.5.5 An Example of Compiled Code
; {{{2 Exercise 5.33:
; {{{3 Problem
;      Consider the following definition of a factorial
;      procedure, which is slightly different from the one given above:
; 
;           (define (factorial-alt n)
;             (if (= n 1)
;                 1
;                 (* n (factorial-alt (- n 1)))))
; 
;      Compile this procedure and compare the resulting code with that
;      produced for `factorial'.  Explain any differences you find.  Does
;      either program execute more efficiently than the other?
; 
; {{{3 Solution
; {{{2 Exercise 5.34:
; {{{3 Problem
;      Compile the iterative factorial procedure
; 
;           (define (factorial n)
;             (define (iter product counter)
;               (if (> counter n)
;                   product
;                   (iter (* counter product)
;                         (+ counter 1))))
;             (iter 1 1))
; 
;      Annotate the resulting code, showing the essential difference
;      between the code for iterative and recursive versions of
;      `factorial' that makes one process build up stack space and the
;      other run in constant stack space.
; 
;      *Figure 5.17:* Compilation of the definition of the `factorial'
;      procedure
; 
;           ;; construct the procedure and skip over code for the procedure body
;             (assign val
;                     (op make-compiled-procedure) (label entry2) (reg env))
;             (goto (label after-lambda1))
; 
;           entry2     ; calls to `factorial' will enter here
;             (assign env (op compiled-procedure-env) (reg proc))
;             (assign env
;                     (op extend-environment) (const (n)) (reg argl) (reg env))
;           ;; begin actual procedure body
;             (save continue)
;             (save env)
; 
;           ;; compute `(= n 1)'
;             (assign proc (op lookup-variable-value) (const =) (reg env))
;             (assign val (const 1))
;             (assign argl (op list) (reg val))
;             (assign val (op lookup-variable-value) (const n) (reg env))
;             (assign argl (op cons) (reg val) (reg argl))
;             (test (op primitive-procedure?) (reg proc))
;             (branch (label primitive-branch17))
;           compiled-branch16
;             (assign continue (label after-call15))
;             (assign val (op compiled-procedure-entry) (reg proc))
;             (goto (reg val))
;           primitive-branch17
;             (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
; 
;           after-call15   ; `val' now contains result of `(= n 1)'
;             (restore env)
;             (restore continue)
;             (test (op false?) (reg val))
;             (branch (label false-branch4))
;           true-branch5  ; return 1
;             (assign val (const 1))
;             (goto (reg continue))
; 
;           false-branch4
;           ;; compute and return `(* (factorial (- n 1)) n)'
;             (assign proc (op lookup-variable-value) (const *) (reg env))
;             (save continue)
;             (save proc)   ; save `*' procedure
;             (assign val (op lookup-variable-value) (const n) (reg env))
;             (assign argl (op list) (reg val))
;             (save argl)   ; save partial argument list for `*'
; 
;           ;; compute `(factorial (- n 1))', which is the other argument for `*'
;             (assign proc
;                     (op lookup-variable-value) (const factorial) (reg env))
;             (save proc)  ; save `factorial' procedure
; 
;           ;; compute `(- n 1)', which is the argument for `factorial'
;             (assign proc (op lookup-variable-value) (const -) (reg env))
;             (assign val (const 1))
;             (assign argl (op list) (reg val))
;             (assign val (op lookup-variable-value) (const n) (reg env))
;             (assign argl (op cons) (reg val) (reg argl))
;             (test (op primitive-procedure?) (reg proc))
;             (branch (label primitive-branch8))
;           compiled-branch7
;             (assign continue (label after-call6))
;             (assign val (op compiled-procedure-entry) (reg proc))
;             (goto (reg val))
;           primitive-branch8
;             (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
; 
;           after-call6   ; `val' now contains result of `(- n 1)'
;             (assign argl (op list) (reg val))
;             (restore proc) ; restore `factorial'
;           ;; apply `factorial'
;             (test (op primitive-procedure?) (reg proc))
;             (branch (label primitive-branch11))
;           compiled-branch10
;             (assign continue (label after-call9))
;             (assign val (op compiled-procedure-entry) (reg proc))
;             (goto (reg val))
;           primitive-branch11
;             (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
; 
;           after-call9      ; `val' now contains result of `(factorial (- n 1))'
;             (restore argl) ; restore partial argument list for `*'
;             (assign argl (op cons) (reg val) (reg argl))
;             (restore proc) ; restore `*'
;             (restore continue)
;           ;; apply `*' and return its value
;             (test (op primitive-procedure?) (reg proc))
;             (branch (label primitive-branch14))
;           compiled-branch13
;           ;; note that a compound procedure here is called tail-recursively
;             (assign val (op compiled-procedure-entry) (reg proc))
;             (goto (reg val))
;           primitive-branch14
;             (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
;             (goto (reg continue))
;           after-call12
;           after-if3
;           after-lambda1
;           ;; assign the procedure to the variable `factorial'
;             (perform
;              (op define-variable!) (const factorial) (reg val) (reg env))
;             (assign val (const ok))
; 
; {{{3 Solution
; {{{2 Exercise 5.35:
; {{{3 Problem
;      What expression was compiled to produce the code
;      shown in *Note Figure 5-18::?
; 
;      *Figure 5.18:* An example of compiler output.  See *Note Exercise
;      5-35::.
; 
;           (assign val (op make-compiled-procedure) (label entry16)
;                                                      (reg env))
;             (goto (label after-lambda15))
;           entry16
;             (assign env (op compiled-procedure-env) (reg proc))
;             (assign env
;                     (op extend-environment) (const (x)) (reg argl) (reg env))
;             (assign proc (op lookup-variable-value) (const +) (reg env))
;             (save continue)
;             (save proc)
;             (save env)
;             (assign proc (op lookup-variable-value) (const g) (reg env))
;             (save proc)
;             (assign proc (op lookup-variable-value) (const +) (reg env))
;             (assign val (const 2))
;             (assign argl (op list) (reg val))
;             (assign val (op lookup-variable-value) (const x) (reg env))
;             (assign argl (op cons) (reg val) (reg argl))
;             (test (op primitive-procedure?) (reg proc))
;             (branch (label primitive-branch19))
;           compiled-branch18
;             (assign continue (label after-call17))
;             (assign val (op compiled-procedure-entry) (reg proc))
;             (goto (reg val))
;           primitive-branch19
;             (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
;           after-call17
;             (assign argl (op list) (reg val))
;             (restore proc)
;             (test (op primitive-procedure?) (reg proc))
;             (branch (label primitive-branch22))
;           compiled-branch21
;             (assign continue (label after-call20))
;             (assign val (op compiled-procedure-entry) (reg proc))
;             (goto (reg val))
;           primitive-branch22
;             (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
; 
;           after-call20
;             (assign argl (op list) (reg val))
;             (restore env)
;             (assign val (op lookup-variable-value) (const x) (reg env))
;             (assign argl (op cons) (reg val) (reg argl))
;             (restore proc)
;             (restore continue)
;             (test (op primitive-procedure?) (reg proc))
;             (branch (label primitive-branch25))
;           compiled-branch24
;             (assign val (op compiled-procedure-entry) (reg proc))
;             (goto (reg val))
;           primitive-branch25
;             (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
;             (goto (reg continue))
;           after-call23
;           after-lambda15
;             (perform (op define-variable!) (const f) (reg val) (reg env))
;             (assign val (const ok))
; 
; {{{3 Solution
; {{{2 Exercise 5.36:
; {{{3 Problem
;      What order of evaluation does our compiler
;      produce for operands of a combination?  Is it left-to-right,
;      right-to-left, or some other order?  Where in the compiler is this
;      order determined?  Modify the compiler so that it produces some
;      other order of evaluation.  (See the discussion of order of
;      evaluation for the explicit-control evaluator in section *Note
;      5-4-1::.)  How does changing the order of operand evaluation
;      affect the efficiency of the code that constructs the argument
;      list?
; 
; {{{3 Solution
; {{{2 Exercise 5.37:
; {{{3 Problem
;      One way to understand the compiler's `preserving'
;      mechanism for optimizing stack usage is to see what extra
;      operations would be generated if we did not use this idea.  Modify
;      `preserving' so that it always generates the `save' and `restore'
;      operations.  Compile some simple expressions and identify the
;      unnecessary stack operations that are generated.  Compare the code
;      to that generated with the `preserving' mechanism intact.
; 
; {{{3 Solution
; {{{2 Exercise 5.38:
; {{{3 Problem
;      Our compiler is clever about avoiding unnecessary
;      stack operations, but it is not clever at all when it comes to
;      compiling calls to the primitive procedures of the language in
;      terms of the primitive operations supplied by the machine.  For
;      example, consider how much code is compiled to compute `(+ a 1)':
;      The code sets up an argument list in `argl', puts the primitive
;      addition procedure (which it finds by looking up the symbol `+' in
;      the environment) into `proc', and tests whether the procedure is
;      primitive or compound.  The compiler always generates code to
;      perform the test, as well as code for primitive and compound
;      branches (only one of which will be executed).  We have not shown
;      the part of the controller that implements primitives, but we
;      presume that these instructions make use of primitive arithmetic
;      operations in the machine's data paths.  Consider how much less
;      code would be generated if the compiler could "open-code"
;      primitives--that is, if it could generate code to directly use
;      these primitive machine operations.  The expression `(+ a 1)'
;      might be compiled into something as simple as (1)
; 
;           (assign val (op lookup-variable-value) (const a) (reg env))
;           (assign val (op +) (reg val) (const 1))
; 
;      In this exercise we will extend our compiler to support open
;      coding of selected primitives.  Special-purpose code will be
;      generated for calls to these primitive procedures instead of the
;      general procedure-application code.  In order to support this, we
;      will augment our machine with special argument registers `arg1'
;      and `arg2'.  The primitive arithmetic operations of the machine
;      will take their inputs from `arg1' and `arg2'. The results may be
;      put into `val', `arg1', or `arg2'.
; 
;      The compiler must be able to recognize the application of an
;      open-coded primitive in the source program.  We will augment the
;      dispatch in the `compile' procedure to recognize the names of
;      these primitives in addition to the reserved words (the special
;      forms) it currently recognizes.(2) For each special form our
;      compiler has a code generator.  In this exercise we will construct
;      a family of code generators for the open-coded primitives.
; 
;        a. The open-coded primitives, unlike the special forms, all need
;           their operands evaluated.  Write a code generator
;           `spread-arguments' for use by all the open-coding code
;           generators.  `Spread-arguments' should take an operand list
;           and compile the given operands targeted to successive
;           argument registers.  Note that an operand may contain a call
;           to an open-coded primitive, so argument registers will have
;           to be preserved during operand evaluation.
; 
;        b. For each of the primitive procedures `=', `*', `-', and `+',
;           write a code generator that takes a combination with that
;           operator, together with a target and a linkage descriptor,
;           and produces code to spread the arguments into the registers
;           and then perform the operation targeted to the given target
;           with the given linkage.  You need only handle expressions
;           with two operands.  Make `compile' dispatch to these code
;           generators.
; 
;        c. Try your new compiler on the `factorial' example.  Compare
;           the resulting code with the result produced without open
;           coding.
; 
;        d. Extend your code generators for `+' and `*' so that they can
;           handle expressions with arbitrary numbers of operands.  An
;           expression with more than two operands will have to be
;           compiled into a sequence of operations, each with only two
;           inputs.
; 
; {{{3 Solution
; 
; {{{1 5.5.6 Lexical Addressing
; {{{2 Exercise 5.39:
; {{{3 Problem
;      Write a procedure `lexical-address-lookup' that
;      implements the new lookup operation.  It should take two
;      arguments--a lexical address and a run-time environment--and
;      return the value of the variable stored at the specified lexical
;      address.  `Lexical-address-lookup' should signal an error if the
;      value of the variable is the symbol `*unassigned*'.(2) Also write
;      a procedure `lexical-address-set!' that implements the operation
;      that changes the value of the variable at a specified lexical
;      address.
; 
; {{{3 Solution
; {{{2 Exercise 5.40:
; {{{3 Problem
;      Modify the compiler to maintain the compile-time
;      environment as described above.  That is, add a
;      compile-time-environment argument to `compile' and the various code
;      generators, and extend it in `compile-lambda-body'.
; 
; {{{3 Solution
; {{{2 Exercise 5.41:
; {{{3 Problem
;      Write a procedure `find-variable' that takes as
;      arguments a variable and a compile-time environment and returns
;      the lexical address of the variable with respect to that
;      environment.  For example, in the program fragment that is shown
;      above, the compile-time environment during the compilation of
;      expression <E1> is `((y z) (a b c d e) (x y))'.  `Find-variable'
;      should produce
; 
;           (find-variable 'c '((y z) (a b c d e) (x y)))
;           (1 2)
; 
;           (find-variable 'x '((y z) (a b c d e) (x y)))
;           (2 0)
; 
;           (find-variable 'w '((y z) (a b c d e) (x y)))
;           not-found
; 
; {{{3 Solution
; {{{2 Exercise 5.42:
; {{{3 Problem
;      Using `find-variable' from *Note Exercise 5-41::,
;      rewrite `compile-variable' and `compile-assignment' to output
;      lexical-address instructions.  In cases where `find-variable'
;      returns `not-found' (that is, where the variable is not in the
;      compile-time environment), you should have the code generators use
;      the evaluator operations, as before, to search for the binding.
;      (The only place a variable that is not found at compile time can
;      be is in the global environment, which is part of the run-time
;      environment but is not part of the compile-time environment.(3)
;      Thus, if you wish, you may have the evaluator operations look
;      directly in the global environment, which can be obtained with the
;      operation `(op get-global-environment)', instead of having them
;      search the whole run-time environment found in `env'.)  Test the
;      modified compiler on a few simple cases, such as the nested
;      `lambda' combination at the beginning of this section.
; 
; {{{3 Solution
; {{{2 Exercise 5.43:
; {{{3 Problem
;      We argued in section *Note 4-1-6:: that internal
;      definitions for block structure should not be considered "real"
;      `define's.  Rather, a procedure body should be interpreted as if
;      the internal variables being defined were installed as ordinary
;      `lambda' variables initialized to their correct values using
;      `set!'.  Section *Note 4-1-6:: and *Note Exercise 4-16:: showed
;      how to modify the metacircular interpreter to accomplish this by
;      scanning out internal definitions.  Modify the compiler to perform
;      the same transformation before it compiles a procedure body.
; 
; {{{3 Solution
; {{{2 Exercise 5.44:
; {{{3 Problem
;      In this section we have focused on the use of the
;      compile-time environment to produce lexical addresses.  But there
;      are other uses for compile-time environments.  For instance, in
;      *Note Exercise 5-38:: we increased the efficiency of compiled code
;      by open-coding primitive procedures.  Our implementation treated
;      the names of open-coded procedures as reserved words.  If a
;      program were to rebind such a name, the mechanism described in
;      *Note Exercise 5-38:: would still open-code it as a primitive,
;      ignoring the new binding.  For example, consider the procedure
; 
;           (lambda (+ * a b x y)
;             (+ (* a x) (* b y)))
; 
;      which computes a linear combination of `x' and `y'.  We might call
;      it with arguments `+matrix', `*matrix', and four matrices, but the
;      open-coding compiler would still open-code the `+' and the `*' in
;      `(+ (* a x) (* b y))' as primitive `+' and `*'.  Modify the
;      open-coding compiler to consult the compile-time environment in
;      order to compile the correct code for expressions involving the
;      names of primitive procedures.  (The code will work correctly as
;      long as the program does not `define' or `set!' these names.)
; 
; {{{3 Solution
; 
; {{{1 5.5.7 Interfacing Compiled Code to the Evaluator
; {{{2 Exercise 5.45:
; {{{3 Problem
;      By comparing the stack operations used by
;      compiled code to the stack operations used by the evaluator for the
;      same computation, we can determine the extent to which the
;      compiler optimizes use of the stack, both in speed (reducing the
;      total number of stack operations) and in space (reducing the
;      maximum stack depth).  Comparing this optimized stack use to the
;      performance of a special-purpose machine for the same computation
;      gives some indication of the quality of the compiler.
; 
;        a. *Note Exercise 5-27:: asked you to determine, as a function
;           of n, the number of pushes and the maximum stack depth needed
;           by the evaluator to compute n!  using the recursive factorial
;           procedure given above.  *Note Exercise 5-14:: asked you to do
;           the same measurements for the special-purpose factorial
;           machine shown in *Note Figure 5-11::. Now perform the same
;           analysis using the compiled `factorial' procedure.
; 
;           Take the ratio of the number of pushes in the compiled
;           version to the number of pushes in the interpreted version,
;           and do the same for the maximum stack depth.  Since the
;           number of operations and the stack depth used to compute n!
;           are linear in n, these ratios should approach constants as n
;           becomes large.  What are these constants?  Similarly, find
;           the ratios of the stack usage in the special-purpose machine
;           to the usage in the interpreted version.
; 
;           Compare the ratios for special-purpose versus interpreted
;           code to the ratios for compiled versus interpreted code.  You
;           should find that the special-purpose machine does much better
;           than the compiled code, since the hand-tailored controller
;           code should be much better than what is produced by our
;           rudimentary general-purpose compiler.
; 
;        b. Can you suggest improvements to the compiler that would help
;           it generate code that would come closer in performance to the
;           hand-tailored version?
; 
; {{{3 Solution
; {{{2 Exercise 5.46:
; {{{3 Problem
;      Carry out an analysis like the one in *Note
;      Exercise 5-45:: to determine the effectiveness of compiling the
;      tree-recursive Fibonacci procedure
; 
;           (define (fib n)
;             (if (< n 2)
;                 n
;                 (+ (fib (- n 1)) (fib (- n 2)))))
; 
;      compared to the effectiveness of using the special-purpose
;      Fibonacci machine of *Note Figure 5-12::.  (For measurement of the
;      interpreted performance, see *Note Exercise 5-29::.)  For
;      Fibonacci, the time resource used is not linear in n; hence the
;      ratios of stack operations will not approach a limiting value that
;      is independent of n.
; 
; {{{3 Solution
; {{{2 Exercise 5.47:
; {{{3 Problem
;      This section described how to modify the
;      explicit-control evaluator so that interpreted code can call
;      compiled procedures.  Show how to modify the compiler so that
;      compiled procedures can call not only primitive procedures and
;      compiled procedures, but interpreted procedures as well.  This
;      requires modifying `compile-procedure-call' to handle the case of
;      compound (interpreted) procedures.  Be sure to handle all the same
;      `target' and `linkage' combinations as in `compile-proc-appl'.  To
;      do the actual procedure application, the code needs to jump to the
;      evaluator's `compound-apply' entry point.  This label cannot be
;      directly referenced in object code (since the assembler requires
;      that all labels referenced by the code it is assembling be defined
;      there), so we will add a register called `compapp' to the
;      evaluator machine to hold this entry point, and add an instruction
;      to initialize it:
; 
;           (assign compapp (label compound-apply))
;             (branch (label external-entry))      ; branches if `flag' is set
;           read-eval-print-loop
;             ...
; 
;      To test your code, start by defining a procedure `f' that calls a
;      procedure `g'.  Use `compile-and-go' to compile the definition of
;      `f' and start the evaluator.  Now, typing at the evaluator, define
;      `g' and try to call `f'.
; 
; {{{3 Solution
; {{{2 Exercise 5.48:
; {{{3 Problem
;      The `compile-and-go' interface implemented in
;      this section is awkward, since the compiler can be called only
;      once (when the evaluator machine is started).  Augment the
;      compiler-interpreter interface by providing a `compile-and-run'
;      primitive that can be called from within the explicit-control
;      evaluator as follows:
; 
;           ;;; EC-Eval input:
;           (compile-and-run
;            '(define (factorial n)
;               (if (= n 1)
;                   1
;                   (* (factorial (- n 1)) n))))
;           ;;; EC-Eval value:
;           ok
; 
;           ;;; EC-Eval input:
;           (factorial 5)
;           ;;; EC-Eval value:
;           120
; 
; {{{3 Solution
; {{{2 Exercise 5.49:
; {{{3 Problem
;      As an alternative to using the explicit-control
;      evaluator's read-eval-print loop, design a register machine that
;      performs a read-compile-execute-print loop.  That is, the machine
;      should run a loop that reads an expression, compiles it, assembles
;      and executes the resulting code, and prints the result.  This is
;      easy to run in our simulated setup, since we can arrange to call
;      the procedures `compile' and `assemble' as "register-machine
;      operations."
; 
; {{{3 Solution
; {{{2 Exercise 5.50:
; {{{3 Problem
;      Use the compiler to compile the metacircular
;      evaluator of section *Note 4-1:: and run this program using the
;      register-machine simulator.  (To compile more than one definition
;      at a time, you can package the definitions in a `begin'.)  The
;      resulting interpreter will run very slowly because of the multiple
;      levels of interpretation, but getting all the details to work is
;      an instructive exercise.
; 
; {{{3 Solution
; {{{2 Exercise 5.51:
; {{{3 Problem
;      Develop a rudimentary implementation of Scheme in
;      C (or some other low-level language of your choice) by translating
;      the explicit-control evaluator of section *Note 5-4:: into C.  In
;      order to run this code you will need to also provide appropriate
;      storage-allocation routines and other run-time support.
; 
; {{{3 Solution
; {{{2 Exercise 5.52:
; {{{3 Problem
;      As a counterpoint to exercise *Note Exercise
;      5-51::, modify the compiler so that it compiles Scheme procedures
;      into sequences of C instructions.  Compile the metacircular
;      evaluator of section *Note 4-1:: to produce a Scheme interpreter
;      written in C.
; {{{3 Solution
