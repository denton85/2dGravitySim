extends CharacterBody2D


@onready var label = $MassLabel
@onready var eat = $Eat


@export var mass: float = 1000.0
@export var custom_velocity: bool = false # This enables custom initial velocities
## Radius around the stars within which gravity is turned off (to stop stars from speeding up each time they eat another star)
@export var buffer: float = 16

@onready var indicator = $DirectionIndicator

@export_group("Custom Initial Direction")

## Starting X and Y Direction (usually use values from -1.0 to 1.0. A line will show in the editor to indicate the direction when you adjust this.) - Note "Custom Velocity" must be enabled for these to work.
@export var c_dir: Vector2 = Vector2(0.0, 1.0)
## Low Limit of Starting Velocity - Note "Custom Velocity" must be enabled for these to work.
@export var c_min: float = 5.0 
## High Limit of Starting Velocity - Note "Custom Velocity" must be enabled for these to work.
@export var c_max: float = 15.0 

var starting_dir = Vector2.ZERO
var old_pos = Vector2.ZERO
var current_speed: float

func _init():
	Global.add_to_stars.connect(add_star)
	Global.toggle_ui.connect(toggle_ui_elements)

func _ready():
	label.text = str(mass)
	if custom_velocity == false:
		starting_dir = Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0)) * randf_range(get_parent().STARTING_MIN_VELOCITY, get_parent().STARTING_MAX_VELOCITY)
		velocity = starting_dir
	else:
		add_custom_velo()
	
func _physics_process(delta):
	label.text = str(mass)
	
	if not Engine.is_editor_hint():
		indicator.visible = false

	if Global.active == false:
		return
	
	var dir = Vector2.ZERO
	var velos : Array[Vector2]
	
	
	for i in Global.star_group:
		if i == self:
			continue
		else:
			dir = i.global_position - self.global_position
			# A small buffer zone to keep stars from increasing velocity really 
			# fast when they eat another star. Might need to be adjusted.
			if global_position.distance_to(i.global_position) >= buffer:
				var v = (dir.normalized() * i.mass) / pow(global_position.distance_to(i.global_position), 2)
				velos.append(v)
	
	var final_dir = Vector2.ZERO
	for i in velos:
		final_dir = i + final_dir
		
	current_speed = (global_position.distance_to(old_pos)) / delta
	
	velocity = velocity + (final_dir)
	
	old_pos = global_position
	move_and_slide()


func add_star():
	for i in Global.star_group:
		if i.mass > self.mass:
			Global.star_group.append(self)
			return
	Global.biggest_star = self
	Global.star_group.append(self)


func _on_eat_body_entered(body):
	if body == self:
		return
	if body.mass > self.mass:
		body.mass += self.mass
		die()
	elif body.mass == self.mass:
		body.mass += self.mass
		die()
	else:
		pass

func die():
	Global.star_group.erase(self)
	queue_free()
	
func toggle_ui_elements():
	if Global.active != true:
		pass
	else:
		pass

func add_custom_velo():
	starting_dir = (c_dir.normalized() * randf_range(c_min, c_max))
	velocity = starting_dir