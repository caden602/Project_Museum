extends Node

var toggled_button3: bool = false
var toggled_button4: bool = false

func _ready():
	SignalBus.connect("button3", Callable(self, "on_button_3"))
	SignalBus.connect("button4", Callable(self, "on_button_4"))
	SignalBus.connect("button5", Callable(self, "on_button_5"))
	
func on_button_3():
	if toggled_button4:
		toggled_button3 = true
	
func on_button_4():
	toggled_button4 = true
	
func on_button_5():
	if toggled_button3 and toggled_button4:
		SignalBus.emit_signal("button_door_unlocked")
