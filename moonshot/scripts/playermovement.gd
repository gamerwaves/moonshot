extends CharacterBody2D

@export var speed := 200


func _physics_process(delta):
	var direction := 0

	if Input.is_action_pressed("star_left"):
		direction -= 1
	if Input.is_action_pressed("star_right"):
		direction += 1

	velocity.x = direction * speed
	velocity.y = 0

	move_and_slide()

	var viewport_size = get_viewport_rect().size

	position.x = clamp(position.x, -550, 550)
	position.y = clamp(position.y, 0, 648)
