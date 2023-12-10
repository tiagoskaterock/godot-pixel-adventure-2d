extends Area2D

export var go_to_scene = "res://Levels/Level_01.tscn"

func _on_Exit_01_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene(go_to_scene)	
