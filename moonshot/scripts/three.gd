extends Node

var count := 0

func pressed() -> void:
	if count >= 4:
		get_tree().change_scene_to_file("res://scenes/intros/four.tscn")
	else:
		count+=1
		print(count)
