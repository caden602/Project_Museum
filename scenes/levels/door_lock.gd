extends Area2D

var interact
var lit = false
var unlock_allowed = false
var lock_removed = false
var button_lock_removed = false

func _ready() -> void:
	SignalBus.connect("door_unlocked", Callable(self, "door_is_unlocked"))
	SignalBus.connect("button_door_unlocked", Callable(self, "button_door_is_unlocked"))

	$highlight.modulate.a = 0
	interact = get_parent().get_parent().get_node("interact")

func door_is_unlocked():
	unlock_allowed = true
	print("door unlocked")
	
func button_door_is_unlocked():
	if is_in_group("button_lock"):
		button_lock_removed = true
		self.visible = false


func _process(delta: float) -> void:
	if is_in_group("button_lock"):
		if Input.is_action_just_pressed("e") and button_lock_removed:
			get_parent().get_parent().get_node("transitionMaker").main_to_bedroom() #edit this
	if !is_in_group("button_lock"):
		if lit:
			var x_pos = get_parent().get_parent().get_node("player").position.x
			var y_pos = get_parent().get_parent().get_node("player").position.y
			interact.modulate.a = 1
			interact.position.x = x_pos
			interact.position.y = y_pos - 10
			#display.get_node("inspect").position.x = x_pos
			#display.get_node("inspect").position.y = y_pos - 10
			if Input.is_action_just_pressed("e"): #remove this?
				if not lock_removed:
					modulate.a = 0
					lock_removed = true
				else:
					get_parent().get_parent().get_node("transitionMaker").main_to_bedroom()
				
		else:
			interact.modulate.a = 0

func _on_body_entered(body: Node2D) -> void:
	if !is_in_group("button_lock"):
		if unlock_allowed and not lock_removed:
			$highlight.modulate.a = 1
			lit = true
		if unlock_allowed and lock_removed:
			lit = true

			
	
func _on_body_exited(body: Node2D) -> void:
	if !is_in_group("button_lock"):
		$highlight.modulate.a = 0
		lit = false
