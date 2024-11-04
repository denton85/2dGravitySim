extends Camera2D

var target_star: Node2D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position = Global.biggest_star.global_position
