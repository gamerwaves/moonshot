extends Node2D

func _ready():
	await wait()
	get_tree().change_scene_to_file("res://scenes/intros/five.tscn")

func wait():
	await get_tree().create_timer(5.0).timeout
