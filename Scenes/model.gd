extends Camera2D

#@export var radius:int
@export var main_dot_amount:int
var zooming:int
var main_dots = []
@export var start_position:Vector2
var old_pos:Vector2
@export var r:float


'''
TODO: hue, reset + sliders, cantchoosesamepointtwice, camera slide or whatever
'''


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	var viewport_size = get_viewport_rect().size
	var radius = viewport_size.y*2
	var name_scheme = "MainDot%s" # cool gimick https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_format_string.html
	for i in range(main_dot_amount):
		var angle = i * PI*2.0 / main_dot_amount
		var new_position = Vector2(cos(angle)*radius, sin(angle)*radius)
		var main_dot = preload("res://Scenes/main_dot.tscn").instantiate()
		add_child(main_dot)
		main_dot.position = new_position
		main_dot.name = name_scheme % (i+1)
		main_dots.append(main_dot)
		
	for dot in get_children():
		print("---\nName:%s\nPosition:%s" % [dot.name, dot.position])
	print("---")

	r = 1-(len(main_dots)/(len(main_dots)+3.0))
	print("\n--- Value of r: " + str(r) + "---")
	
	old_pos = start_position



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	'''
	scene.translate(Vector2(randf_range(-1000, 1000),randf_range(-1000, 1000)))'''
	
	for i in range(10):
		_new_small_dot()
	
	
	
	if Input.is_action_pressed("zoom in"):
		zoom = zoom.lerp(zoom*1.3, delta * 4.0)
	elif Input.is_action_pressed("zoom out"):
		zoom = zoom.lerp(zoom*0.7, delta * 4.0)

func _new_small_dot():
	var random_main_dot = main_dots[randf_range(0, len(main_dots))]
	
	
	var target_location:Vector2 = (old_pos+random_main_dot.position)*r
	
	var small_dot = preload("res://Scenes/smaller_dot.tscn").instantiate()
	add_child(small_dot)
	small_dot.position = target_location
	old_pos = target_location
