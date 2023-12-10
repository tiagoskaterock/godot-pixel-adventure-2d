extends KinematicBody2D

var velocity = Vector2.ZERO
var gravity = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity.y += gravity * delta
	move_and_slide(velocity, Vector2.UP) 


func _on_AreaDetection_body_entered(body):
	if body.name == "Player":
		$TimerToFall.start()
		$AnimationPlayer.play("Off")


func _on_TimerToFall_timeout():
	gravity = 650
