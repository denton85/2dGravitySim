extends Control

@onready var velocity = $Velocity
@onready var range = $Range
@onready var v_label = $VLabel
@onready var r_label = $RLabel

var star_id: CharacterBody2D
# Called when the node enters the scene tree for the first time.
func _ready():
	v_label.text = "Velocity: " + str(star_id.c_min)
	r_label.text = "Velocity: " + str(star_id.c_min)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	v_label.text = "Velocity: " + str(star_id.c_max)

func _on_check_button_pressed():
	star_id.custom_velocity = true
	velocity.visible = !velocity.visible
	range.visible = !range.visible
	v_label.visible = !v_label.visible
	r_label.visible = !r_label.visible


func _on_velocity_drag_ended(value_changed):
	star_id.c_min = velocity.value
	star_id.c_max = velocity.value
	star_id.add_custom_velo()


func _on_range_drag_ended(value_changed):
	pass
