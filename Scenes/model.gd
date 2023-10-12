extends Camera2D

#@export var radius:int
@export var main_dot_amount:int = 3
var zooming:int
var main_dots = []
@export var start_position:Vector2
var old_pos:Vector2
@export var r:float = 0.5


'''
TODO: reset + sliders, hue, cantchoosesamepointtwice, camera slide or whatever
'''


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	
	r = 1-(main_dot_amount/(main_dot_amount+3.0))
	reset(r, main_dot_amount)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for i in range(20):
		new_small_dot()
	
	if Input.is_action_pressed("zoom in"):
		zoom = zoom.lerp(zoom*1.3, delta * 4.0)
	elif Input.is_action_pressed("zoom out"):
		zoom = zoom.lerp(zoom*0.7, delta * 4.0)

func new_small_dot():
	if get_child_count() == 0:
		pass
	else:
		var random_main_dot = main_dots[randf_range(0, len(main_dots))]
		#print(random_main_dot, main_dots)
		
		var target_location:Vector2 = (old_pos+random_main_dot.position)*r # cannot find a random dot
		
		var small_dot = preload("res://Scenes/smaller_dot.tscn").instantiate()
		add_child(small_dot)
		small_dot.position = target_location
		old_pos = target_location

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
		main_dots.append(main_dot)
		
	for dot in get_children():
		print("---\nName:%s\nPosition:%s" % [dot.name, dot.position])
	print("---")
	
	print("\n--- Value of r: " + str(r) + "---")
	
	old_pos = start_position
	


func _on_recalculate_r_pressed():
	r = 1-(main_dot_amount/(main_dot_amount+3.0))


func _on_reset_button_pressed():
	reset(r, main_dot_amount)
