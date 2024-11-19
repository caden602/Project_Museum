extends Area2D

@export var text_key: String = ""

enum State {
	TALKING,
	NOT_TALKING
}

var area_active: bool = false
var current_state = State.NOT_TALKING

func _input(event):
	if (current_state == State.NOT_TALKING) and area_active and event.is_action_pressed("space"):
		SignalBus.emit_signal("display_dialog", text_key)
		current_state = State.TALKING

func _on_DialogArea_area_entered(_area):
	area_active = true
	
func _on_DialogArea_area_exited(_area):
	area_active = false
	current_state = State.NOT_TALKING
