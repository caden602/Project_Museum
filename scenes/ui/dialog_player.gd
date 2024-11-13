extends CanvasLayer

@export_file("*json") var scene_text_file: String

var scene_text: Dictionary = {}
var selected_text: Array = []
var in_progress: bool = false
var ratio: float = 0.0
var index: int = 0
var choice: bool = false
var choice_index: String = '1'
var textKey: String = ''
var baseKey: String = ''
var first_run: bool = false

@onready var background = $Background
@onready var text_label = $TextLabel
@onready var timer = $Timer
@onready var choice_container = $ChoiceContainer
@onready var choice1 = $ChoiceContainer/Choice1
@onready var choice2 = $ChoiceContainer/Choice2

func _ready():
	background.visible = false
	scene_text = load_scene_text()
	SignalBus.connect("display_dialog", Callable(self, "on_display_dialog"))
	choice_container.hide()
	first_run = true


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
	timer.start()
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
	if (first_run):
		baseKey = text_key
	first_run = false
	textKey = text_key
	index = 0

	if in_progress:
		next_line()
	else:
		get_tree().paused = true
		background.visible = true
		in_progress = true
		selected_text = scene_text[textKey].duplicate()
		show_text()


func _on_timer_timeout():
	ratio += 0.1
	text_label.visible_ratio = ratio
	show_text()
	if (ratio >= 1):
		timer.stop()
		if contains_newline(selected_text.front()):
			choice_container.show()
			choice1.grab_focus()
			textKey = calculate_choice(choice_index)
			on_display_dialog(textKey)

func contains_newline(text: String) -> bool:
	return "\t" in text

func calculate_option(textKey, options_index) -> String:
	return ("%s%d" % [baseKey, options_index])

func calculate_choice(choice_index) -> String:
	textKey += "." + choice_index
	return textKey

func _on_choice_1_pressed():	
	textKey = calculate_option(textKey, 1)
	print(textKey)
	on_display_dialog(textKey)
	choice_container.hide()


func _on_choice_2_pressed():
	textKey = calculate_option(textKey, 2)
	print(textKey)
	on_display_dialog(textKey)
	choice_container.hide()