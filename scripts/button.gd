extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	Dialogic.signal_event.connect(DialogicSignal)
	print(Dialogic.VAR.Variable)

func _on_pressed():
	Dialogic.timeline_ended.connect(ended)
	Dialogic.start("timeline")

func ended():
	Dialogic.timeline_ended.disconnect(ended)
	print("ended")

func DialogicSignal(argument:String):
	if argument == "test":
		print("Signal Received")
