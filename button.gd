extends Area2D

var inventor_talked: bool = false

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))
	SignalBus.connect("inventor_talked", Callable(self, "on_inventor_talked"))

# Called when a `CharacterBody2D` (or other physics body) enters the area
func _on_body_entered(body):
	$AnimationPlayer.play("buttonDown")
	
	if is_in_group("button1"):
		get_parent().get_node("movingWall").open()
	
	if is_in_group("button2") and inventor_talked:
			SignalBus.emit_signal("toggle_lantern", true)


# Optional: Called when a physics body exits the area
func _on_body_exited(body):
	$AnimationPlayer.play("buttonUp")
	
	if is_in_group("button1"):
		get_parent().get_node("movingWall").close()
		
	if is_in_group("button2"):
		SignalBus.emit_signal("toggle_lantern", false)
		
func on_inventor_talked(condition):
	inventor_talked = condition
