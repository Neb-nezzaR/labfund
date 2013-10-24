DUMPER 		>
DUMP_INI 	>
DUMP_TAM 	>
DUMP_UL 	>
DUMP_BL 		>
DUMP_EXE 	>

					&	/0000

;========= PARAMETROS ===============

DUMP_INI 	K		/0000		; inicia com 0
DUMP_TAM 	K		/0000		; inicia com 0
DUMP_UL 	K		/0000		; inicia com 0
DUMP_BL 		K		/0000		; inicia com 0
DUMP_EXE 	K		/0000		; inicia com 0

;========= CONSTANTES ===============

POS_FIM		K		/0FFF		; Tamanho da memoria
TWO				K		/2				; Constante 'Dois'
POSICAO		K		/000			; Posicao atual da memoria
LOAD			K		/8000
GRAVA			K		/E300

;========= INICIO DA SUB-ROTINA =========

DUMPER 		K		/000				; inicia com 0
					LD	DUMP_UL		; Monta a instrucao para carregar a UL correta
					+		GRAVA
					MM	OUTPUT
					LD	DUMP_INI		; Grava DUMP_INI
					MM	POSICAO
					LD	DUMP_TAM
					*		TWO
					+		DUMP_INI
					MM	POS_FIM
LOOP			LD	POSICAO	
					-		POS_FIM	
					JN	EXEC0
					JP	FINAL
EXEC0			LD	POSICAO
					+		LOAD
					MM	EXEC1
EXEC1			K		/0000	
OUTPUT		K		/0000
					LD	POSICAO
					+		TWO
					MM	POSICAO
					JP	LOOP
FINAL			RS	DUMPER
#	DUMPER
