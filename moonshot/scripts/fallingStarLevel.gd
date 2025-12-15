extends Node2D

@export var falling_object_scene: PackedScene
@export var spawn_width := 640

func _on_spawn_timer_timeout():
	var obj = falling_object_scene.instantiate()
	obj.position = Vector2(
		randf_range(0, spawn_width),
		-50
	)
	add_child(obj)

func _process(delta):
	$CountdownLabel.text = "Stars: " + str(Gamemanager.starCountdown)
