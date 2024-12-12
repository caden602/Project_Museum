extends Area2D

signal toggle_lantern


func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))
	# on == false

# Called when a `CharacterBody2D` (or other physics body) enters the area
func _on_body_entered(body):
	$AnimationPlayer.play("buttonDown")
	
	if is_in_group("button1"):
		get_parent().get_node("movingWall").open()
	
	if is_in_group("button2"):
			SignalBus.emit_signal("toggle_lantern", true)
		# Add more logic here as needed

# Optional: Called when a physics body exits the area
func _on_body_exited(body):
	$AnimationPlayer.play("buttonUp")
	
	if is_in_group("button1"):
		get_parent().get_node("movingWall").close()
		
	if is_in_group("button2"):
		SignalBus.emit_signal("toggle_lantern", false)
		
