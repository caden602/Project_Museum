extends Node2D

var bg_music: AudioStreamPlayer = AudioStreamPlayer.new()
var bg_rain: AudioStreamPlayer = AudioStreamPlayer.new()
var sound_effect : AudioStreamPlayer = AudioStreamPlayer.new()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bg_music.stream = load("res://assets/tilesets/music.wav")
	bg_music.autoplay = true
	bg_rain.stream = load("res://assets/tilesets/storm.wav")
	bg_rain.autoplay = true
	add_child(bg_music)
	add_child(bg_rain)
	add_child(sound_effect)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
