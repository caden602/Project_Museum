extends CharacterBody2D

var speed = 200.0

func move(movement):
	velocity = movement
	move_and_slide()
