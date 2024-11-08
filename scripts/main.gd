extends Node2D

@onready var camera = $Camera2D
@onready var canvas = $CanvasLayer
@onready var canv_2 = $CanvasLayer/Canv2
@onready var control = $CanvasLayer/Control
@onready var label = $CanvasLayer/Control/Label
@onready var speed = $CanvasLayer/Control/Speed
@onready var start_sim = $CanvasLayer/Control/StartSim
@onready var exit_edit_mode = $CanvasLayer/Control/ExitEditMode
@onready var edit_conditions = $CanvasLayer/Control/EditConditions
@onready var add_star = $CanvasLayer/Control/AddStar
@onready var debug = $Debug
@onready var reset = $CanvasLayer/Control/Reset

const EDIT_STAR = preload("res://ui/edit_star.tscn")
const STAR = preload("res://stars/star.tscn")
const DRAG = preload("res://ui/drag.tscn")

@export var fullscreen: bool = true

var placing_star: bool = false
var current_star = 0
var clearing = false

## Low Limit for intial velocity (across all non custom stars)
@export var STARTING_MIN_VELOCITY: float = 5.0
## High Limit for intial velocity (across all non custom stars)
@export var STARTING_MAX_VELOCITY: float = 25.0


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.toggle_ui.connect(toggle_ui_layer)
	Global.sim_reset.connect(reset_sim)
	Global.star_group_cleared.connect(add_stars_on_reset)
	Global.add_to_stars.emit()
	label.text = str(camera.zoom.x)
	speed.text = str(Engine.time_scale)
	if fullscreen == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

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
		
		if Global.active != true && Global.edit_mode == true:
			clear_edit_ui()
			toggle_ui_layer()
		
	if Input.is_action_just_pressed("zoom_out"):
		camera.zoom.x -= 0.1
		camera.zoom.y -= 0.1
		label.text = str(snappedf(camera.zoom.x, 0.1))
		
		if Global.active != true && Global.edit_mode == true:
			clear_edit_ui()
			toggle_ui_layer()
		
		
	if Input.is_action_just_pressed("switch_view"):
		camera.switched = true
		if current_star < (Global.star_group.size() - 1):
			current_star += 1
			camera.target_star = Global.star_group[current_star]
		elif current_star >= (Global.star_group.size() - 1):
			current_star = 0
			camera.target_star = Global.star_group[current_star]

	if Global.edit_mode == true && Input.is_action_just_pressed("exit_edit"):
		Global.edit_mode = false
		Global.toggle_ui.emit()
		exit_edit_mode.hide()
		add_star.hide()
		start_sim.show()
		edit_conditions.show()
	
	if Global.edit_mode == true:
		var camera_move_x = Input.get_axis("left", "right")
		var camera_move_y = Input.get_axis("up", "down")
		
		camera.position.x += camera_move_x * 10
		camera.position.y += camera_move_y * 10
	
	if Global.edit_mode == true && placing_star == true && Input.is_action_just_pressed("place_star"):
		var mouse_pos = get_global_mouse_position()
		var new_star = STAR.instantiate()
		new_star.global_position = mouse_pos
		add_child(new_star)
		placing_star = false
		Global.clear_stars()
		Global.add_to_stars.emit()
		clear_edit_ui()
		Global.toggle_ui.emit()
	
	if Global.edit_mode == true && Input.is_action_just_pressed("add_star_hotkey"):
		placing_star = true

func _process(delta):
	debug.text = str(Global.active)

func _on_button_pressed():
	get_tree().quit()

func _on_start_sim_pressed():
	Global.active = true
	Global.edit_mode = false
	canvas.follow_viewport_enabled = false
	start_sim.hide()
	edit_conditions.hide()
	reset.show()
	Global.toggle_ui.emit()
	Global.sim_start.emit()

func _on_edit_conditions_pressed():
	Global.edit_mode = true
	Global.toggle_ui.emit()
	start_sim.hide()
	edit_conditions.hide()
	reset.hide()
	exit_edit_mode.show()
	add_star.show()

func toggle_ui_layer():
	clear_edit_ui()
	
	if Global.active == false && Global.edit_mode == true:
		for i in Global.star_group:
			if i != null:
				var edit = EDIT_STAR.instantiate()
				var drag = DRAG.instantiate()
				edit.global_position = i.global_position + Vector2(-100, -180)
				edit.star_id = i
				drag.global_position = i.global_position + Vector2(-35, -35)
				drag.star_id = i
				canv_2.add_child(edit)
				canv_2.add_child(drag)

func clear_edit_ui():
	var c = canv_2.get_children()
	for i in c:
		if i.is_in_group("edit"):
			i.queue_free()

func _on_add_star_pressed():
	add_star.release_focus()
	placing_star = true


func _on_reset_pressed():
	reset.hide()
	Global.sim_reset.emit()

func reset_sim():
	Global.active = false

	for i in get_children():
		if i is Star:
			print("Cleared")
			i.queue_free()

	for i in Global.sim_state:
		var s = STAR.instantiate()
		s.global_position = i.pos
		s.starting_dir = i.dir
		s.c_min = i.vMin
		s.c_max = i.vMax
		s.mass = i.mass
		s.custom_velocity = true
		add_child(s)
	
	clearing = true
	Global.clear_stars()

func add_stars_on_reset():
	if clearing == true:
		Global.add_to_stars.emit()
		Global.clear_sim_state()
		start_sim.show()
		edit_conditions.show()
	clearing = false
