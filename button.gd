extends Area2D

var on

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))
	# on == false

# Called when a `CharacterBody2D` (or other physics body) enters the area
func _on_body_entered(body):
	on = true
		# Add more logic here as needed

# Optional: Called when a physics body exits the area
func _on_body_exited(body):
	on = false
		
func _process(delta):
	if on:
		$AnimationPlayer.play("buttonDown")
		get_parent().get_node("movingWall").open()
	else:
		$AnimationPlayer.play("buttonUp")
		get_parent().get_node("movingWall").close()

	
		
