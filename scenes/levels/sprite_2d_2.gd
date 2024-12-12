extends Sprite2D

@export var fade_duration : float = 1.5  # Time to fade in/out
@export var min_opacity : float = 0.0    # Minimum opacity (invisible)
@export var max_opacity : float = 1.0    # Maximum opacity (fully visible)
@export var pause_time : float = 0.0    # Time to pause between fades

var tween : Tween

func _ready():
	# Start the fading process when the scene loads
	start_fade_cycle()

func start_fade_cycle():
	# Create a new tween if it doesn't exist
	tween = create_tween()
	tween.set_loops()  # Make the tween repeat indefinitely
	
	# Fade out
	tween.tween_property(self, "modulate:a", min_opacity, fade_duration) \
		.set_trans(Tween.TRANS_SINE) \
		.set_ease(Tween.EASE_IN_OUT)
	
	# Pause at minimum opacity
	tween.tween_interval(pause_time)
	
	# Fade in
	tween.tween_property(self, "modulate:a", max_opacity, fade_duration) \
		.set_trans(Tween.TRANS_SINE) \
		.set_ease(Tween.EASE_IN_OUT)
	
	# Pause at maximum opacity
	tween.tween_interval(pause_time)

# Optional: Methods to manually control fading
func fade_in():
	if tween:
		tween.kill()
	var fade_in_tween = create_tween()
	fade_in_tween.tween_property(self, "modulate:a", max_opacity, fade_duration) \
		.set_trans(Tween.TRANS_SINE) \
		.set_ease(Tween.EASE_IN_OUT)

func fade_out():
	if tween:
		tween.kill()
	var fade_out_tween = create_tween()
	fade_out_tween.tween_property(self, "modulate:a", min_opacity, fade_duration) \
		.set_trans(Tween.TRANS_SINE) \
		.set_ease(Tween.EASE_IN_OUT)
