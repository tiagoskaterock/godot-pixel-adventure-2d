extends KinematicBody2D

var velocity = Vector2.ZERO
var move_speed = 50
var gravity = 100
export var direction = 'left'
var state = 'Idle'

func _physics_process(delta):  
	$AnimationPlayer.play(state)  
	velocity.y += gravity * delta	
							
	if state == 'Idle':
		velocity.x = 0
	else: check_direction()
	
	if is_on_floor():
		velocity.y = 0
	else:
		# Se não estiver no chão, aplica gravidade
		velocity.y += gravity * delta			
		
	move_and_slide(velocity, Vector2.UP) 
	
	if is_on_wall():
		change_direction()
	

func _on_Timer_timeout():
	change_state()


func check_direction():
	if direction == 'left':	
		$Sprite.flip_h = false	
		velocity.x = -move_speed
	else:
		$Sprite.flip_h = true
		velocity.x = move_speed
		

func change_direction():
	direction = 'left' if direction == 'right' else "right"


func change_state():
	state = 'Idle' if state == 'Run' else "Run"
