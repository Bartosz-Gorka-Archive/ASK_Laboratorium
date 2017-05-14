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

; Włączenie wyświetlacza
LCD_SET_ON:
	

; Wyłączenie wyświetlacza
LCD_SET_OFF:


; Zmiana trybu pracy na 4-bitowy
LCD_FOUR_BITS:


