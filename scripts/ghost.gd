extends CharacterBody2D

# Store the initial position to maintain the bobbing centered
var initial_position: Vector2

# Function to start the bobbing effect
func start_bobbing():
	var tween: Tween = get_tree().create_tween()
	
	# Define target position to move up by 1 pixel from the initial position
	var target_position = initial_position + Vector2(0, -1)  # Move up by 1 pixel

	# Animate up
	tween.tween_property($Sprite2D, "position", target_position, 0.5)
	
	# Connect the "finished" signal to alternate bobbing direction
	tween.finished.connect(_bob_down)

# Callback to animate the sprite down
func _bob_down():
	var tween: Tween = get_tree().create_tween()
	
	# Move down by 1 pixel from the initial position
	var target_position = initial_position + Vector2(0, 1)  # Move down by 1 pixel
	tween.tween_property($Sprite2D, "position", target_position, 0.5)
	
	# Connect back to start the upward motion
	tween.finished.connect(start_bobbing)

func _ready():
	# Set the initial position to the sprite's starting position
	initial_position = $Sprite2D.position
	start_bobbing()
