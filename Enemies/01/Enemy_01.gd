extends KinematicBody2D

var velocity = Vector2.ZERO
var move_speed = 50
var gravity = 100
export var direction = 'left'
var state = 'Idle'
var is_alive = true
var deathSoundPlayed = false

func _physics_process(delta):  
	if is_alive: alive_animation(delta)
	else: dead_animation()


func alive_animation(delta):
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


func dead_animation():
	$AnimationPlayer.play("Hit")
	

func _on_TimerDead_timeout():
	queue_free()


func _on_HitBox_area_entered(area):
	print('_on_HitBox_area_entered')	
	$TimerDead.start()
	call_deferred("_disable_collision_shapes", area)
	if ! deathSoundPlayed: 		
		deathSoundPlayed = true
		$DeathFX.play()


func _disable_collision_shapes(area):
	$CollisionShape2D.disabled = true
	$HitBox/CollisionShape2D.disabled = true
	$Enemy_01_HurtBox/CollisionShape2D.disabled = true
	if area.name == 'StompArea':
		is_alive = false
