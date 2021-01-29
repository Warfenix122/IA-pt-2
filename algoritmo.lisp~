(defun memo (fn)
  (let ((table (make-hash-table))) 
    (lambda (x)
      (or (gethash x table)
        (let ((val (funcall fn x)))
         (setf (gethash x table) val)
         val
        )  
      )
    )
  )
)

(defvar memo-negamax (memo 'negamax))
;; (defun negamax (no tempo-limite jogador &optional (profundidade 16) (alfa most-negative-fixnum) (beta most-positive-fixnum) (expandidos 1) (cortes 0) (tempo-inicial (get-universal-time)))
;;   (cond 
;;     ((OR (no-solucaop no) (= profundidade 0) (= (- (get-universal-time) tempo-inicial)) tempo-limite) (* jogador (no-heuristica no)))
;;     (t (let* ((sucessores (ordenar-nos (remove nil (sucessores no jogador)) jogador)))
;;       (negamax-aux no tempo-limite sucessores jogador profundidade alfa beta expandidos cortes tempo-inicial)
;;       ))
;;     )
;;   )

;; (defun negamax-aux (no tempo-limite sucessores jogador profundidade alfa beta expandidos cortes tempo-inicial &optional (max-val most-negative-fixnum))
;;   (let* ((max-valor (max max-val (- (negamax (car sucessores) (- jogador) (1- profundidade) (- beta) (- alfa) (1+ expandidos) cortes tempo-inicial))))
;;              (novo-alfa (max alfa max-valor))
;;              ) 
;;     (if (OR (>= novo-alfa beta) (null (cdr sucessores)))
;;         (set-jogada max-valor (car sucessores) expandidos (1+ cortes))
;;        ;(setq *jogada* (list (no-proxima-jogada (car sucessores)) expandidos (1+ cortes))) 
;;       (negamax-aux no tempo-limite (cdr sucessores) jogador profundidade alfa beta expandidos cortes tempo-inicial max-valor)
;;       )
;;     )
;;   )

(defun negamax(no tempo-limite &optional (jogador 1) (profundidade 16) (alpha most-negative-fixnum) (beta most-positive-fixnum)
                    (tempo-inicial (get-universal-time)) (nos-analisados 1)(nos-cortados 0))
  (let*  ((sucessores (ordenar-nos (funcall 'sucessores no jogador) jogador))
          (tempo-gasto (- (get-universal-time) tempo-inicial)))
    (cond ((or (= profundidade 0) (= (length sucessores) 0) (>= tempo-gasto tempo-limite))
      (cria-solucao (recalcular-h no jogador) nos-analisados nos-cortados tempo-inicial))
     (T (negamax-aux no sucessores tempo-limite jogador profundidade alpha beta tempo-inicial nos-analisados nos-cortados))))
)

(defun negamax-aux(no-pai sucessores tempo-limite jogador profundidade alpha beta tempo-inicial nos-analisados nos-cortados)
  (cond
   ((= (length sucessores) 1) 
    (negamax (inverter-h (car sucessores)) tempo-limite (- jogador) (1- profundidade) (- beta) (- alpha) tempo-inicial (1+ nos-analisados) nos-cortados))
   (T (let*  ((car-solucao (negamax (inverter-h (car sucessores)) tempo-limite (- jogador) (1- profundidade) (- beta) (- alpha)
                                   tempo-inicial (1+ nos-analisados) nos-cortados))
            (car-node (car car-solucao))
            (melhor-valor (compara-h car-node no-pai))
            (novo-alpha (max alpha (no-heuristica melhor-valor)))
            (car-nos-analisados (obter-expandidos car-solucao))       
            (car-nos-cortados (obter-nr-cortes car-solucao)))
      (if (>= novo-alpha beta)
          (cria-solucao no-pai car-nos-analisados (1+ car-nos-cortados) tempo-inicial)
        (negamax-aux no-pai (cdr sucessores) tempo-limite jogador profundidade novo-alpha beta tempo-inicial car-nos-analisados car-nos-cortados)))))
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;NOS;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun criar-no (tabuleiro &optional (profundidade 0) (pai nil) (valor-f 0) jogador)
    (list tabuleiro profundidade valor-f pai jogador)
)

(defun novo-sucessor (lin col peca no fnHeuristica pred jogador)
  (let* ((profundidade (1+ (no-profundidade no)))
        (heuristica (funcall fnHeuristica lin col (tabuleiro (no-estado no)) peca))
        )
    (cond 
     ((equal (funcall pred lin col peca (no-estado no)) NIL) NIL)
     (t (criar-no (funcall pred lin col peca (no-estado no)) profundidade no heuristica jogador))
     )
   )
  )

(defun set-jogada(valor-maximo no expandidos cortes)
  (let ((por-variavel (setq *jogada* (list (no-proxima-jogada no) expandidos cortes))))
    valor-maximo
    )
)

(defun no-teste ()
  (criar-no (jogo-teste-2) 0 nil 0 -1)
)

(defun recalcular-h (no jogador)
  (substituir-valor no 2 (* jogador (no-heuristica no)))
)

(defun substituir-valor (lista n valor)
  (cond ((null lista) NIL)
        ((equal n 0) (cons valor (cdr lista)))
        (T (cons (car lista) (substituir-valor (cdr lista) (- n 1) valor)))))

(defun inverter-h (no)
  (substituir-valor no 2 (- (no-heuristica no)))
)

(defun compara-h (no-a no-b)
  (let ((h-a (no-heuristica no-a))
        (h-b (no-heuristica no-b))
       )
    (cond 
      ((> h-a h-b) no-a)
      (t no-b)
    )
  )
)

(defun no-inicial ()
  (criar-no (tabuleiro-jogo))
)

(defun cria-solucao(no-jogada nos-analisados nos-cortados &optional tempo-inicial)
  (list no-jogada nos-analisados nos-cortados (obter-tempo-gasto tempo-inicial))
)

(defun obter-jogada-solucao(no-solucao)
  (first no-solucao)
)

(defun obter-tempo-gasto(tempo-inicial)
  (- (get-universal-time) tempo-inicial)
)


(defun obter-expandidos(no-solucao)
   (second no-solucao)
)


(defun obter-nr-cortes(no-solucao)
   (third no-solucao)
)


(defun obter-tempo-gasto-solucao(no-solucao)
  (fourth no-solucao)
)

(defun no-proxima-jogada (no)
  (cond 
    ((equal (no-pai (no-pai no)) nil) no)
    (t (no-pai no))
  )
)

(defun no-estado (no)
    (first no)
)

(defun no-profundidade (no)
    (second no)
)

(defun no-heuristica (no)
    (third no)
)

(defun no-pai (no)
    (fourth no)
)

(defun no-jogador (no)
  (fifth no)
)

(defun no-solucaop (no)
  (cond
   ((not no) nil)
   (t (let* ((tabuleiro (tabuleiro (no-estado no)))
             (venceu (venceup tabuleiro))
             )
        (if (equal venceu t) t nil)
        )
      )
   )
)

(defun no-existep (no lista-nos algoritmo)
  "Verifica se o estado existe na lista passada no argumento"
  (cond 
   ((null lista-nos) no)
   ((and (eq algoritmo 'a*) (estadop (no-estado no) (no-estado (car lista-nos))) (= (no-heuristica no) (no-heuristica (car lista-nos)))) NIL)
   ((estadop (no-estado no) (no-estado (car lista-nos))) NIL)
   (t (no-existep no (cdr lista-nos) algoritmo))
   )
)

(defun estadop (estado1 estado2)
  "Compara dois estados"
  (cond
   ((and (equal (tabuleiro estado1) (tabuleiro estado2)) (equal (reserva estado1) (reserva estado2))) T)
   (T NIL)
   )
)

(defun sucessores (no jogador)
  (let* ((posicoes (posicoes))
          (sucessores (por-pecas-posicao no posicoes 'p
 jogador))
              (sucessores-possiveis (remove nil (mapcar #'(lambda (sucessor)
                                                            (cond 
                                                             ((and (estadop (no-estado no) (no-estado sucessor)) (> (no-heuristica sucessor) (no-heuristica no)))NIL)
                                                             (T sucessor)
                                                             )
                                                            )sucessores)))
              )sucessores-possiveis)
  
  )

(defun por-pecas-posicao (no posicoes fnHeuristica jogador &optional (sucessores-aux '()) )
    (cond
      ((null posicoes) sucessores-aux)
      (T (let* ((coordenadas (car posicoes))
                (pecas (remove 0 (reserva (no-estado no))))
                (sucessores (remove nil(mapcar #'(lambda (peca)
                                                   (novo-sucessor (first coordenadas) (second coordenadas) peca no fnHeuristica 'operador jogador)
                                                   ;; (cond
                                                   ;;  ((eq algoritmo 'a*) (novo-sucessor-a* (first coordenadas) (second coordenadas) peca no fnHeuristica 'operador))
                                                   ;;  (t (novo-sucessor (first coordenadas) (second coordenadas) peca no 'operador))
                                                   ;;  )
                                                   ) pecas))))
           (por-pecas-posicao no (cdr posicoes) fnHeuristica jogador (append sucessores-aux sucessores))
      )
    )
  )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;SORTING;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun ordenar-nos (lista-nos jogador)
  "Quick sort da lista de nos, faz sort crescente dependendo do f calculado"
  (cond
    ((null lista-nos) nil)
    ((= jogador 1)
      (append
        (ordenar-nos (lista>= (car lista-nos) (cdr lista-nos)) jogador)
        (cons (car lista-nos) nil) 
        (ordenar-nos (lista< (car lista-nos) (cdr lista-nos)) jogador))
    )
    (t (append
        (ordenar-nos (lista< (car lista-nos) (cdr lista-nos))jogador)
        (cons (car lista-nos) nil) 
        (ordenar-nos (lista>= (car lista-nos) (cdr lista-nos))jogador)))
  )
)

(defun lista< (a b)
  (cond
    ((or (null a) (null b)) nil)
    ((< (no-heuristica a) (no-heuristica (car b))) (lista< a (cdr b)))
    (t (cons (car b) (lista< a (cdr b))))
  )
)

(defun lista>= (a b)
  (cond
    ((or (null a) (null b)) nil)
    ((>= (no-heuristica a) (no-heuristica (car b))) (lista>= a (cdr b)))
    (t (cons (car b) (lista>= a (cdr b))))
  )
)

(defun retirar-no-lista (no lista-nos)
  (cond
    ((null lista-nos) nil)
    ((estadop (no-estado no) (no-estado (car lista-nos))) (cons nil (retirar-no-lista no (cdr lista-nos))))
    (t (cons (car lista-nos) (retirar-no-lista no (cdr lista-nos))))
  )
)
