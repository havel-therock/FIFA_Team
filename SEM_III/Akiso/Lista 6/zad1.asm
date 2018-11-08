                opt f-g-h+l+o+
                org $1000

start           equ *
                ldy #6 		;laduje index y z pamieci
		lda #%10101001  ;liczba bedaca konwertowana, laduje do akumulatora
                jsr phex 	;preskakuje do phex
                lda <text
                ldx >text
                jsr $ff80
                brk

phex		pha 		;odkłada na stos zawartosc akumulatora
		jsr pxdig 	;preskakuje do pxdig
		pla		;zdejmuje wartosc ze stosu i umieszcza ja w akumulatorze
		lsr @  		;przesunięcia bitowe w prawo
		lsr @
		lsr @
		lsr @
pxdig		and #%00001111  ;wyzerowanie bitów oprócz ostatnich 4
		ora #'0'    	;OR z zerem 
		cmp #'9'+1  	;porownuje akumulator z pamiecia
		bcc pr		;przeskakuje na pr
		adc #'A'-'9'-2 	;dodaje pamiec do akumulatora
pr		sta text,y	;zapisuje akumulator w pamieci
		dey		;zmniejsza index y o jeden
		rts		;powrot z podprogramu

                org $2000
text            equ *
		dta b(8),b(8),b(8),b(8)
		dta b(8),b(8),b(8),b(8)
                dta b(10) ; '\n'
                dta b(0)
                org $2E0
                dta a(start)

                end of file
