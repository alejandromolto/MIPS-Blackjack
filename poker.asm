
.data

## Variables


## TEXT MESSAGES

menu_mensaje : .asciiz "**BIENVENIDO A ASM-POKER** \n Trabajo hecho por alejandromolto. \n \n OPCIONES: \n \n (1) Jugar al poker. \n (2) Opciones. \n (3) Salida. \n \n Elige tu opción: "
.align 2
menu_message : .asciiz "**WELLCOME TO ASM-POKER** \n Work done by alejandromolto. \n \n OPTIONS: \n \n (1) Play poker. \n (2) Settings. \n (3) Exit. \n \n Choose your option: "
.align 2
opciones_mensaje: .asciiz "**SETTINGS MENU**\n\n(1) Change language\n(2) Exit\n"
.align 2
settings_message: .asciiz "**MENÚ DE CONFIGURACIÓN**\n\n(1) Cambiar idioma\n(2) Salir\n"
.align 2
lenguaje_memsaje: .asciiz "**MENÚ DE IDIOMA**\n\n(1) Español\n(2) Inglés \n(3) Salir"
.align 2
langauge_message: .asciiz "**LANGUAGE MENU**\n\n(1) Spanish\n(2) English \n(3) Exit\n"
.align 2
opcion_invalida: .asciiz  "Porfavor, elige una opción válida: "
.align 2
invalid_option: .asciiz "Please choose a valid option: "


## MAIN
.text
.globl main

## ATENTION. "s3" in this program will store the lenguage used and therefore it will not be changed unless the user indicates it in the menu (By default it will be english, 1). 
## This serves the purpose of avoiding excesive loading from the memory (due to loading the options if I storaged it in the data memory)

main:

li $s3, 1

mainmenu:
	
	addi $t0, $s3, -1
	bnez $t0, esp1
	
	la $a0, menu_message
	li $v0, 4
	syscall
	j ask_option
	
	esp1:
		la $a0, menu_mensaje
		li $v0, 4
		syscall
	
	ask_option: 

	li $v0, 5
	syscall

	li $t1, 1
	li $t2, 2
	li $t3, 3
	
	beq $v0, $t1, game 
	beq $v0, $t2, language_menu
	beq $v0, $t3, exit 

	la $a0 invalid_option
	li $v0, 4
	syscall
	j ask_option	

game:

language_menu:

	




exit:
	li $v0, 10
	syscall