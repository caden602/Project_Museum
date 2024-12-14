extends Area2D

var disabled = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$collisionDisable.disabled = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not disabled:
		$collisionDisable.disabled = false
	else:
		$collisionDisable.disabled = true
func fully_opened():
	print("OPEN")
	disabled = false
	
func not_fully_opened():
	print("not")
	disabled = true
