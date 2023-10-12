extends HSlider

@onready var model = $"../../Model"
@onready var label = $Label

func _ready():
	label.text = "Number of big main dots: %s" % (model.main_dot_amount)

# When the value changes
func _value_changed(new_value):
	model.main_dot_amount = value
	label.text = "Number of big main dots: %s" % (model.main_dot_amount)
