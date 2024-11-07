extends Control

@onready var velocity = $Velocity
@onready var range = $Range
@onready var mass = $Mass

@onready var v_label = $VLabel
@onready var r_label = $RLabel
@onready var m_label = $MLabel

var star_id: CharacterBody2D
# Called when the node enters the scene tree for the first time.
func _ready():
	v_label.text = "Velocity: " + str(star_id.c_min)
	r_label.text = "Randomness: " + str(star_id.c_min)
	m_label.text = "Mass: " + str(star_id.mass)
	velocity.value = (star_id.c_min + star_id.c_max) / 2
	mass.value = star_id.mass
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	v_label.text = "Velocity: " + str(star_id.c_max)
	m_label.text = "Mass: " + str(star_id.mass)

func _on_check_button_pressed():
	star_id.custom_velocity = true
	velocity.visible = !velocity.visible
	range.visible = !range.visible
	mass.visible = !mass.visible
	v_label.visible = !v_label.visible
	r_label.visible = !r_label.visible
	m_label.visible = !m_label.visible
	


func _on_velocity_drag_ended(value_changed):
	star_id.c_min = velocity.value
	star_id.c_max = velocity.value
	star_id.add_custom_velo()


func _on_range_drag_ended(value_changed):
	pass


func _on_mass_drag_ended(value_changed):
	star_id.mass = mass.value
