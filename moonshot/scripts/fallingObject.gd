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
	# Move downward at a constant speed
	position.y += FALL_SPEED * delta
	
	# Optional: reset when it leaves the screen
	if position.y > SCREEN_HEIGHT + 10:
		position.y = -10
		position.x = randi_range(0, SCREEN_WIDTH)
