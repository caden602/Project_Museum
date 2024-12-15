extends CharacterBody2D

var happening = false

var is_chatting = false
var player_in_area = false
var counter = 0

func inactive():
	$AnimationPlayer.play("intro_left")

func _physics_process(delta: float) -> void:
	if not happening:
		inactive()
	happening = false
	
	
func active():
	$AnimationPlayer.play("intro_right")
	happening = true

func _process(delta):
	if player_in_area and Input.is_action_just_pressed("e"):
			run_dialog("receptionist_timeline")

func run_dialog(dialogue_string):
	is_chatting = true
	Dialogic.start(dialogue_string)	

func _on_chat_detection_zone_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_area = true


func _on_chat_detection_zone_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_area = false
