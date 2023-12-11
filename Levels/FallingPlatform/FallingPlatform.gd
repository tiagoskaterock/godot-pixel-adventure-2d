extends KinematicBody2D

var velocity = Vector2.ZERO
var gravity = 0
var gravity_to_fall = 300
onready var reset_position = global_position.y

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):	
	velocity.y += gravity * delta
	move_and_slide(velocity, Vector2.UP) 


func _on_AreaDetection_body_entered(body):
	if body.name == "Player":
		if body.velocity.y > 0:			
			print (body.velocity.y)
			$TimerToFall.start()
			$AnimationPlayer.play("Shake")


func _on_TimerToFall_timeout():
	$TimerToRespawn.start()	
	gravity = gravity_to_fall


func _on_TimerToRespawn_timeout():
	$AnimationPlayer.play("On")
	global_position.y = reset_position
	gravity = 0
	velocity.y = 0
