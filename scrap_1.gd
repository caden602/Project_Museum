extends Area2D

var interact
var has_scrap_left = false
var lit = false
var collected = false

func _ready() -> void:
	lit = false
	$highlight.modulate.a = 0
	interact = get_parent().get_parent().get_node("interact")

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
			get_parent().get_parent().get_node("HUD").got_scrap_left()
			modulate.a = 0
			if not collected:
				get_parent().get_node("painting").piece_count()
				collected = true
			
	else:
		interact.modulate.a = 0

func _on_body_entered(body: Node2D) -> void:
	if not has_scrap_left:
		$highlight.modulate.a = 1
		lit = true
	
func _on_body_exited(body: Node2D) -> void:
	$highlight.modulate.a = 0
	lit = false