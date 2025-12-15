extends Node


func _on_button_button_up() -> void:
	get_tree().change_scene_to_file("res://scenes/two.tscn")


func startStargazing() -> void:
	if Gamemanager.starCompleted == false:
		get_tree().change_scene_to_file("res://scenes/starfall.tscn")


func mazebutton() -> void:
	if Gamemanager.mazeCompleted == false:
		get_tree().change_scene_to_file("res://scenes/maze.tscn")

func doorbutton() -> void:
	if Gamemanager.gameFinished == true:
		get_tree().change_scene_to_file("res://scenes/intros/three.tscn")


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/intros/two.tscn")
