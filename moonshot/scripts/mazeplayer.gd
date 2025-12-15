extends CharacterBody2D

@export var speed = 200

func _physics_process(delta):
	var dir = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	).normalized()
	velocity = dir * speed
	move_and_slide()
