@tool
extends Line2D

@onready var star = $".."

func _process(delta):
	if star.custom_velocity == true:
		points[1].x = star.c_dir.x * 40
		points[1].y = star.c_dir.y * 40
	
