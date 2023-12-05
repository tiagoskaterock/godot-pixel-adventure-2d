extends KinematicBody2D

var velocity = Vector2.ZERO
var move_speed = 60
var gravity = 100
var move_direction = Vector2.LEFT # Define a direção inicial
var direction = 'left'

func _physics_process(delta):    
	velocity.y += gravity * delta
	
	# Define a direção com base na variável 'direction'
	if direction == 'left':
		move_direction = Vector2.LEFT
	elif direction == 'right':
		move_direction = Vector2.RIGHT
	
	velocity.x = move_direction.x * move_speed
	
	# Verifica se está no chão
	if is_on_floor():
		velocity.y = 0
	else:
		# Se não estiver no chão, aplica gravidade
		velocity.y += gravity * delta
	
	# Verifica se está na parede na direção horizontal
	if move_direction.x != 0:
		var is_colliding_wall = move_and_collide(velocity * delta)
		if is_colliding_wall:
			print('wall')
	
	move_and_slide(velocity, Vector2.UP) # Passa Vector2.UP para indicar a direção da colisão
