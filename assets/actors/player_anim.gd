extends CharacterBody2D

var speed = 200.0  # Speed of the player
var crate: CharacterBody2D
var crate_direction = "up"
# Called when the node enters the scene tree for the first time.
func _ready():
	# Find the crate in the scene (or assign manually)
	crate = get_parent().get_node("crate")

# Called every frame. Handles player movement and crate interaction.
func _physics_process(delta):
	# Basic movement input
	var movement = Vector2.ZERO
	var crate_movement = Vector2.ZERO

	if Input.is_action_pressed("move_left"):
		if int(delta)%10 == 0:
			movement.x -= 0.5
		$AnimationPlayer.play("walk_left")
	if Input.is_action_pressed("move_right"):
		if int(delta)%10 == 0:
			movement.x += 0.5
		$AnimationPlayer.play("walk_right")
	if Input.is_action_pressed("move_up"):
		if int(delta)%10 == 0:
			movement.y -= 0.5
		$AnimationPlayer.play("walk_back")
	if Input.is_action_pressed("move_down"):
		if int(delta)%10 == 0:
			movement.y += 0.5
		$AnimationPlayer.play("walk_forward")
 # Normalize and apply speed
	if movement != Vector2.ZERO:
		movement = movement.normalized() * speed
	else:
		$AnimationPlayer.play("stand_front")


	# Move the player character
	velocity = movement  # Update velocity for CharacterBody2D
	move_and_slide()  # Move the player using default arguments for sliding

	 # Check for collision with the other character manually
	if is_colliding_with_other_character():
		if Input.is_action_pressed("move_left") and crate_direction == "left":
			if int(delta)%10 == 0:
				crate_movement.x -= 0.5
		if Input.is_action_pressed("move_right") and crate_direction == "right":
			if int(delta)%10 == 0:
				crate_movement.x += 0.5
		if Input.is_action_pressed("move_up") and crate_direction == "up":
			if int(delta)%10 == 0:
				crate_movement.y -= 0.5
		if Input.is_action_pressed("move_down") and crate_direction == "down":
			if int(delta)%10 == 0:
				crate_movement.y += 0.5
		if crate_movement != Vector2.ZERO:
			crate_movement = crate_movement.normalized() * speed

		# Move the player character
		#velocity = movement  # Update velocity for CharacterBody2D
		#move_and_slide()  # Move the player using default arguments for sliding
		crate.move(movement)

# Check for a collision with another character manually
func is_colliding_with_other_character() -> bool:
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		if collision.get_collider().is_in_group("crate_top"):
			crate_direction = "down"
		elif collision.get_collider().is_in_group("crate_right"):
			crate_direction = "left"
		elif collision.get_collider().is_in_group("crate_left"):
			crate_direction = "right"
		elif collision.get_collider().is_in_group("crate_bottom"):
			crate_direction = "up"
		if collision.get_collider() == crate:
			return true
	return false
