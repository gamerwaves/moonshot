extends CharacterBody2D

@export var speed := 300
@export var count := 5


func _physics_process(delta):
	var direction := 0

	if Input.is_action_pressed("ui_left"):
		direction -= 1
	if Input.is_action_pressed("ui_right"):
		direction += 1

	velocity.x = direction * speed
	velocity.y = 0

	move_and_slide()

	# --- Keep character inside the screen ---
	var viewport_size = get_viewport_rect().size

	position.x = clamp(position.x, 0, 1100)
	position.y = clamp(position.y, 0, 648)
