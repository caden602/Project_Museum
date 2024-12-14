extends Area2D

@onready var timer = $Timer

var inventor_talked: bool = false
var button3: bool = false
var button4: bool = false
var button5: bool = false

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
			
	if is_in_group("button3"): #and timer.get_time_left() > 0.0:
		if button4:
			button3 = true
		
	if is_in_group("button4"):
		timer.start()
		button4 = true
		
	if is_in_group("button5"): #and timer.get_time_left() > 0.0:
		if button3 and button4:
			button5 = true
	check_right()
		
		


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
	
func check_right():
	print(button3)
	print(button4)
	print(button5)
	if button3 and button4 and button5:
		SignalBus.emit_signal("door_unlocked")
		print("unlcokced")
		
