extends Node2D

const SCREEN_WIDTH := 1152
const SCREEN_HEIGHT := 648
const FALL_SPEED := 200.0

func _ready():
	# Randomize once when the node is created
	randomize()
	
	# Set a random fixed X position across the screen
	position.x = randi_range(0, SCREEN_WIDTH)
	
	# Start above the screen
	position.y = -10

	
func _process(delta):
	position.y += fall_speed * delta

	if position.y > 800:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	print("entered")


func _on_body_exited(body: Node2D) -> void:
	print("exited")
