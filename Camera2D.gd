extends Camera2D

var target_star: Node2D
var switched = false

@onready var star_speed = $CanvasLayer/Control/StarSpeed

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !switched:
		global_position = Global.biggest_star.global_position
	else:
		if target_star != null:
			global_position = target_star.global_position
	
	if switched == true && target_star != null:
		star_speed.text = str(snapped(target_star.current_speed, 0.01))
	else:
		star_speed.text = str(snapped(Global.biggest_star.current_speed, 0.01))
