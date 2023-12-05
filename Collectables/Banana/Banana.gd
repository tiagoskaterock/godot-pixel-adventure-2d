extends Area2D

var get_already = false

func _on_Banana_body_exited(body):	
	if body.name == "Player" and ! get_already:
		get_already = true
		body.add_single_banana()
		$AnimationPlayer.play("Collected")
		print("total_bananas: " + str(body.total_bananas))


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Collected":
		queue_free()
