extends Area2D

@export var fall_speed := 200
	
func _process(delta):
	position.y += fall_speed * delta

	if position.y > 658 + 10:
		position.x = randi_range(10, 1142)
		position.y = 0

func _on_body_entered(body: Node2D) -> void:
	Gamemanager.collectStar()
	position.x = randi_range(10, 1142)
	position.y = 0


func _on_body_exited(body: Node2D) -> void:
	print("exited")
