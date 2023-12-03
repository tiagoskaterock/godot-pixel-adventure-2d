extends KinematicBody2D

var velocity = Vector2.ZERO
var move_speed = 200
var gravity = 1200
var jump_force = 300
var move_direction

func _physics_process(delta):
	check_move_direction()
	check_jump()
	check_animation()	
	move(delta)
	

func check_move_direction():
	move_direction = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	if move_direction < 0: $Sprite.flip_h = true		
	elif move_direction > 0: $Sprite.flip_h = false
	

func check_animation():
	if move_direction != 0 : $AnimationPlayer.play("run")
	else: $AnimationPlayer.play("idle")
	
	
func check_jump():
	if Input.is_action_pressed("jump"):
		velocity.y = -jump_force
		
		
func move(delta):
	velocity.y += gravity * delta	
	velocity.x = move_speed * move_direction	
	move_and_slide(velocity)
		
