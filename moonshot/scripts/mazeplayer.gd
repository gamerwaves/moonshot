extends CharacterBody2D

@export var speed := 200
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta):
	# Get input direction
	var dir = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)

	# Normalize if not zero
	if dir != Vector2.ZERO:
		dir = dir.normalized()

	# Move character
	velocity = dir * speed
	move_and_slide()

	# Animation logic
	if dir == Vector2.ZERO:
		if sprite.animation != "idle":
			sprite.play("idle")
	else:
		if sprite.animation != "walk":
			sprite.play("walk")
		# Flip sprite based on horizontal movement
		if dir.x != 0:
			sprite.flip_h = dir.x < 0
