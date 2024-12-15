extends Area2D

var lit = false
var has_ankh = false
var interact

func _ready() -> void:
	$highlighted.modulate.a = 0
	interact = get_parent().get_node("interact")
	
func _process(delta: float) -> void:
	if lit:
		var x_pos = get_parent().get_node("player").position.x
		var y_pos = get_parent().get_node("player").position.y
		interact.modulate.a = 1
		interact.position.x = x_pos
		interact.position.y = y_pos - 10
		#display.get_node("inspect").position.x = x_pos
		#display.get_node("inspect").position.y = y_pos - 10
		if Input.is_action_just_pressed("e"):
			modulate.a = 0
			interact.modulate.a = 0
			has_ankh = true
			
	else:
		interact.modulate.a = 0
	if has_ankh:
		get_parent().get_node("HUD").got_ankh()



func _on_body_entered(body: Node2D) -> void:
	if not has_ankh:
		$highlighted.modulate.a = 1
		lit = true


func _on_body_exited(body: Node2D) -> void:
	$highlighted.modulate.a = 0
	lit = false
