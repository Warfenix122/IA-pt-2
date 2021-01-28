;; (defvar jogada nil)

;; (defun negamax(no tempo-limite &optional (jogador 1) (profundidade 16) (alfa most-negative-fixnum) (beta most-positive-fixnum)
;;                     (tempo-inicial (get-universal-time)) (nos-analisados 1)(nos-cortados 0))
;;   (let*  ((sucessores (ordenar-nos (funcall 'sucessores no jogador) jogador))
;;           (tempo-gasto (- (get-universal-time) tempo-inicial)))
;;     (cond ((or (= profundidade 0) (= (length sucessores) 0) (>= tempo-gasto tempo-limite))
;;       (criar-no-solucao (atualiza-f no (* jogador (no-heuristica no))) nos-analisados nos-cortados tempo-inicial))
;;      (T (negamax-aux no sucessores tempo-limite jogador profundidade alfa beta tempo-inicial nos-analisados nos-cortados))))
;; )

;; (defun negamax-aux(no-pai sucessores tempo-limite jogador profundidade alfa beta tempo-inicial nos-analisados nos-cortados)
;;   (cond
;;    ((= (length sucessores) 1) 
;;     (negamax (inverter-f (car sucessores)) tempo-limite (- jogador) (1- profundidade) (- beta) (- alfa) tempo-inicial (1+ nos-analisados) nos-cortados))
;;    (T (let*  ((solucao (negamax (inverter-f (car sucessores)) tempo-limite (- jogador) (1- profundidade) (- beta) (- alfa)
;;                                    tempo-inicial (1+ nos-analisados) nos-cortados))
;;             (no-solucao (car solucao))
;;             (melhor-valor (compara-f no-solucao no-pai))
;;             (novo-alfa (max alfa (no-heuristica melhor-valor)))
;;             (expandidos (obter-expandidos solucao))       
;;             (cortes (obter-nr-cortes solucao)))
;;       (if (>= novo-alfa beta) (criar-no-solucao no-pai expandidos (1+ cortes) tempo-inicial) (negamax-aux no-pai (cdr sucessores) tempo-limite jogador profundidade novo-alfa beta tempo-inicial expandidos cortes))
;;      )
;;   )
;;  )
;; )

(defun negamax (no jogador &optional (profundidade 16) (alfa most-negative-fixnum) (beta most-positive-fixnum) (expandidos 1) (cortes 0))
  (if (OR (no-solucaop no) (= profundidade 0)) 
    (cria-solucao (atualiza-f no (* jogador (no-heuristica no))) expandidos cortes)
    (let* ((sucessores (ordenar-nos (sucessores no jogador) jogador)))
      (negamax-aux no sucessores jogador profundidade alfa beta expandidos cortes)
    )
  )
)

(defun negamax-aux (no-pai sucessores jogador profundidade alfa beta expandidos cortes)
  (cond
    ((= (length sucessores) 1) (negamax (inverter-f (car sucessores) (- jogador) (1- profundidade) (- beta) (- alfa) (1+ expandidos) cortes)))
  (t
   (let* ( (solucao (negamax (inverter-f (car sucessores)) (- jogador) (1- profundidade) (- beta) (- alfa) (1+ expandidos) cortes))
           (no-solucao (first solucao))
           (melhor-val (compara-f no-pai no-solucao))
           (novo-alfa (max alfa (no-heuristica melhor-val)))
           )
     (cond 
      ((>= novo-alfa beta) (cria-solucao no-pai expandidos (1+ cortes)) )
      (t (negamax-aux no-pai (cdr sucessores) jogador profundidade novo-alfa beta expandidos cortes))
      )
     )
   )
  )
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

(defun no-teste ()
  (criar-no (jogo-teste-2) 0 nil 0 -1)
)

(defun atualiza-f (no valor &optional (posicao 2))
  (cond
    ((= posicao 0) (cons valor (cdr no)))
    (T (cons (car no) (atualiza-f (cdr no) valor (1- posicao))))
  )
)

(defun inverter-f (no)
  (atualiza-f no (- (no-heuristica no)))
)

(defun compara-f (no-a no-b)
  (let ((h-a (no-heuristica no-a))
        (h-b (no-heuristica no-b))
       )
    (cond 
      ((> h-a h-b) no-a)
      (t no-b)
    )
  )
)

(defun cria-solucao(no-jogada nos-analisados nos-cortados &optional tempo-inicial)
  ;(list no-jogada nos-analisados nos-cortados (obter-tempo-gasto tempo-inicial))
  (list no-jogada nos-analisados nos-cortados)
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

(defun no-inicial (jogador)
  (criar-no (tabuleiro-jogo) 0 nil 0 jogador)
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;HEURISTICA;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun heuristica-enunciado (lin col estado peca)
  (let ((p (p lin col (tabuleiro estado) peca)))
      (cond
       ((not p) nil)
       (t (- 4 p))
       )
      )
  )

(defun avalia-jogada (estado lin col peca jogador)
  ;; (cond 
  ;;  ((equal jogador 1) (let* ((linha (linha lin (tabuleiro estado)))
  ;;                            (coluna (coluna col (tabuleiro estado)))
  ;;                            (linha-semelhancas (conta-semelhancas linha peca))
  ;;                            (coluna-semelhancas (conta-semelhancas coluna peca))
  ;;                            )
  ;;                            (cond 
  ;;                             ((= lin col) (if (or (= linha-semelhancas 1) (= coluna-semelhancas 1) (= (conta-semelhancas (diagonal1 tabuleiro) peca) 1))))
  ;;                             ((= (- 3 lin) col) )
  ;;                             (t )
  ;;                           )
                          
  ;;                         ))   ;;;Joga MAX
  ;;  (t) ;;;;; Joga Min
  ;;  )
  (let* ((p-jogada (p lin col estado peca)))
          (cond 
            ((= p-jogada 1) (* jogador 10))
            ((= p-jogada 2) (* jogador 20))
            ((= p-jogada 3) (* (- jogador) 100))
            ((= p-jogada 4) (* jogador 100))
        )
  )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;SORTING;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Estatisticas;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun f-polinomial (B L valor-T)
 "B + B^2 + ... + B^L=T"
  (cond
   ((= 1 L) (- B valor-T))
   (T (+ (expt B L) (f-polinomial B (- L 1) valor-T)))
  )
)

(defun fator-ramificacao (lista &optional (valor-L (tamanho-solucao lista)) (valor-T (numero-nos-gerados lista)) (erro 0.1) (bmin 1) (bmax 10e11))
"Devolve o factor de ramificacao, executando o metodo da bisseccao"
  (let ((bmedio (/ (+ bmin bmax) 2)))
    (cond 
     ((< (- bmax bmin) erro) (/ (+ bmax bmin) 2))
     ((< (f-polinomial bmedio valor-L valor-T) 0) (fator-ramificacao lista valor-L valor-T erro bmedio bmax))
     (t (fator-ramificacao lista valor-L valor-T erro bmin bmedio))
     )
    )
)

(defun numero-nos-gerados (lista)
"Retorna Numero de nos gerados"
  (+ (second lista) (third lista))
)

(defun tamanho-solucao (lista)
"Devolve o comprimento de uma  solucao"
 (length (car lista))
)

(defun numero-sucessores-bfsdfs (lista)
"Numero de nos expandidos bfs and dfs"
  (third lista)
)

(defun penetrancia (lista)
"Penetrancia"
  (/ (tamanho-solucao lista) (numero-nos-gerados lista))
)

(defun no-final (lista)
  (nth (1- (length (car lista)))(car lista))
)
