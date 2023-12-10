extends Area2D

var get_already = false

func _on_Apple_body_entered(body):
	if body.name == "Player" and ! get_already:
		$CollectingFX.play()
		get_already = true
		body.add_single_apple()
		$AnimationPlayer.play("Collected")
		print('total_apples: ' + str(body.total_apples))


func _on_AnimationPlayer_animation_finished(anim_name):	
	if anim_name == "Collected":
		queue_free()
