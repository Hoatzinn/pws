extends Button
@onready var model = $"../../Model"



func _on_pressed():
	if model.pause:
		text = "Paused"
	else:
		text = "Pause"
