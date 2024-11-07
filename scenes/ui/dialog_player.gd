extends CanvasLayer

@export_file("*json") var scene_text_file: String

var scene_text: Dictionary = {}
var selected_text: Array = []
var in_progress: bool = false
var ratio: float = 0.0
var index: int = 0

@onready var background = $Background
@onready var text_label = $TextLabel
@onready var timer = $Timer

func _ready():
	background.visible = false
	scene_text = load_scene_text()
	SignalBus.connect("display_dialog", Callable(self, "on_display_dialog"))

func load_scene_text():
	if FileAccess.file_exists(scene_text_file):
		var file = FileAccess.open(scene_text_file, FileAccess.READ)
		var test_json_conv = JSON.new()
		test_json_conv.parse(file.get_as_text())
		return test_json_conv.get_data()

func show_text():
	timer.start()
	text_label.text = selected_text.front()
	

func next_line():
	selected_text.pop_front()
	if selected_text.size() > 0:
		ratio = 0
	else:
		finish()

func finish():
	text_label.text = ""
	background.visible = false
	in_progress = false
	get_tree().paused = false
	timer.stop()
	
func on_display_dialog(text_key):
	index = 0

	if in_progress:
		next_line()
	else:
		get_tree().paused = true
		background.visible = true
		in_progress = true
		selected_text = scene_text[text_key].duplicate()
		show_text()


func _on_timer_timeout():
	ratio += 0.1
	text_label.visible_ratio = ratio
	show_text()
