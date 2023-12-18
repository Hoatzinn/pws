extends Camera2D

#@export var radius:int
@export var main_dot_amount:int = 3
var main_dots:Array = []
@export var start_position:Vector2
var old_pos:Vector2
@export var r:float = 0.5
@export var ccspt:bool = false
var last_main_dot = null
var pause:bool = false

#TODO: sim speed
#TODO: slider for smaller dot size
#TODO: change location main dots
#TODO: better hue
#TODO: dot count
#TODO: every possible outcome



# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	
	r = 1-(main_dot_amount/(main_dot_amount+3.0))
	reset(r, main_dot_amount)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if not pause:
		for i in range(10):
			new_small_dot()
	else:
		pass
	
	'''if Input.is_action_pressed("zoom in"):
		zoom = zoom.lerp(zoom*1.3, delta * 4.0)
	elif Input.is_action_pressed("zoom out"):
		zoom = zoom.lerp(zoom*0.7, delta * 4.0)'''

func new_small_dot():
	var random_main_dot_index:int
	var random_main_dot:Sprite2D
	if get_child_count() != 0:
		if not ccspt:
			random_main_dot_index = randf_range(0, len(main_dots))
		else:
			if last_main_dot == null:
				random_main_dot_index = randf_range(0, len(main_dots))
			else:
				random_main_dot_index = randf_range(0, len(main_dots))
				while random_main_dot_index == last_main_dot:
					random_main_dot_index = randf_range(0, len(main_dots))
		
		random_main_dot = main_dots[random_main_dot_index]
		
		var target_location:Vector2 = (old_pos+random_main_dot.position)*r # cannot find a random dot
		
		var small_dot = preload("res://Scenes/smaller_dot.tscn").instantiate()
		add_child(small_dot)
		small_dot.top_level = true
		
		small_dot.position = target_location
		
		var locations:Array
		for main_dot in main_dots:
			locations.append(main_dot.position.distance_to(small_dot.position))
		
		var closest_main_dot = locations.find(locations.min())

		var h = (1.0/main_dot_amount)*closest_main_dot+1.0/main_dot_amount
		small_dot.modulate = Color.from_hsv(h,0.4,1)
		
		old_pos = target_location
		last_main_dot = random_main_dot_index

func reset(r_local, main_dot_amount_local):
	randomize()
	var viewport_size = get_viewport_rect().size
	var radius = viewport_size.y*2
	
	for dot in get_children():
		dot.free()
	main_dots = []
	
	var name_scheme = "MainDot%s" # cool gimick https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_format_string.html
	
	for i in range(main_dot_amount_local):
		var angle = i * PI*2.0 / main_dot_amount_local
		var new_position = Vector2(cos(angle)*radius, sin(angle)*radius)
		var main_dot = preload("res://Scenes/main_dot.tscn").instantiate()
		add_child(main_dot)
		main_dot.position = new_position
		main_dot.name = name_scheme % (i+1)
		main_dot.top_level = true
		main_dots.append(main_dot)
		
	for dot in get_children():
		print("---\nName:%s\nPosition:%s" % [dot.name, dot.position])
	print("---")
	
	print("\n--- Value of r: " + str(r) + "---")
	
	old_pos = start_position
	
	
func _unhandled_input(event):
	if event.is_action_pressed("zoom in"):
		zoom = zoom*1.3
	if event.is_action_pressed("zoom out"):
		zoom = zoom*0.7
	if event is InputEventMouseMotion:
		if event.button_mask == MOUSE_BUTTON_MASK_LEFT:
			position -= event.relative / zoom


func _on_recalculate_r_pressed():
	r = 1-(main_dot_amount/(main_dot_amount+3.0))


func _on_reset_button_pressed():
	reset(r, main_dot_amount)

func _on_ccspt_button_toggled(button_pressed):
	ccspt = button_pressed

func _on_pause_button_pressed():
	pause = not pause

func _on_step_button_pressed():
	new_small_dot()
