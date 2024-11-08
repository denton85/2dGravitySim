extends Button

var star_id: CharacterBody2D
var dragging = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if dragging == true:
		global_position = get_global_mouse_position() + Vector2(-35, -35)
		star_id.global_position = global_position + Vector2(35, 35)


func _on_button_down():
	dragging = true


func _on_button_up():
	dragging = false
	Global.toggle_ui.emit()
