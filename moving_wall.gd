extends CharacterBody2D

var count: int = 0
var y_tracker: int
var x_tracker: int
var start_x = 88
var start_y = 32

func _ready():
	position.x = start_x
	position.y = start_y
	y_tracker = start_y
	x_tracker = start_x
func open():
	if count%10 == 0: # one move per 1/2 sec
		if start_y - y_tracker <= 5: # move up
			position.y -= 1
		elif start_x - x_tracker <= 15: #adjust for left movement
			position.x -= 1
	count += 1
	x_tracker = position.x
	y_tracker = position.y
	
func close():
	if count%10 == 0:
		if start_x - x_tracker > 0:
			position.x += 1
		elif start_y - y_tracker > 0:
			position.y += 1
	count += 1
	x_tracker = position.x
	y_tracker = position.y
	
