extends Area2D

var interact
var enlarge
var enlarged = false
var lit = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	modulate.a = 0
	interact = get_parent().get_parent().get_node("interact")
	enlarge = get_parent().get_parent().get_node("HUD").get_node("notebookInspect")
	enlarge.modulate.a = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if lit:
		var x_pos = get_parent().get_parent().get_node("player").position.x
		var y_pos = get_parent().get_parent().get_node("player").position.y
		interact.modulate.a = 1
		interact.position.x = x_pos
		interact.position.y = y_pos - 10
		#display.get_node("inspect").position.x = x_pos
		#display.get_node("inspect").position.y = y_pos - 10
		if Input.is_action_just_pressed("e"):
			if not enlarged:
				enlarge.modulate.a = 1
				enlarged = true
			else:
				enlarge.modulate.a = 0
				enlarged = false
			
	else:
		interact.modulate.a = 0
		enlarge.modulate.a = 0

func _on_body_entered(body: Node2D) -> void:
	modulate.a = 1
	lit = true
	print("CLOSE")
func _on_body_exited(body: Node2D) -> void:
	modulate.a = 0
	lit = false
	print("EXITED")
	
