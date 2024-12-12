extends Node2D

@onready var timer = $Timer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.connect("toggle_lantern", Callable(self, "on_toggle"))
	self.visible = false
	
func on_toggle(enabled):
	if enabled:
		timer.start()
		self.visible = true
	else:
		pass

func _on_timer_timeout() -> void:
	timer.stop()
	Dialogic.start("inventor_timeline2")	
