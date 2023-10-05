extends HSlider

@onready var model = $"../../Model"

# When the value changes
func _value_changed(new_value):
	model.main_dot_amount = value
