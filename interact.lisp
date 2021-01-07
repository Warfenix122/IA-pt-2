(defun path ()
    "C:\\Users\\Warfe\\OneDrive\\Documentos\\GitHub\\IA-pt-2"
)

(load (compile-file (concatenate 'string (path) "/jogo.lisp")))
(load (compile-file (concatenate 'string (path) "/algoritmo.lisp")))


(defun menu-inicial ()
  (format t "~% --------------------------------------------------------- ")
  (format t "~%|              Quatro - Escolha uma opcao                 |")
  (format t "~%|                                                         |")
  (format t "~%|                1 -  Humano vs Computador                |")
  (format t "~%|                2 - Computador vs Computador             |")
  (format t "~%|                3 - Sair                                 |")
  (format t "~%|                                                         |")
  (format t "~% ---------------------------------------------------------~%~%> ")
)

(defun menu-primeiro-jogador ()
    (format t "~%------------------------------------------")
    (format t "~%|       Qual jogador vai primeiro?       !")
    (format t "~%|                 1 - Jogador             ")
    (format t "~%|                 2 - Computador          ")
    (format t "~%------------------------------------------")
)

(defun mostrar-lista (lista)
    (cond 
        ((null lista) nil)
        (t (format t "~a~%" (car lista)))
    )
)

(defun escolher-opcao ()
    (let* ((menu (menu-inicial))
            (opcao (read))
        )
        (cond 
            ((eq opcao 1) (let* ((jogador-inicial (escolher-jogador))
                                 ()
                                )
            
                ))
        )
    
    )
)

(defun escolher-jogador ()
    (let* ((menu (menu-primeiro-jogador))
            (opcao (read))        
        )
        (cond 
            ((eq opcao 1) 'jogador)
            ((eq opcao 2) 'computador)
            (t (format t "~%Introduza uma opcao valida") (escolher-jogador))
        )

    )
)

(defun jogar-jogadores (tabuleiro jogador tempo)
    (let* ( (tabuleiro (mostrar-lista (tabuleiro tabuleiro)))
            (reserva (mostrar-lista (reserva tabuleiro)))
            ()
        )
    )
)