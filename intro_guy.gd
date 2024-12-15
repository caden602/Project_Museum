extends CharacterBody2D

var happening = false

func inactive():
	$AnimationPlayer.play("intro_left")

func _physics_process(delta: float) -> void:
	if not happening:
		inactive()
	happening = false
	
	
func active():
	$AnimationPlayer.play("intro_right")
	happening = true
