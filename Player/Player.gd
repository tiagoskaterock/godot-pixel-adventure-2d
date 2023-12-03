extends KinematicBody2D

var velocity = Vector2.ZERO
var move_speed = 200
var gravity = 1200
var jump_force = 350
var move_direction
onready var raycasts = $RaycastsGroup


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
	if ! is_player_on_ground(): $AnimationPlayer.play("jump")
	elif move_direction != 0 : $AnimationPlayer.play("run")
	else: $AnimationPlayer.play("idle")
	
	
func check_jump():
	if Input.is_action_pressed("jump") and is_player_on_ground():
		velocity.y = -jump_force
		
		
func move(delta):
	velocity.y += gravity * delta	
	# velocity.x = move_speed * move_direction	
	
	velocity.x = lerp(velocity.x, move_speed * move_direction, 0.2)
	move_and_slide(velocity)
		

func is_player_on_ground():
	for ray in raycasts.get_children():
		if ray.is_colliding():
			return true
	return false
