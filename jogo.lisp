(defun tabuleiro-jogo ()
"Funcao que representa um tabuleiro de teste"
'(
    (
        (0 0 0 0) 
        (0 0 0 0) 
        (0 0 0 0) 
        (0 0 0 0)
    )
    (
        (branca redonda alta oca)
        (preta redonda alta oca)
        (branca redonda baixa oca)
        (preta redonda baixa oca) 
        (branca quadrada alta oca)
        (preta quadrada alta oca)
        (branca quadrada baixa oca)
        (preta quadrada baixa oca)
        (branca redonda alta cheia)
        (preta redonda alta cheia)
        (branca redonda baixa cheia)
        (preta redonda baixa cheia)
        (branca quadrada alta cheia)
        (preta quadrada alta cheia)
        (branca quadrada baixa cheia)
        (preta quadrada baixa cheia)
    )
) 
)

(defun jogo-teste-1 ()
'(
    (
        ((branca redonda alta oca) 0 0 0) 
        (0 (branca redonda baixa oca) 0 0) 
        (0 0 (branca quadrada alta oca) 0) 
        (0 0 0 0)
    )
    (
        0
        (preta redonda alta oca)
        0
        (preta redonda baixa oca) 
        0
        (preta quadrada alta oca)
        (branca quadrada baixa oca)
        (preta quadrada baixa oca)
        (branca redonda alta cheia)
        (preta redonda alta cheia)
        (branca redonda baixa cheia)
        (preta redonda baixa cheia)
        (branca quadrada alta cheia)
        (preta quadrada alta cheia)
        (branca quadrada baixa cheia)
        (preta quadrada baixa cheia)
    )
)
)

(defun jogo-teste-2 ()
'(
    (
        ((branca redonda alta oca) (branca redonda baixa oca) (branca quadrada alta oca) 0) 
        (0 0 0 0) 
        (0 0 0 0) 
        (0 0 0 0)
    )
    (
        0
        (preta redonda alta oca)
        0
        (preta redonda baixa oca) 
        0
        (preta quadrada alta oca)
        (branca quadrada baixa oca)
        (preta quadrada baixa oca)
        (branca redonda alta cheia)
        (preta redonda alta cheia)
        (branca redonda baixa cheia)
        (preta redonda baixa cheia)
        (branca quadrada alta cheia)
        (preta quadrada alta cheia)
        (branca quadrada baixa cheia)
        (preta quadrada baixa cheia)
    )
)
)

(defun jogo-teste-3 ()
'(
    (
        ((branca redonda alta oca) 0 0 0) 
        ((branca redonda baixa oca) 0 0 0) 
        ((branca quadrada alta oca) 0 0 0) 
        (0 0 0 0)
    )
    (
        0
        (preta redonda alta oca)
        0
        (preta redonda baixa oca) 
        0
        (preta quadrada alta oca)
        (branca quadrada baixa oca)
        (preta quadrada baixa oca)
        (branca redonda alta cheia)
        (preta redonda alta cheia)
        (branca redonda baixa cheia)
        (preta redonda baixa cheia)
        (branca quadrada alta cheia)
        (preta quadrada alta cheia)
        (branca quadrada baixa cheia)
        (preta quadrada baixa cheia)
    )
)
)

(defun jogo-teste-4 ()
'(
    (
        (0 0 0 (branca redonda alta oca)) 
        (0 0 (branca redonda baixa oca) 0) 
        (0 (branca quadrada alta oca) 0 0) 
        (0 0 0 0)
    )
    (
        0
        (preta redonda alta oca)
        0
        (preta redonda baixa oca) 
        0
        (preta quadrada alta oca)
        (branca quadrada baixa oca)
        (preta quadrada baixa oca)
        (branca redonda alta cheia)
        (preta redonda alta cheia)
        (branca redonda baixa cheia)
        (preta redonda baixa cheia)
        (branca quadrada alta cheia)
        (preta quadrada alta cheia)
        (branca quadrada baixa cheia)
        (preta quadrada baixa cheia)
    )
)
)

(defun posicoes ()
  "funcao que retorna todas as posicoes possiveis do tabuleiro"
  (list '(0 0) '(0 1) '(0 2) '(0 3) '(1 0) '(1 1) '(1 2) '(1 3) '(2 0) '(2 1) '(2 2) '(2 3) '(3 0) '(3 1) '(3 2) '(3 3))
)

(defun tabuleiro (jogo)
  "Recebe o tabuleiro do estado"
	(car jogo)
)

(defun reserva (jogo)
"Retorna a reserva do estado"
	(car (cdr jogo))
)

(defun cor (peca)
"Retorna a cor da peca"
	(first peca)
)

(defun forma (peca)
"retorna a forma da peca"
	(second peca)
)

(defun tamanho (peca)
"retorna o tamanho da peca"
	(third peca)
)

(defun preenchimento (peca)
"retorna o preenchimento da peca"
	(fourth peca)
)


(defun carateristicas ()
"retorna a lista de todas as funcoes de comparacao"
  (list 'cor 'forma 'tamanho 'preenchimento)
)


(defun compara-carateristicas (lista carateristicas)
"Compara as carateristicas das pecas na lista"
  (cond
    ((member 0 lista) nil)
    ((null carateristicas) nil)
    ((compara-pecas lista (car carateristicas)) t)
    (t (compara-carateristicas lista (cdr carateristicas)))
  )
)

(defun compara-pecas (lista carateristica &optional (carateristicas '()))
  "Compara a carateristica escolhida e verifica se todos os elementos posuem a mesma carateristica"
  (cond
    ((null lista) (cond
      ((avalia-lista carateristicas) t)
      (t nil)
    ))
    (t (compara-pecas (cdr lista) carateristica (cons (funcall carateristica (car lista)) carateristicas)))
  )
)

(defun avalia-lista (lista &optional (elem-avaliado nil))
  (cond
    ((equal elem-avaliado nil) (avalia-lista (cdr lista) (car lista)))
    ((null lista) t)
    ((equal (car lista) elem-avaliado) (avalia-lista (cdr lista) (car lista)))
    (t NIL)
  )
)

(defun contar-carateristica-comuns (lista peca carateristica &optional (comum 0)) ;;;--> limpar os 0 quando estiver a verificar
  (cond
    ((equal (car lista) 0) (contar-carateristica-comuns (cdr lista) peca carateristica comum))
    ((equal (funcall carateristica (car lista)) (funcall carateristica peca)) (contar-carateristica-comuns (cdr lista) peca carateristica (1+ comum)))
    ((null lista) comum)
    (t (contar-carateristica-comuns (cdr lista) peca carateristica comum))
  )
)

;; (defun p (lin col tabuleiro peca)
;;   (if (casa-vaziap lin col tabuleiro) 
;;     (let* ((linha (linha lin tabuleiro))
;;          (coluna (coluna col tabuleiro))
;;   )
;;    (max-heuristica (mapcar #'(lambda (carateristica)
;;     (cond
;;        ((or (and (= lin 0) (= col 0)) (and (= lin 1) (= col 1)) (and (= lin 2) (= col 2)) (and (= lin 3) (= col 3))) (max (contar-carateristica-comuns linha peca carateristica) (contar-carateristica-comuns coluna peca carateristica)
;;        (contar-carateristica-comuns (diagonal-1 tabuleiro) peca carateristica)))
;;        ((or (and (= lin 0) (= col 3)) (and (= lin 1) (= col 2)) (and (= lin 2) (= col 1)) (and (= lin 3) (= col 0))) (max (contar-carateristica-comuns linha peca carateristica) (contar-carateristica-comuns coluna peca carateristica)
;;        (contar-carateristica-comuns (diagonal-2 tabuleiro) peca carateristica)))
;;        (t (max (contar-carateristica-comuns linha peca carateristica) (contar-carateristica-comuns coluna peca carateristica)
;;        ))
;;      ))(carateristicas))
;;   )
;;   ) nil)
;; )

(defun p (lin col tabuleiro peca)
  (cond
   ((casa-vaziap lin col tabuleiro) (let ((linha (linha lin tabuleiro))
                                          (coluna (coluna col tabuleiro))
                                          (diagonal-1 (diagonal-1 tabuleiro))
                                          (diagonal-2 (diagonal-2 tabuleiro))
                                          )
                                      (cond 
                                       ((= lin col) (max (first (conta-semelhancas linha peca)) (first (conta-semelhancas coluna peca)) (first (conta-semelhancas diagonal-1 peca)))) ;;;; verifica coluna-linha-diagonal-1
                                       ((= (- 3 lin) col) (max (first (conta-semelhancas linha peca)) (first (conta-semelhancas coluna peca)) (first (conta-semelhancas diagonal-2 peca))))
                                       (t (max (first (conta-semelhancas linha peca)) (first (conta-semelhancas coluna peca))))
                                       ) ;;;; verifica coluna-linha-diagonal-2  
                                     )
    )
    (t nil) 
   )
  )

(defun p-no (no)
  (let* ((tabuleiro (tabuleiro (no-estado no)))
         (linhas (verifica-tabuleiro-combinacoes tabuleiro 'linha))
         (colunas (verifica-tabuleiro-combinacoes tabuleiro 'coluna))
         (diagonal1 (verifica-tabuleiro-combinacoes tabuleiro 'diagonal-1))
         (diagonal2 (verifica-tabuleiro-combinacoes tabuleiro 'diagonal-2))
         )
    (max (first linhas) (first colunas) (first diagonal1) (first diagonal2))
    )
)

(defun verifica-tabuleiro-combinacoes (tabuleiro fnlista &optional (index 0) (nr-semelhancas 0) carateristica)
  (cond
   ((= index 4) (list nr-semelhancas carateristica))
   ((or (equal fnlista 'diagonal-1) (equal fnlista 'diagonal-2)) (let ((lista (funcall fnlista tabuleiro)))
                                                                  (cond 
                                                                    ((atom (car lista)) (list 0 nil))
                                                                    (t (conta-semelhancas (cdr lista) (car lista)))
                                                                 )
                                                                )
                                                              )
   (t (let ((lista (funcall fnlista index tabuleiro)))
        (cond 
         ((atom (car lista)) (verifica-tabuleiro-combinacoes tabuleiro fnlista (1+ index) nr-semelhancas carateristica))
         (t (let* ((peca (car lista))
                   (semelhancas (conta-semelhancas (cdr lista) peca))
                   (nr-max-semelhancas (max (first semelhancas) nr-semelhancas))
                   )
              (cond
               ((= nr-max-semelhancas nr-semelhancas) (verifica-tabuleiro-combinacoes tabuleiro fnlista (1+ index) nr-max-semelhancas carateristica))
               ((= nr-max-semelhancas (first semelhancas)) (verifica-tabuleiro-combinacoes tabuleiro fnlista (1+ index) nr-max-semelhancas (second semelhancas)))
               )
              ))
         )
        )
      )
   )
  )

;; (defun compara-pecas-linha-coluna (tabuleiro func &optional (indice 0))
;;   (cond
;;     ((= (length tabuleiro) indice) nil)
;;     ((compara-carateristicas (funcall func indice tabuleiro) (carateristicas)) t)
;;     (t (compara-pecas-linha-coluna tabuleiro func (1+ indice)))
;;   )
;; )

;; (defun atribuir-pontos-tabuleiro (tabuleiro &optional ())
;;   ()
;; )

;; (defun compara-carateristica (lista &optional (peca '()) (count 0) (carateristica))
;;   (cond 
;;    ((null lista) ())
;;    ((equal (car lista) ) )
;;    ((listp (car lista)) (compara-carateristica (cdr lista) (car lista) (0)))
;;    )
;; )

(defun conta-semelhancas (lista peca)
  (let* ((nr-semelhancas-cor (conta-semelhancas-aux lista 'cor (cor peca)))
        (nr-semelhancas-tamanho (conta-semelhancas-aux lista 'tamanho (tamanho peca)))
        (nr-semelhancas-forma (conta-semelhancas-aux lista 'forma (forma peca)))
        (nr-semelhancas-preenchimento (conta-semelhancas-aux lista 'preenchimento (preenchimento peca)))
        (max-semelhancas (max (first nr-semelhancas-cor) (first nr-semelhancas-tamanho) (first nr-semelhancas-forma) (first nr-semelhancas-preenchimento)))
       )
    (cond
      ((= max-semelhancas 0) (list max-semelhancas))
      ((equal max-semelhancas(first nr-semelhancas-cor)) (list (1+ max-semelhancas) (second nr-semelhancas-cor)))
      ((equal max-semelhancas (first nr-semelhancas-tamanho)) (list (1+ max-semelhancas) (second nr-semelhancas-tamanho)))
      ((equal max-semelhancas (first nr-semelhancas-forma)) (list (1+ max-semelhancas) (second nr-semelhancas-forma)))
      ((equal max-semelhancas (first nr-semelhancas-preenchimento)) (list (1+ max-semelhancas) (second nr-semelhancas-preenchimento)))
    )
  )
)

(defun conta-semelhancas-aux (lista fnCaracteristica carateristica &optional (semelhancas 0))
  (cond 
    ((null lista) (list semelhancas carateristica))
    ((atom (car lista)) (conta-semelhancas-aux (cdr lista) fnCaracteristica carateristica semelhancas))
    ((equal (funcall fnCaracteristica (car lista)) carateristica) (conta-semelhancas-aux (cdr lista) fnCaracteristica carateristica (1+ semelhancas)))
    (t (conta-semelhancas-aux (cdr lista) fnCaracteristica carateristica semelhancas))
  )
)

(defun max-heuristica (lista &optional (max 0))
  (cond 
    ((null lista) (if (> max 0) (1+ max) 0))
    ((equal (car lista) 0) (max-heuristica (cdr lista) 0))
    ;((>= max (car lista)) (max-heuristica (cdr lista) max))
    ((< max (car lista)) (max-heuristica (cdr lista) (car lista)))
    (t (max-heuristica (cdr lista) max))
  )
)

(defun linha (index tabuleiro)
"retorna uma linha do tabuleiro"
  (cond 
   ((= index 0) (car tabuleiro))
   (t (linha (- index 1) (cdr tabuleiro)))
   )
)

(defun coluna (index tabuleiro)
"retorna uma coluna do tabuleiro"
  (cond
   ((null tabuleiro) NIL)
   ((= index 0) (cons (first (car tabuleiro)) (coluna index (cdr tabuleiro))))
   ((= index 1) (cons (second (car tabuleiro)) (coluna index (cdr tabuleiro))))
   ((= index 2) (cons (third (car tabuleiro)) (coluna index (cdr tabuleiro))))
   ((= index 3) (cons (fourth (car tabuleiro)) (coluna index (cdr tabuleiro))))
   )
)

(defun get-celula (lin col)
  (cond 
   ((eq (car lin) (car col)) (car lin))
   (t (get-celula (cdr lin) (cdr col)))
   )
)



(defun celula (x y tabuleiro)
  (let ((lin (linha x tabuleiro)))
    (cond 
     ((= y 0) (first lin))
     ((= y 1) (second lin))
     ((= y 2) (third lin))
     ((= y 3) (fourth lin))
     )
    )
  )

(defun diagonal-1 (tabuleiro &optional (x 0) (y 0))
  (cond 
   ((and (= x 4) (= y 4)) NIL)
   (t (cons (celula x y tabuleiro) (diagonal-1 tabuleiro (+ x 1) (+ y 1))))
   )
)

(defun diagonal-2 (tabuleiro &optional (x 3) (y 0))
  (cond 
   ((and (= x -1) (= y 4)) NIL)
   (t (cons (celula x y tabuleiro) (diagonal-2 tabuleiro (- x 1) (+ y 1))))
   )
)

(defun casa-vaziap (x y tabuleiro)
  (cond 
   ((atom (celula x y tabuleiro)) T)
   (t NIL)
   )
)

(defun remover-peca (peca reserva)
  (cond
   ((null reserva) NIL)
   ((equal peca (car reserva)) (cons 0 (remover-peca peca (cdr reserva))))
   (t (cons (car reserva) (remover-peca peca (cdr reserva))))
   )
)

(defun substituir-posicao (index peca linha)
  (cond 
   ((= index 0) (cons peca (cdr linha)))
   (t (cons (car linha) (substituir-posicao (- index 1) peca (cdr linha))))
   )
  )

(defun substituir (lin col peca tabuleiro)
  (cond
   ((= lin 0) (cons (substituir-posicao col peca (linha 0 tabuleiro)) (cdr tabuleiro)))
   (t (cons (linha 0 tabuleiro) (substituir (- lin 1) col peca (cdr tabuleiro))))
   )
)

(defun operador (lin col peca estado)
  "Mete a peca na coordenada e retira da reserva"
  (cond 
   ((casa-vaziap lin col (tabuleiro estado)) (let* (
                                                       (remove-peca (remover-peca peca (reserva estado)))
                                                       (movimentar (substituir lin col peca (tabuleiro estado)))
                                                       )
                                                  (list movimentar remove-peca)
                                                  )
    )
   (t NIL)
   )
)

(defun retornar-espacos-vazios (estado &optional (lin 0) (col 0))
  (cond 
   ((> col 3) (retornar-espacos-vazios estado (+ lin 1) 0))
   ((and (= lin 3) (= col 3)) (if (= (celula lin col (tabuleiro estado)) 0) (cons (list lin col) nil) nil))
   ((= (celula lin col (tabuleiro estado)) 0) (cons (list lin col) (retornar-espacos-vazios estado  lin (+ col 1))))
  )
)

(defun tabuleiro-preenchidop (tabuleiro)
  (cond
    ((null tabuleiro) T)
    ((member 0 (car tabuleiro)) NIL)
    (t (tabuleiro-preenchidop (cdr tabuleiro)))
  )
)

(defun venceup (tabuleiro)
  (let ((linhas (verifica-tabuleiro-combinacoes tabuleiro 'linha))
        (colunas (verifica-tabuleiro-combinacoes tabuleiro 'coluna))
        (diagonal1 (verifica-tabuleiro-combinacoes tabuleiro 'diagonal-1))
        (diagonal2 (verifica-tabuleiro-combinacoes tabuleiro 'diagonal-2))
        )
    (cond
     ((or (= (first linhas) 4) (= (first colunas) 4) (= (first diagonal1)4 ) (= (first diagonal2) 4)) t)
     (t nil)
     )
    )
  )

;(print (venceup (operador 0 3 '(branca quadrada baixa oca) (jogo-teste-2))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;GERAR ARVORE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 