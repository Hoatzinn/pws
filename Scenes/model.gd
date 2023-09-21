extends Sprite2D

#@onready var smaller_dot = load("res://Scenes/smaller_dot.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var scene = preload("res://Scenes/smaller_dot.tscn").instantiate()
	add_child(scene)
	scene.translate(Vector2(randf_range(-1000, 1000),randf_range(-1000, 1000)))
