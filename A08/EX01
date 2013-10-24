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

MEM_TAM		K		/0FFF		; Tamanho da memoria
TWO				K		/2				; Constante 'Dois'
POSICAO		K		/000			; Posicao atual da memoria
LOAD			K		/8000

;========= INICIO DA SUB-ROTINA =========

DUMPER 		K		/000				; inicia com 0
LOOP			LD	POSICAO	
					-		MEM_TAM	
					JN	EXEC0
					JP	FINAL
EXEC0			LD	POSICAO
					+		LOAD
					MM	EXEC1
EXEC1			K		/0000					
					PD	/300
					LD	POSICAO
					+		TWO
					MM	POSICAO
					JP	LOOP
FINAL			RS	DUMPER
#	DUMPER
