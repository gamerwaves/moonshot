extends CharacterBody2D

@export var speed := 200
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta):
	var direction := 0

	if Input.is_action_pressed("left"):
		direction -= 1
	if Input.is_action_pressed("right"):
		direction += 1

	velocity.x = direction * speed
	velocity.y = 0
	move_and_slide()

	# Animation logic
	if direction == 0:
		sprite.play("idle")
	else:
		sprite.play("walk")
		sprite.flip_h = direction < 0

	# Clamp position
	position.x = clamp(position.x, -550, 550)
	position.y = clamp(position.y, 0, 648)
