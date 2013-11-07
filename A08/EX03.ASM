DUMPER 		>
DUMP_INI 	>
DUMP_TAM 	>
DUMP_UL 	>
DUMP_BL 	>
DUMP_EXE 	>

				&	/0000

;========= PARAMETROS ===============

DUMP_INI 		K		/0000		; inicia com 0
DUMP_TAM 		K		/0000		; inicia com 0
DUMP_UL 		K		/0000		; inicia com 0
DUMP_BL 		K		/0000		; inicia com 0
DUMP_EXE 		K		/0000		; inicia com 0

;========= CONSTANTES ===============

ZERO			  K		/0
ONE				  K		/1
TWO			  	K		/2			; Constante 'Dois'
THREE			  K		/3
LOAD			  K		/8000		; Instrucao de load sem endereco
LOAD_GRAVA	K		/E300		; Instrucao de gravacao no disco sem o numero do disco

;========= VARIAVEIS ====================

POSICAO			  K		/000		; Posicao atual da memoria
GRAVA_DADO	  K		/0000		; Dado a ser gravado na UL
BLOCO_CONT  	K		/1			; CONTADOR DO BLOCO
DUMP_FIM	  	K		/0000		; ENDERECO FINAL DO DUMP
CHECK_SUM	  	K		/0000		; CHECKSUM
CS_DADO		  	K		/0000		; DADO PARA INCREMENTAR NO CHECKSUM
DUMPED_WORDS	K		/0000		; NUMERO DE PALAVRAS JA DUMPEADAS
BL_SIZE		  	K		/0000

;========= INICIO DA SUB-ROTINA =========

DUMPER 		K	/0000			
			  	LD	DUMP_INI		
			  	MM	GRAVA_DADO
				  SC	GRAVA_EXT
				  LD	DUMP_TAM
				  MM	GRAVA_DADO
				  SC	GRAVA_EXT		; GRAVA 'DUMP_INI' E 'DAMP_TAM' NO INICIO DO ARQUIVO
				

				  LD	DUMP_INI		; COLOCA O ENDEREÇO INICIAL NA VARIAVEL POSICAO
				  MM	POSICAO
				

				  LD	DUMP_TAM		
				  *	  TWO
			  	+	  DUMP_INI
			  	- 	TWO
			  	MM	DUMP_FIM		; CALCULA O ENDERECO DA ULTIMA POSICAO DE MEMORIA E GRAVA EM 'DUMP_FIM'


LOOP			LD	DUMP_TAM		; LOOP PRINCIPAL: WHILE (DUMP_TAM >= DUMPED_WORDS)
			  	-	  DUMPED_WORDS
			  	JZ	LOOP_FIM
;------------------------------------

POSIC_UM	LD	POSICAO 		; GRAVA O ENDERECO DO PRIMEIRO ELEMENTO DO BLOCO E SOMA NO CHECKSUM
			  	MM	CS_DADO
			  	MM	GRAVA_DADO
				  SC	CS_UPDATE	
				  SC	GRAVA_EXT
;-----------------------------------
				
POSIC_DOIS	LD	DUMP_FIM
			    	-	POSICAO
				    -	DUMP_BL
			      JN	TAM_MENOR
			    	LD	DUMP_BL
			    	MM	GRAVA_DADO
			    	MM	CS_DADO
			    	MM	BL_SIZE
			    	SC	CS_UPDATE	
			    	SC	GRAVA_EXT
			    	LD	BLOCO_CONT
			    	+	  ONE
				    MM	BLOCO_CONT		; GRAVA O TAMANHO DO BLOCO PARA O CASO DO BLOCO PADRAO E SOMA NO CHECKSUM
			    	JP	POSIC_MEMO
TAM_MENOR		LD	DUMP_FIM
				    -	  POSICAO
			    	+	  ONE					
    				MM	GRAVA_DADO
    				MM	CS_DADO
    				MM	BL_SIZE
    				SC	CS_UPDATE	
    				SC	GRAVA_EXT
    				LD	BLOCO_CONT
    				+	  ONE
    				MM	BLOCO_CONT		; GRAVA O TAMANHO DO BLOCO PARA O CASO DO BLOCO MENOR QUE O PADRAO E SOMA NO CHECKSUM
;-----------------------------------

POSIC_MEMO	LD	BL_SIZE			; LOOP QUE GRAVA NA UL O CONTEUDO DAS POSICOES DO BLOCO
			    	-	  BLOCO_CONT
			    	+	  ONE
			    	JN	POSIC_CS
    				LD	POSICAO
    				+	  LOAD
    				MM	LOAD_END
LOAD_END		K	  /0000
    				MM	GRAVA_DADO
    				MM	CS_DADO
    				SC	GRAVA_EXT
    				SC	CS_UPDATE
    				LD	POSICAO
    				+	  TWO
    				MM	POSICAO
    				LD	BLOCO_CONT
    				+	  ONE
    				MM	BLOCO_CONT
    				LD	DUMPED_WORDS
    				+	  ONE
    				MM	DUMPED_WORDS
    				JP	POSIC_MEMO
				
;-----------------------------------

POSIC_CS		LD	CHECK_SUM		; GRAVA O CHECKSUM E RESETA 'BLOCO_CONT' E 'CHECK_SUM'
    				MM	GRAVA_DADO
    				SC	GRAVA_EXT
    				LD	ONE
    				MM	BLOCO_CONT
    				LD 	ZERO
    				MM 	CHECK_SUM
    				JP	LOOP
				
;-----------------------------------
LOOP_FIM		LD	DUMP_EXE		; GRAVA O 'DUMP_EXE' E RESETA 'BLOCO_CONT'
    				MM	GRAVA_DADO
    				SC	GRAVA_EXT
    				LD 	ONE
    				MM 	BLOCO_CONT
    				RS	DUMPER			; Retorna a sub-rotina

;============== ATUALIZA O CHECKSUM ===============
CS_UPDATE		K	  /0000		  	; ATUALIZA O VALOR DO CHECKSUM COM O VALOR DA VARIAVEL 'CS_DADO'
    				LD	CS_DADO
    				+	  CHECK_SUM
    				MM	CHECK_SUM
    				RS	CS_UPDATE

;============== GRAVA NA UNIDADE LOGICA ===========
GRAVA_EXT		K	  /0000			  ; IMPRIME EM UL O VALOR DA VARIAVEL 'GRAVA-DADO'
    				LD	DUMP_UL			; Carrega o parametro
    				+	  LOAD_GRAVA	; Monta a instrucao para carregar a UL correta
    				MM	GRAVAR			; Grava a instrucao recem montada no local correto
    				LD	GRAVA_DADO	; Carrega no acumulador o dado a ser gravado na UL
GRAVAR			K	  /0000			  ; GRAVA NO ARQUIVO
				    RS	GRAVA_EXT
				
#	DUMPER
