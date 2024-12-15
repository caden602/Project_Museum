extends CanvasLayer

var has_ankh = false
var has_scrap_right = false
var has_scrap_middle = false
var has_scrap_left = false
var has_key = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$notebookInspect.modulate.a = 0
	$ankh.modulate.a = 0
	$paintingPieces/paintingPiece3.modulate.a = 0
	$paintingPieces/paintingPiece2.modulate.a = 0
	$paintingPieces/paintingPiece1.modulate.a = 0
	$key.modulate.a = 0




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if has_ankh:
		$ankh.modulate.a = 1
	if has_scrap_right:
		$paintingPieces/paintingPiece3.modulate.a = 1
	else:
		$paintingPieces/paintingPiece3.modulate.a = 0
	if has_scrap_middle:
		$paintingPieces/paintingPiece2.modulate.a = 1
	else:
		$paintingPieces/paintingPiece2.modulate.a = 0
	if has_scrap_left:
		$paintingPieces/paintingPiece1.modulate.a = 1
	else:
		$paintingPieces/paintingPiece1.modulate.a = 0
	if has_key:
		$key.modulate.a = 1
	
	
func got_ankh():
	has_ankh = true
	
func got_scrap_right():
	has_scrap_right = true
	
func got_scrap_middle():
	has_scrap_middle = true
	
func got_scrap_left():
	has_scrap_left = true
	
func got_key():
	has_key = true
