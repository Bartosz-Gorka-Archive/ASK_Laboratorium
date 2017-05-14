; Architektura Systemów Komputerowych
; Laboratorium nr 
; Temat: Obsługa wyświetlacza LCD
; Autor: Bartosz Górka [INF127228] - 14.05.2017r.

; Dyrektywa "pracy"
$MOD842

; Przypisania etykiet dla wygodniejszej pracy z urządzeniem - sposób połączenia LCD z układem sterowania (mikrokontrolerem)
; Dane
	LCD_D4  EQU P2.1
	LCD_D5  EQU P2.0
	LCD_D6  EQU P2.3
	LCD_D7  EQU P2.2

; Sterowanie
	LCD_E   EQU P2.5
	LCD_RW  EQU P2.4
	LCD_RS  EQU P2.7

; Cały port by było łatwiej edytować
	LCD_PORT EQU P2

; Początek danych w pamięci
	LCD_DATA EQU 30h


ORG 000h
JMP INIT_SYSTEM

; Inicjalizacja pamięci układu
INIT_SYSTEM:
	; Załadowanie do pamięci układu liter
	; Linia pierwsza
	MOV 030H, #'B'
	MOV 031H, #'A'
	MOV 032H, #'R'
	MOV 033H, #'T'
	MOV 034H, #'O'
	MOV 035H, #'S'
	MOV 036H, #'Z'
	MOV 037H, #0 ; Znacznik końca danych

	; Linia druga
	MOV 040H, #'G'
	MOV 041H, #'O'
	MOV 042H, #'R'
	MOV 043H, #'K'
	MOV 044H, #'A'
	MOV 045H, #0 ; Koniec danych

; Włączenie wyświetlacza, włączenie kursora, włączenie migania
LCD_SET_ON:
	CLR LCD_RS
	CLR LCD_RW

	; 1 CZĘŚĆ DANYCH
		CLR LCD_D7
		CLR LCD_D6
		CLR LCD_D5
		CLR LCD_D4

	; ZATWIERDZENIE DANYCH
		SETB LCD_E
		CLR LCD_E

	; 2 CZĘŚĆ DANYCH
		SETB LCD_D7
		SETB LCD_D6
		SETB LCD_D5
		SETB LCD_D4

	; ZATWIEDZENIE DANYCH
		SETB LCD_E
		CLR LCD_E
	RET	

; Wyłączenie wyświetlacza
LCD_SET_OFF:
	; 1 CZĘŚĆ DANYCH + RS NA 0, RW NA 0
		CLR LCD_PORT

	; ZATWIERDZENIE DANYCH
		SETB LCD_E
		CLR LCD_E

	; 2 CZĘŚĆ DANYCH
		CLR LCD_PORT

	; ZATWIEDZENIE DANYCH
		SETB LCD_E
		CLR LCD_E
	RET

; Zmiana trybu pracy na 4-bitowy
LCD_FOUR_BITS:
	; TRYB
		CLR LED_RS
		CLR LED_RW

	; 1 CZĘŚĆ DANYCH
		CLR LED_D7
		CLR LED_D6
		SETB LED_D5
		CLR LED_D4

	; POTWIERDZENIE WPISU
		SETB LED_E
		CLR LED_E

	; 2 CZĘŚĆ DANYCH
		SETB LED_D7 ; N = 1 -> 2 LINIE
		SETB LED_D6 ; F = 1 -> 5 x 10 FORMAT ZNAKÓW

	; POTWIERDZENIE
		SETB LED_E
		CLR LED_E
	RET

DELAY:
	MOV R7, #0FFH
	DEL2:	
	MOV R6, #01BH
	DJNZ R6, $
	DJNZ R7, DEL2
	RET

END