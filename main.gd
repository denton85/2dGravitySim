extends Node2D

@onready var camera = $Camera2D
@onready var label = $Camera2D/CanvasLayer/Control/Label

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.add_to_stars.emit()
	label.text = str(camera.zoom.x)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("zoom_in"):
		camera.zoom.x -= 0.1
		camera.zoom.y -= 0.1
		label.text = str(snappedf(camera.zoom.x, 0.1))
		
	if Input.is_action_just_pressed("zoom_out"):
		camera.zoom.x += 0.1
		camera.zoom.y += 0.1
		label.text = str(snappedf(camera.zoom.x, 0.1))
		


func _on_button_pressed():
	get_tree().quit()
