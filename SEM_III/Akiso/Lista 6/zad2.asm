		opt f-g-h+l+o+
                org $1000

start           equ *

                lda #%10101001       	;liczba która chcemy wypisac
                sta byte        	;zapisujemy ją w byte
                
                lda #0       		;czyscimy akumulator
                ldx #8          	;ustawiamy operator petli na 8 (ilosc bitów podanej liczby)
                sed             	;wlaczamy tryb dziesietny, ustawia flage
bcd             asl byte        	;przesuniecie bitowe byte w lewo(mnożenie przez 2)
                lda word        	;wlozenie word do akumulatora
                adc word        	;dodanie word do akumulatora (z carry)
                sta word		;przezucenie akumulatora do word
                rol word+1		;przesuniecie bitowe (i dodanie carry) word + 1
                dex			;zmniejszenie indeksu x o jeden
                bne bcd         	;jesli X > 0 skocz do bcd

                cld			;czysci tryb dziesietny
                
                lda word+1          	;wypisanie drugiej cyfry starszego bajtu
		jsr print		;przechodzi do print

                lda word            	;wypisanie pierwszej cyfry mlodszego bajtu
                lsr @			;przesunięcia bitowe w prawo
                lsr @
                lsr @
                lsr @
                jsr print

                lda word            	;wypisanie drugiej cyfry mlodszego bajtu
                jsr print

                brk

print           and #$f
                ora #'0'
                sta text		;zapisuje akumulator w pamieci
                lda <text
                ldx >text
                jsr $ff80
                rts

		org $2000
				
text            equ *
		dta b(0)

byte            dta b(0)

word            dta b(0)
		dta b(0)

                org $2E0
                dta a(start)

                end of file
