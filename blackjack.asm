
.data

## Variables


## TEXT MESSAGES

Cards: .space 88  ## Array that stores the cards
.align 2
rastorage: .space 4

player1_name: .space  48

menu_mensaje : .asciiz "\n\n**BIENVENIDO A ASM-BLACKJACK** \n Trabajo hecho por alejandromolto. \n \n OPCIONES: \n \n (1) Jugar al blackjack. \n (2) Opciones. \n (3) Salida. \n \nElige tu opción: "
menu_message : .asciiz "\n\n**WELLCOME TO ASM-BLACKJACK** \n Work done by alejandromolto. \n \n OPTIONS: \n \n (1) Play blackjack. \n (2) Settings. \n (3) Exit. \n \n Choose your option: "
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
tienesel: .asciiz "\Has obtenido el "
dealerhas: .asciiz "\n\nThe dealer shows a "
eldealertiene: .asciiz "\nEl croupier muestra un "
theothercard: .asciiz "\nThe other card is upside down."
laotracarta: .asciiz "\nLa otra carta se encuentra boca abajo."
pressEnter: .asciiz "\nPress enter to continue.\n"
presionaEnter: .asciiz "\nPresiona enter para continuar.\n"
ofclubs: .asciiz " of clubs"
ofhearts: .asciiz " of hearts"
ofdiamonds: .asciiz " of diamonds\n"
ofspades: .asciiz " of spades"
depicas: .asciiz " de picas\n"
decorazones: .asciiz " de corazones\n"
dediamantes: .asciiz " de diamantes\n"
deespadas: .asciiz " de espadas\n"
sumcards: .asciiz "\nThe sum of your cards is currently "
sumadecartas: .asciiz "\nLa suma de tus cartas es actualmente: "
gameoptions: .asciiz "\n\nOPTIONS: \n \n (1) Hit. \n (2) Stay. \n (3) Double. \n \n Choose your option: "
opcionesjuego: .asciiz "\n\nOPTIONS: \n \n (1) Pedir. \n (2) Plantarse. \n (3) Doblar. \n \n Elige tu opción: "
youlost: .asciiz "\n**YOU LOST**\nBetter luck next time!\n"
hasperdido: .asciiz "\n**HAS PERDIDO**\nSuerte la próxima vez!\n"
sumcardsdealer: .asciiz "\nThe sum of the dealer's cards is currently "
sumacartasdealer: .asciiz "\nLa suma de las cartas del dealer es actualmente  "
dealerbusted: .asciiz "\nThe dealer has busted!\nYou won!\n"
drawmessage: .asciiz "\nThere has been a draw!\n"
empatemensaje: .asciiz "\nHa habido un empate\n"
userwinsmessage: .asciiz "\n**YOU WON**\n"
usuarioganamensaje: .asciiz "\n**GANASTE**\n"
askforbetmessage: .asciiz "\n\HOW MUCH DO YOU WANT TO BET?\nWrite the amount: "
cuantoapuestasmensaje: .asciiz "\n\CUANTO QUIERES APOSTAR?\nEscribe la cantidad:  "
wrongbet: .asciiz "\nYou cannot bet more than the amount of money that you have\n"
apuestaequivocada: .asciiz "\nNo puedes apostar más que la cantidad de dinero que tienes.\n"
balancemessage: .asciiz "\nYour current balance is: \n"
balancemensaje: .asciiz "\nTu balance actual: \n"
anotherhandmessage: .asciiz "\n\**DO YOU WANT TO PLAY ANOTHER HAND?** \n \n (1) Yes. \n (2) No (Exit). \n\nChoose your option: "
otramanomensaje: .asciiz "\n\**QUIERES JUGAR OTRA MANO?** \n \n (1) Sí. \n (2) No (Salir). \n\nElige tu opción: "

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
	
	la $a0, menu_message
	la $a1, menu_mensaje
	jal Translator
	
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
	la $a1, opcion_invalida
	jal Translator	
	j ask_option	






language_menu:

	## If language = 1, then the message displays in english. Any other value for $s0 displays the message in espanish (esp2).
	addi $t0, $s0, -1
	
	la $a0, language_message
	la $a1, lenguaje_mensaje
	jal Translator
	
	ask_language: 

	li $v0, 5
	syscall

	li $t1, 1
	li $t2, 2
	li $t3, 3
	
	beq $v0, $t1, set_english
	beq $v0, $t2, set_spanish
	beq $v0, $t3, mainmenu 
	
	la $a0, invalid_option
	la $a1, opcion_invalida
	jal Translator	
	
	j ask_language	

	set_english:
		li $s0, 1
		j mainmenu
		
	set_spanish:
		li $s0, 2
		j mainmenu


game:

# MONEY; $f20 will be the general money of the player, while $f21 will be the money that its being played in that moment.

li $t0, 10
mtc1 $t0, $f20		# The players money starts being 10
cvt.s.w $f20, $f20  	# The money being played will be by default 0

gamepostmoneyinitialization:
askforbet:


sub.s $f21, $f21, $f21  	# The money being played will be by default 0
	
la $a0, askforbetmessage
la $a1, cuantoapuestasmensaje
jal Translator	
	
li $v0, 6
syscall

mov.s $f21, $f0

c.lt.s $f21, $f20
bc1t betright

mtc1 $zero, $f16
c.lt.s $f16, $f21
bc1t betright

la $a0, wrongbet
li $v0, 4
syscall


betright:

sub.s $f20, $f20, $f21

# VARIABLES PRESERVED ACROSS PROCEDURE CALLS
li $s6, 0	# Number of cards of the user
li $s7, 0	# Number of cards of the croupier
	
	## If language = 1, then the message displays in english. Any other value for s0 displays the message in espanish (esp1).
	addi $t0, $s0, -1

	la $a0, game_starting
	la $a1, empezando_juego
	jal Translator
	
	
	start_game:
	
	jal ContinueOption
	
	jal GenerateCards
	la $t5, Cards 

	# REGISTERS! (CHECK HERE REGISTER CONVENTION)
	
	# (Remember $s0 is the lenguage register)
	
	lw $s1, 0($t5)	# card of the player (it can be any card) ($s1)
	lw $s2, 4($t5)	# card of the player (it can be any card) ($s2)
	
	li $s6, 2	# number of cards of the player ($s6)
	
	lw $s4, 44($t5)	# card of the dealer (it can be any card) ($s4)
	lw $s5, 48($t5)	# card of the dealer (it can be any card) ($s5)
	
	li $s7, 2	# number of cards of the dealer ($s7)
	
	# Player one cards (stored in $s1, $s2)
	
	la $a0, yougot	# "You got" message
	la $a1, tienesel
	jal Translator
	
	move $a0, $s1	
	jal TranslateCard
	
	la $a0, yougot	# "You got" message
	la $a1, tienesel
	jal Translator
	
	move $a0, $s2
	jal TranslateCard	
	
	# Sum of the cards
	
	la $a0, sumcards		
	la $a1, sumadecartas
	jal Translator	
	
	la $a0, Cards
	move $a1, $s6
	jal CalculateSum
	move $a0, $v0
	li $v0, 1
	syscall
		
	beqz $v1, dealercards
	
	li $a0, '/'
	li $v0, 11
	syscall
	
	move $a0, $v1
	li $v0, 1
	syscall

	li $a0, 10
	li $v0, 11
	syscall

		
	dealercards:
	
	jal ContinueOption
	## Dealer card (stored in $s4)
		
	li $a0, 10
	li $v0, 11
	syscall

	la $a0, dealerhas	# "Dealer has" message
	la $a1, menu_mensaje
	jal Translator

	move $a0, $s4
	jal TranslateCard

	la $a0, theothercard	# "The other card" message
	la $a1, laotracarta
	jal Translator

li $s3, 0	# iteration variable
li $a3, 2

gameloop:
	
	# Options
	jal GameOptionsMenu
	beq $v0, 1, hit
	beq $v0, 2, stay
	beq $v0, 3, double

	
	double:
		sub.s $f20, $f20, $f21	
		add.s $f21, $f21, $f21	# Multiply the value in play by two.
	hit:
		la $t2, Cards
		addi $t2, $t2, 8
		add $t2, $t2 ,$s3
		lw $t1, 0($t2)
		addi $s3, $s3, 4	# number of iteration multiplied by 4
	
		la $a0, yougot	# "You got" message
		la $a1, tienesel
		jal Translator
	
		move $a0, $t1
		jal TranslateCard
		li $t3, 2
		div $t4, $s3, 4
		add $t3, $t3, $t4


	# Sum of the cards
		
		la $a0, sumcards		
		la $a1, sumadecartas
		jal Translator	
		
		la $a0, Cards
		move $a1, $t3
		move $s3, $t3
		jal CalculateSum
		
		
		move $t1, $v0
		
		move $a0, $v0
		li $v0, 1
		syscall
		
		bgt $t1, 21, housewins
				
		beqz $v1, gameloop
	
		li $a0, '/'
		li $v0, 11
		syscall
	
		move $a0, $v1
		li $v0, 1
		syscall

		li $a0, 10
		li $v0, 11
		syscall
		
		addi $a3, $a3, 1
	
	j gameloop
	
	
	stay:
		# Second card print
		
		la $a0, dealerhas	# "Dealer has" message
		la $a1, menu_mensaje
		jal Translator
		
		la $a0, Cards
		addi $a0, $a0, 48
		lw $a0, 0($a0)
		jal TranslateCard
		
		la $a0, sumcardsdealer		# Dealer sum message
		la $a1, sumacartasdealer
		jal Translator
		
		la $a0, Cards
		addi $a0, $a0, 44
		li $a1, 2
		jal CalculateSum
		
		move $a0, $v0
		li $v0, 1
		syscall
		
		beqz $v1, dealerloop
	
		li $a0, '/'
		li $v0, 11
		syscall
	
		move $a0, $v1
		li $v0, 1
		syscall

		li $a0, 10
		li $v0, 11
		syscall
		
		
								
		dealerloop:
			
		jal ContinueOption
			
			la $a0, Cards
			addi $a0, $a0 ,44	# Function parameter: adress of the dealer cards
			move $a1, $s7		# Function parameter: dealer cards
			jal CalculateSum	# Calculate sum
			
			bnez $v1, hasAce 
			
			blt $v0, 17, DealerHit
			bgt $v0, 21, DealerBust
		
			j DealerStand
		
			hasAce:
				blt $v1, 17, DealerHit
				bgt $v1, 21, DealerBust
				j DealerStand
		
			DealerHit:
				addi $s7, $s7, 1
			
				la $a0, dealerhas	# "Dealer has" message
				la $a1, menu_mensaje
				jal Translator
				
				la $a0, Cards
				addi $a0, $a0, 44
				addi $t1, $s7, -1
				sll $t1, $t1, 2
				add $a0, $t1, $a0
				lw $a0, 0($a0)
				jal TranslateCard
				
				la $a0, sumcardsdealer		# Dealer sum message
				la $a1, sumacartasdealer
				jal Translator
		
				la $a0, Cards
				addi $a0, $a0, 44
				move $a1, $s7
				jal CalculateSum
		
				move $a0, $v0
				li $v0, 1
				syscall
				
				j dealerloop
	
			DealerBust:
				j userwins
				
			DealerStand:
				j CompareDealerAndUser
	
	
	j endhand
	
	CompareDealerAndUser:	# Dealer number of cards is in $s7 and user's number of cards is in $s3
	la $a0, Cards	
	move $a1, $a3	
	jal CalculateSum	
	move $s3, $v0		# Now, the sum of the cards of the user will be stored in $s3
	beqz $v1, usernoace
	move $s3, $v1
	
	usernoace:

	la $a0, Cards
	addi $a0, $a0 ,44	
	move $a1, $s7		
	jal CalculateSum	
	move $s7, $v0		# Now, the sum of the cards of the dealer will be stored in $s7
	beqz $v1, dealernoace 
	move $s7, $v1
	
	dealernoace:

	
	bgt $s3, $s7, userwins	
	beq $s3, $s7, draw
	blt $s3, $s7, housewins	
	
	userwins:

	la $a0, userwinsmessage		# YOU LOST
	la $a1, usuarioganamensaje
	jal Translator	
				
	add.s $f21, $f21, $f21
	add.s $f20, $f20, $f21
	j endhand
	
	draw:
	
	la $a0, drawmessage		# YOU DRAW
	la $a1, empatemensaje
	jal Translator	
	
	add.s $f20, $f20, $f21
	j endhand
		
	housewins:
	la $a0, youlost		# HOUSE WINS
	la $a1, hasperdido
	jal Translator	
	j endhand

endhand:
	la $a0, balancemessage		# HOUSE WINS
	la $a1, balancemensaje
	jal Translator	
	
	#balancemensaje
	
	mov.s $f12, $f20
	li $v0, 2
	syscall

	la $a0, anotherhandmessage		# HOUSE WINS
	la $a1, otramanomensaje
	jal Translator	
		
	li $v0, 5
	syscall
	
	beq $v0, 1, anotherhand
	beq $v0, 2, exit
	
anotherhand:
j gamepostmoneyinitialization

exit:
	li $v0, 10
	syscall



## SUBRUTINES

Translator: # This function receives to $a0 the adress of the message in english and $a1 the adress of the message in spanish (and $s0 stores the lenguage)


bne $s0, 1, spanishmessage

li $v0, 4
syscall
jr $ra

spanishmessage:
move $a0, $a1
li $v0, 4
syscall
jr $ra



GameOptionsMenu: # This function returns a option (hit(1), stay(2), double(3)) to $v0
la $a0, gameoptions
li $v0, 4
syscall

	askforvalidgameoption:
		li $v0, 5
		syscall
		
		beq $v0, 1, returnoption
		beq $v0, 2, returnoption	
		beq $v0, 3, returnoption	
		
		addi $t0, $ra, 12
		sw $t0, rastorage
		la $a0, invalid_option		# Opcion invalida
		la $a1, opcion_invalida
		jal Translator
		lw $ra, rastorage
		j askforvalidgameoption
		
returnoption:
jr $ra





CalculateSum:	
# This function gets the parameters; $a1 which indicates the length of the cards of the array that the player/dealer actually has.
# $a0, which indicates the adress of the vector(it can be the adress of the player or the adress of the dealer)
# The function returns to v0 (and v1 if there are two possible values) the total value of the cards. If there is only one possible value $v1 will be set to zero.

li $t0, 0	# counter
move $t1, $a0 	# adress of the array (iterative, can and will vary)
move $t2, $a1 	# number of iterations
li $t3, 0	# number of aces
li $t4, 0	# current card
li $t6, 0	# temporal value for branch
li $t8, 0	# temporal value for comparing
li $t7, 0	# TOTAL VALUE!
li $t9, 0	# Alternative total value

	CalculateSumLoop:
		beq $t0, $t2, exitfunction
		lw $t4, 0($t1)
		andi $t4, 0x00FF
		
		sltiu $t6, $t4, 10	# 10, J, Q, K
		beqz $t6, upten
		
		beq $t4, 1, acecase	# A
		
		add $t7, $t7, $t4
		add $t9, $t9, $t4
		addi $t1, $t1, 4
		addi $t0, $t0, 1		
		j CalculateSumLoop
				
		acecase:
		
		addi $t8, $t7, 11
		sgt $t6, $t8, 21
		bnez $t6, sumone
		
		move $t9, $t8
		addi $t1, $t1, 4
		addi $t0, $t0, 1
		addi $t7, $t7, 1
		j CalculateSumLoop
				
		sumone:
		addi $t9, $t9, 1
		addi $t7, $t7, 1
		addi $t1, $t1, 4
		addi $t0, $t0, 1
		j CalculateSumLoop
		
		upten:
		addi $t9, $t9, 10
		addi $t7, $t7, 10
		addi $t1, $t1, 4
		addi $t0, $t0, 1
		j CalculateSumLoop


	exitfunction:
	move $v0, $t7
	
	beq $t9, $t7, exitfunctionnov1	# if v0 = v1, then v1 serves no purpose
	sgt $t6, $t9, 21		
	bnez $t6, exitfunctionnov1	# if v1 is greater than 21 it should not exist
	beq $t9, 21, exitfunctionnov1b	# if v1 is blackjack it moves to v0
	
	move $v1, $t9
	jr $ra
	
	exitfunctionnov1b:	# $v1 is blackjack thus it replaces $v0
	move $v0, $t9
	li $v1, 0
	jr $ra
	
	exitfunctionnov1:	# $v1 is deleted (serves no purpose)
	li $v1, 0
	jr $ra


ContinueOption:


## If language = 1, then the message displays in english. Any other value for s0 displays the message in espanish (esp4).
addi $t0, $s0, -1

sw $ra, rastorage
la $a0, pressEnter
la $a1, presionaEnter
jal Translator
lw $ra, rastorage

li $a0, '>'
li $v0, 11
syscall

	notenter:
		li $v0, 12
		syscall
		
		beq $v0, 10, enterpressed
		j notenter

	enterpressed:
		jr $ra

TranslateCard: # This function receives a card into $a0 and prints out the card

move $a1, $a0



# Card print

li $t2, 11
li $t3, 12
li $t4, 13
li $t5, 1

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
sw $ra, rastorage
la $a0, ofclubs		
la $a1, depicas
jal Translator
lw $ra, rastorage
jr $ra

diamonds:
sw $ra, rastorage
la $a0, ofdiamonds		
la $a1, dediamantes
jal Translator
lw $ra, rastorage
jr $ra

hearts:
sw $ra, rastorage
la $a0, ofhearts		
la $a1, decorazones
jal Translator
lw $ra, rastorage
jr $ra

spades:
sw $ra, rastorage
la $a0, ofspades		
la $a1, deespadas
jal Translator
lw $ra, rastorage
jr $ra


GenerateCards: ## This function generates all the cards (22) and stores them in the array

la $t5, Cards 
li $t6, 0		# Counter
li $t7, 21	# Limit (maximum of iterations)

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



GenerateCard: ## This function returns a card to $v0

li $v0, 30
syscall
li $a1, 13
li $v0, 42	
syscall        	 	# This syscall generates a random number between 0 and 12 inclusive
addi $t1, $a0, 1	# Now the function adds 1 (so the range is between 1-13) and it passes the value to the temporal register $t1.

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


IsTheCardShown: ## This function receives a card in the paramater $a0 and returns to $v1 a 1 if it is has already been shown and a 0 if it hasnt been shown.

li $v1, 0		# The default value is not shown
li $t4, 8		# Number of times the loop has to be repeated (it only has to check for 8 elements as there is no need to check after the nineth card is added)
li $t0, 0 		# Counter
la $t1, Cards	# Adress of the array

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


SetCardsShownToZero: ## This function sets all the values of the array to 0.

li $v1, 0		# The default value is not shown
li $t4, 21		# Number of times the loop has to be repeated (22 cards)
li $t0, 0 		# Counter
la $t1, Cards	# Adress of the array

	loop3:
	sw $zero, 0($t1)		# Erases the value of the cards individually.
	beq $t0, $t4, back_to_main2	# If the counter arrives to the maximum number of iterations it goes back the main.
	addi $t1, $t1, 4		# The adress gets 4 bits added, moving on to the next card
	addi $t0, $t0, 1		# The normal counter + 1
	j loop3

	back_to_main2:
		jr $ra
