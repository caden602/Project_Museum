extends CharacterBody2D



func active():
	$AnimationPlayer.play("intro_right")


func inactive():
	$AnimationPlayer.play("intro_left")
