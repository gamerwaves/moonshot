extends Area2D

@export var fall_speed := 200

	
func _process(delta):
	position.y += fall_speed * delta

	if position.y > 800:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	print("entered")


func _on_body_exited(body: Node2D) -> void:
	print("exited")
