extends KinematicBody2D

var velocity = Vector2.ZERO
var move_speed = 200
var gravity = 1200
var jump_force = 450
var move_direction
var terminal_velocity = 500
onready var raycasts = $RaycastsGroup
var total_apples = 0
var total_bananas = 0


func _physics_process(delta):	
	if is_player_on_ground(): velocity.y = 0
	check_move_direction()
	check_jump()
	check_animation()		
	check_terminal_velocity()
	move(delta)
	
	
func check_terminal_velocity():
	if velocity.y > terminal_velocity: velocity.y = terminal_velocity
	
	
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
	
	
func add_apples(count_apples):
	total_apples += count_apples
	
	
func add_single_apple():
	add_apples(1)
	

func get_total_apples():
	return total_apples
	
	
func add_single_banana():
	total_bananas += 1
	
