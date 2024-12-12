extends Area2D

var unlocked: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.connect("door_unlocked", Callable(self, "on_unlock_door"))


func on_unlock_door():
	self.visible = false
	unlocked = true


