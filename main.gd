extends Node2D

@onready var camera = $Camera2D
@onready var label = $Camera2D/CanvasLayer/Control/Label
@onready var speed = $Camera2D/CanvasLayer/Control/Speed

var current_star = 0

@export var STARTING_MIN_VELOCITY: float = 5.0
@export var STARTING_MAX_VELOCITY: float = 25.0


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.add_to_stars.emit()
	label.text = str(camera.zoom.x)
	speed.text = str(Engine.time_scale)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
		

func _unhandled_input(event):
	if Input.is_action_just_pressed("speed_up"):
		if Engine.time_scale < 5.0:
			Engine.time_scale += 0.1
			speed.text = str(Engine.time_scale)
	if Input.is_action_just_pressed("speed_down"):
		if Engine.time_scale > 0.1:
			Engine.time_scale -= 0.1
			speed.text = str(Engine.time_scale)
			
	if Input.is_action_just_pressed("zoom_in"):
		camera.zoom.x += 0.1
		camera.zoom.y += 0.1
		label.text = str(snappedf(camera.zoom.x, 0.1))
		
	if Input.is_action_just_pressed("zoom_out"):
		camera.zoom.x -= 0.1
		camera.zoom.y -= 0.1
		
	if Input.is_action_just_pressed("switch_view"):
		camera.switched = true
		if current_star < (Global.star_group.size() - 1):
			current_star += 1
			camera.target_star = Global.star_group[current_star]
		elif current_star >= (Global.star_group.size() - 1):
			current_star = 0
			camera.target_star = Global.star_group[current_star]

func _on_button_pressed():
	get_tree().quit()
