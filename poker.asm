
.data

## Variables


## TEXT MESSAGES

menu_mensaje : .asciiz "\n\n**BIENVENIDO A ASM-POKER** \n Trabajo hecho por alejandromolto. \n \n OPCIONES: \n \n (1) Jugar al poker. \n (2) Opciones. \n (3) Salida. \n \nElige tu opción: "
menu_message : .asciiz "\n\n**WELLCOME TO ASM-POKER** \n Work done by alejandromolto. \n \n OPTIONS: \n \n (1) Play poker. \n (2) Settings. \n (3) Exit. \n \n Choose your option: "
opciones_mensaje: .asciiz "\n\n**SETTINGS MENU**\n\n(1) Change language\n(2) Exit\n \nElige tu opción:"
settings_message: .asciiz "\n\n**MENÚ DE CONFIGURACIÓN**\n\n(1) Cambiar idioma\n(2) Salir\n\nChoose your option: "
lenguaje_mensaje: .asciiz "\n\n**MENÚ DE IDIOMA**\n\n(1) Inglés\n(2) Español \n(3) Salir\n\nElige tu opción:"
language_message: .asciiz "\n\n**LANGUAGE MENU**\n\n(1) English\n(2) Spanish \n(3) Exit\n\nChoose your option: "
opcion_invalida: .asciiz  "\nPorfavor, elige una opción válida: "
invalid_option: .asciiz "\nPlease choose a valid option: "
game_starting: .asciiz "The match is going to start."
empezando_juego: .asciiz "La partida va a comenzar. El croupier está barajando las cartas..."


## VALUES
.align 2
shownCards: .space 24  ## Array that stores the cards that already have been shonw


## MAIN
.text
.globl main

## ATENTION. "s3" in this program will store the lenguage used and therefore it will not be changed unless the user indicates it in the menu (By default it will be english, 1). 
## This serves the purpose of avoiding excesive loading from the memory (due to loading the options if I storaged it in the data memory)

main:

li $s0, 1

mainmenu:
	
	## If language = 1, then the message displays in english. Any other value for s3 displays the message in espanish (esp1).
	addi $t0, $s0, -1
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


language_menu:

	## If language = 1, then the message displays in english. Any other value for s3 displays the message in espanish (esp2).
	addi $t0, $s0, -1
	bnez $t0, esp2
	
	la $a0, language_message
	li $v0, 4
	syscall
	j ask_language
	
	esp2:
		la $a0, lenguaje_mensaje
		li $v0, 4
		syscall
	
	ask_language: 

	li $v0, 5
	syscall

	li $t1, 1
	li $t2, 2
	li $t3, 3
	
	beq $v0, $t1, set_english
	beq $v0, $t2, set_spanish
	beq $v0, $t3, mainmenu 

	la $a0 invalid_option
	li $v0, 4
	syscall
	j ask_language	

	set_english:
		li $s0, 1
		j mainmenu
		
	set_spanish:
		li $s0, 2
		j mainmenu


game:

	


exit:
	li $v0, 10
	syscall


## SUBRUTINES

IsTheCardShown: ## This function receives a card in the paramater $a0 and returns to $v1 a 1 if it is has already been shown and a 0 if it hasnt been shown.

li $v1, 0		# The default value is not shown
li $t4, 6		# Number of times the loop has to be repeated
li $t0, 0 		# Counter
la $t1, shownCards	# Adress of the array

	loop1:
	lw $t2, 0($t1)			# Gets the value of the cards individually.
	beq $t2, $a0, set_as_shown	# If the card has been shown it sets it as found and goes back to the main function.
	beq $t0, $t4, back_to_main	# If the counter arrives to the maximum number of iterations it goes back the main.
	addi $t1, $t1, 4		# The adress gets 4 bits added, moving on to the next card
	addi $t0, $t0, 1		# The normal counter + 1
	j loop1
	
	set_as_shown:
		li $v1, 1
	
	back_to_main:
		jr $ra


SetCardsShownToZero: ## This function sets all the values of the array to 0.

li $v1, 0		# The default value is not shown
li $t4, 6		# Number of times the loop has to be repeated
li $t0, 0 		# Counter
la $t1, shownCards	# Adress of the array

	loop2:
	sw $zero, 0($t1)		# Erases the value of the cards individually.
	beq $t0, $t4, back_to_main2	# If the counter arrives to the maximum number of iterations it goes back the main.
	addi $t1, $t1, 4		# The adress gets 4 bits added, moving on to the next card
	addi $t0, $t0, 1		# The normal counter + 1
	j loop2

	back_to_main2:
		jr $ra


