extends HSlider

@onready var model = $"../../Model"
@onready var label = $Label

func _ready():
	label.text = "Value of r: %s" % (model.r)

# When the value changes
func _value_changed(new_value):
	model.r = value
	label.text = "Value of r: %s" % (model.r)

func _on_recalculate_r_pressed():
	label.text = "Value of r: %s" % (model.r)
	value = model.r
