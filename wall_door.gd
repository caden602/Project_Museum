extends Area2D

var allow_enter = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$disable.visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not allow_enter:
		$disable.get_node("collisionDisable").disabled = false 
	else:
		$disable.get_node("collisionDisable").disabled = true 
func fully_opened():
	print("OPEN")
	allow_enter = true
	
func not_fully_opened():
	print("not")
	allow_enter = false
