extends Area2D

@export var fall_speed := 200
	
func _process(delta):
	position.y += fall_speed * delta

	if position.y > 658 + 10:
		position.x = randi_range(10, 1142)
		position.y = 0

func _on_body_entered(body: Node2D) -> void:
	Gamemanager.mazeCompleted = false
	Gamemanager.starCompleted = false
	get_tree().change_scene_to_file("res://scenes/main.tscn")
