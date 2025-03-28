
.data

## Variables


## TEXT MESSAGES

shownCards: .space 36  ## Array that stores the cards that already have been shonw
.align 2

player1_name: .space  48
player2_name: .space 48

menu_mensaje : .asciiz "\n\n**BIENVENIDO A ASM-POKER** \n Trabajo hecho por alejandromolto. \n \n OPCIONES: \n \n (1) Jugar al poker. \n (2) Opciones. \n (3) Salida. \n \nElige tu opción: "
menu_message : .asciiz "\n\n**WELLCOME TO ASM-POKER** \n Work done by alejandromolto. \n \n OPTIONS: \n \n (1) Play poker. \n (2) Settings. \n (3) Exit. \n \n Choose your option: "
opciones_mensaje: .asciiz "\n\n**SETTINGS MENU**\n\n(1) Change language\n(2) Exit\n \nElige tu opción:"
settings_message: .asciiz "\n\n**MENÚ DE CONFIGURACIÓN**\n\n(1) Cambiar idioma\n(2) Salir\n\nChoose your option: "
lenguaje_mensaje: .asciiz "\n\n**MENÚ DE IDIOMA**\n\n(1) Inglés\n(2) Español \n(3) Salir\n\nElige tu opción:"
language_message: .asciiz "\n\n**LANGUAGE MENU**\n\n(1) English\n(2) Spanish \n(3) Exit\n\nChoose your option: "
opcion_invalida: .asciiz  "\nPorfavor, elige una opción válida: "
invalid_option: .asciiz "\nPlease choose a valid option: "
game_starting: .asciiz "\nThe match is going to start. The dealer is handling the cards..."
empezando_juego: .asciiz "\nLa partida va a comenzar. El croupier está barajando las cartas..."
dialogue: .asciiz ">"
yougot: .asciiz "\nYou have got the "
ofclubs: .asciiz " of clubs"
ofhearts: .asciiz " of hearts"
ofdiamonds: .asciiz " of diamonds"
ofspades: .asciiz " of spades"
depicas: .asciiz " de picas"
decorazones: .asciiz " de corazones"
dediamantes: .asciiz " de diamantes"
deespadas: .asciiz " de espadas"




## VALUES



## MAIN
.text
.globl main

## ATENTION. "s0" in this program will store the lenguage used and therefore it will not be changed unless the user indicates it in the menu (By default it will be english, 1). 
## This serves the purpose of avoiding excesive loading from the memory (due to loading the options if I storaged it in the data memory)

main:

li $s0, 1

mainmenu:
	
	## If language = 1, then the message displays in english. Any other value for s0 displays the message in espanish (esp1).
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

	la $a0, invalid_option
	li $v0, 4
	syscall
	j ask_option	


language_menu:

	## If language = 1, then the message displays in english. Any other value for $s0 displays the message in espanish (esp2).
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

	## If language = 1, then the message displays in english. Any other value for s0 displays the message in espanish (esp1).
	addi $t0, $s0, -1
	bnez $t0, esp3
	
	la $a0, game_starting
	li $v0, 4
	syscall
	j start_game
	
	esp3:
		la $a0, empezando_juego
		li $v0, 4
		syscall

	start_game:
	
	jal GenerateCards
	jal StoreCardsInRegisters
	
	## Poker cards must be confidential so, firstly it shows the player one	its cards and then it does the same with player two.
	## Player one cards (stored in $s1, $s2)
	
	move $a0, $s1	
	jal TranslateCard
	move $a0, $s2
	jal TranslateCard	


exit:
	li $v0, 10
	syscall





## SUBRUTINES


TranslateCard: # This function receives a card into $a0 and prints out the card

move $a1, $a0

la $a0, yougot		# "You got" message
li $v0, 4
syscall


# Card print

li $t2, 11
li $t3, 12
li $t4, 13
li $t5, 14

andi $t1, $a1, 0x0000FFFF

beq $t1, $t2, J
beq $t1, $t3, Q
beq $t1, $t4, K
beq $t1, $t5, A

move $a0, $t1
li $v0, 1
syscall
j printsuit

J:
li $a0, 'J'
li $v0, 11
syscall
j printsuit

Q:
li $a0, 'Q'
li $v0, 11
syscall
j printsuit

K:
li $a0, 'K'
li $v0, 11
syscall
j printsuit

A:
li $a0, 'A'
li $v0, 11
syscall
j printsuit

## Suit print
printsuit:
li $t2, 1
li $t3, 2
li $t4, 3
li $t5, 4

srl $t1, $a1, 16

beq $t1, $t2, clubs
beq $t1, $t3, diamonds
beq $t1, $t4, hearts
beq $t1, $t5, spades

clubs:
la $a0, ofclubs
li $v0, 4
syscall
jr $ra

diamonds:
la $a0, ofdiamonds
li $v0, 4
syscall
jr $ra

hearts:
la $a0, ofhearts
li $v0, 4
syscall
jr $ra

spades:
la $a0, ofspades
li $v0, 4
syscall
jr $ra



StoreCardsInRegisters: # This function stores card in registers. 

la $t5, shownCards 

lw $s1, 0($t5)
lw $s2, 4($t5)
lw $s3, 8($t5)
lw $s4, 12($t5)
lw $s5, 16($t5)
lw $s6, 20($t5)
lw $s7, 24($t5)
lw $t8, 28($t5)
lw $t9, 32($t5)

jr $ra


GenerateCards: # This function generates all the cards and stores them in the array

la $t5, shownCards 
li $t6, 0		# Counter
li $t7, 9		# Limit (maximum of iterations)

loop1:
	j GenerateCard
	SingleCardGenerated:
		move $t1, $v0
		sw $t1, 0($t5)
		beq $t6, $t7, back_to_main
		addi $t6, $t6, 1
		addi $t5, $t5, 4
		j loop1

back_to_main:
	jr $ra



GenerateCard: # This function returns a card to $v0

li $v0, 30
syscall
li $a1, 13
li $v0, 42	
syscall        	 	# This syscall generates a random number between 0 and 12 inclusive
addi $t1, $a0, 2	# Now the function adds 2 (so the range is between 2-14) and it passes the value to the temporal register $t1.

li $a0, 0	
li $a1, 4
li $v0, 42
syscall        	 	# This syscall generates a random number between 0 and 3
addi $t2, $a0, 1	# Now the function adds 1 (so the range is between 1-3) and it passes the value to the temporal register $t2.

sll $t2, $t2, 16
add $a0, $t2, $t1	# Now in $a0 there is a card stored. The first halfword represents the suit and the second the number of the card.
move $v0, $a0
j IsTheCardShown

	PostCheckGenerateCard:

	bnez $v1, GenerateCard	#If the card is already in the vector it generates another. If the card is not already in the vector it goes back to the function generatecards.
	j SingleCardGenerated


IsTheCardShown: # This function receives a card in the paramater $a0 and returns to $v1 a 1 if it is has already been shown and a 0 if it hasnt been shown.

li $v1, 0		# The default value is not shown
li $t4, 8		# Number of times the loop has to be repeated (it only has to check for 8 elements as there is no need to check after the nineth card is added)
li $t0, 0 		# Counter
la $t1, shownCards	# Adress of the array

	loop2:
	lw $t2, 0($t1)				# Gets the value of the cards individually.
	beq $t2, $a0, set_as_shown		# If the card has been shown it sets it as found and goes back to the main function.
	beq $t0, $t4, back_to_generate_card	# If the counter arrives to the maximum number of iterations it goes back the main.
	addi $t1, $t1, 4			# The adress gets 4 bits added, moving on to the next card
	addi $t0, $t0, 1			# The normal counter + 1
	j loop2
	
	set_as_shown:
		li $v1, 1
	
	back_to_generate_card:
		j PostCheckGenerateCard


SetCardsShownToZero: # This function sets all the values of the array to 0.

li $v1, 0		# The default value is not shown
li $t4, 9		# Number of times the loop has to be repeated
li $t0, 0 		# Counter
la $t1, shownCards	# Adress of the array

	loop3:
	sw $zero, 0($t1)		# Erases the value of the cards individually.
	beq $t0, $t4, back_to_main2	# If the counter arrives to the maximum number of iterations it goes back the main.
	addi $t1, $t1, 4		# The adress gets 4 bits added, moving on to the next card
	addi $t0, $t0, 1		# The normal counter + 1
	j loop3

	back_to_main2:
		jr $ra

# TO DO:
# 1. Design a "Press enter to continue" function so it can be implemented every time a wait is involved.
# 2. Add the cards for the second player (with the wait implemented and having somehow having erased the cards of the previous player in the screen)
