extends Sprite2D

@export var float_amplitude : float = 10.0  # How high it moves
@export var float_speed : float = 2.0       # Speed of floating

var start_y : float = 0.0

func _ready():
	# Store the initial vertical position
	start_y = position.y

func _process(delta):
	# Create a smooth up and down motion using sine wave
	# position.y = start_y + sin(Time.get_ticks_msec() * 0.002 * float_speed) * float_amplitude
	pass #for now but the above works to make it float
