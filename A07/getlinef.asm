; GETLINEF

GETLINEF	>
GL_END 		>
GL_UL 		>
GL_BUF 		>

&	/0000

;VARs
GL_UL		K	/0000 	; UL do arquivo
GL_BUF		K	/0000 	; Tamanho do Buffer
GL_END 		K	/0000 	; Endereço do Buffer
AUX			K	/0000	; Variavel Auxiliar

;CONSTs
TWO			K	/0002 	; Constante dois
EOL			K	/0d0a 	; Constante EOL
EOF			K	/100a	; Contante EOF
ZERO		K	/0000 	; Constante zero
ONE			K	/0001	; Constante um
FREAD		K	/d300	; Monta instrução 'ler do disco'

;FUNC
GETLINEF	$	/1 	; Endereço de retorno
START		LD	GL_BUF	;
			-	ZERO 	;	
			JZ	RETURN	;
			LD	GL_UL	; Carrega a UL do arquivo no acumulador
			+	FREAD	; Monta a instrucao de escrever 
			MM	READ
READ		K	/0000	; Executa a leitura do arquivo
			MM	AUX 	; Grava o conteudo do arquivo em AUX
			-	EOL		;
			JZ	START	;
			LD	AUX 	;
			-	EOF		;
			JZ	RETEOF	;
			LD	AUX 	;
			MM	GL_END	;
			LD 	GL_END	;
			+	TWO		;
			MM	GL_END	;
			LD	GL_BUF	;
			-	ONE		;
			MM	GL_BUF	;
			JP	START	;
RETEOF		LD	ONE		;
RETURN		RS	GETLINEF

#	GETLINEF
			