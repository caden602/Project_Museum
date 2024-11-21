extends CanvasLayer

@export_file("*json") var scene_text_file: String

@onready var background = $Background
@onready var text_label = $TextLabel
@onready var timer = $Timer
@onready var choice_container = $ChoiceContainer
@onready var choice1 = $ChoiceContainer/Choice1
@onready var choice2 = $ChoiceContainer/Choice2

var scene_text: Dictionary = {}
var selected_text: Array = []
var in_progress: bool = false
var ratio: float = 0.0
var index: int = 0
var choice: bool = false
var choice_index: String = '1'
var textKey: String = ''
var baseKey: String = ''
var current_state = State.FIRST_RUN

enum State {
	FIRST_RUN,
	RUNNING,
	PLAYER_CHOICE
}

func _ready():
	background.visible = false
	scene_text = load_scene_text()
	SignalBus.connect("display_dialog", Callable(self, "on_display_dialog"))
	current_state == State.FIRST_RUN
	choice_container.hide()
	ratio = 0


func load_scene_text():
	if FileAccess.file_exists(scene_text_file):
		var file = FileAccess.open(scene_text_file, FileAccess.READ)
		var test_json_conv = JSON.new()
		test_json_conv.parse(file.get_as_text())
		return test_json_conv.get_data()

func show_text():
	timer.start()
	text_label.text = selected_text.front()
	
func _input(event):
	if current_state == State.RUNNING and (event.is_action_pressed("space")):
		next_line()

func next_line():
	timer.start()
	print(selected_text)
	if selected_text.size() > 0:
		selected_text.pop_front()
		ratio = 0
		timer.stop()
	else:
		finish()

func finish():
	text_label.text = ""
	background.visible = false
	in_progress = false
	get_tree().paused = false
	timer.stop()
	
func on_display_dialog(text_key):
	if (current_state == State.FIRST_RUN):
		baseKey = text_key
	current_state == State.RUNNING
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
	if selected_text.size() > 0:
		show_text()
		if (ratio >= 1):
			if contains_newline(selected_text.front()):
				choice_container.show()
				choice1.grab_focus()
				in_progress = false;
				textKey = calculate_choice(choice_index)
				print("text", textKey)
				on_display_dialog(textKey)
			timer.stop()

func contains_newline(text: String) -> bool:
	return "\t" in text	

func calculate_option(options_index) -> String:
	# Split the string at the '.' and take the first part (before the dot).
	var base_name = textKey.split(".")[0]
	# Append '1' to the end of the base name.
	return ("%s%d" % [base_name, options_index])

func calculate_choice(choice_index) -> String:
	textKey += "." + choice_index
	return textKey

func _on_choice_1_pressed():	
	in_progress = false
	current_state = State.PLAYER_CHOICE
	textKey = calculate_option(1)
	print(textKey)
	on_display_dialog(textKey)
	choice_container.hide()


func _on_choice_2_pressed():
	in_progress = false
	current_state = State.PLAYER_CHOICE
	textKey = calculate_option(2)
	on_display_dialog(textKey)
	choice_container.hide()
