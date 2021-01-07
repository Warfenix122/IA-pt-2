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

(defun compara-pecas-linha-coluna (tabuleiro func &optional (indice 0))
  (cond
    ((= (length tabuleiro) indice) nil)
    ((compara-carateristicas (funcall func indice tabuleiro) (carateristicas)) t)
    (t (compara-pecas-linha-coluna tabuleiro func (1+ indice)))
  )
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

