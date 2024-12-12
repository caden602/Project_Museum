extends CharacterBody2D

var isActive = false

func _physics_process(delta: float) -> void:
	inactive()




func inactive():
	$AnimationPlayer.play("intro_left")
	
func active():
	$AnimationPlayer.play("intro_right")
