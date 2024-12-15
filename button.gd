extends Area2D

@onready var timer = $Timer

var inventor_talked: bool = false
var button3: bool = false
var button4: bool = false

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))
	SignalBus.connect("inventor_talked", Callable(self, "on_inventor_talked"))
	#SignalBus.connect("button3", Callable(self, "on_button_3"))
	#SignalBus.connect("button4", Callable(self, "on_button_4"))
	#SignalBus.connect("button5", Callable(self, "on_button_5"))

# Called when a `CharacterBody2D` (or other physics body) enters the area
func _on_body_entered(body):
	$AnimationPlayer.play("buttonDown")
	
	if is_in_group("button1"):
		get_parent().get_node("movingWall").open()
	
	if is_in_group("button2") and inventor_talked:
		SignalBus.emit_signal("toggle_lantern", true)
			
	# Combination: 435
	if is_in_group("button3"): #and timer.get_time_left() > 0.0:
		SignalBus.emit_signal("button3")
		
	if is_in_group("button4"):
		timer.start()
		SignalBus.emit_signal("button4")
		
	if is_in_group("button5"): #and timer.get_time_left() > 0.0:
		SignalBus.emit_signal("button5")
		
		


# Optional: Called when a physics body exits the area
func _on_body_exited(body):
	$AnimationPlayer.play("buttonUp")
	
	if is_in_group("button1"):
		get_parent().get_node("movingWall").close()
		
	if is_in_group("button2"):
		SignalBus.emit_signal("toggle_lantern", false)
		
func on_inventor_talked(condition):
	inventor_talked = condition


func _on_timer_timeout() -> void:
	pass
	#button3 = false
	#button4 = false
	#button5 = false
	
