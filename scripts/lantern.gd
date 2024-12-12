extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.connect("toggle_lantern", Callable(self, "on_toggle"))
	self.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func on_toggle(enabled):
	if enabled:
		self.visible = true
	else:
		self.visible = false
