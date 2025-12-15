extends Area2D

func _on_area2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		Gamemanager.mazeCompleted = true
		get_tree().change_scene_to_file("res://scenes/main.tscn")
		if Gamemanager.starCompleted and Gamemanager.mazeCompleted:
			Gamemanager.gameFinished = true
