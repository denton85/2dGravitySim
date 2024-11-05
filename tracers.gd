class_name Trail
extends Line2D

const MAX_POINTS: int = 500
@onready var curve := Curve2D.new()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	curve.add_point(get_parent().global_position)
	if curve.get_baked_points().size() > MAX_POINTS:
		curve.remove_point(0)
	
	points = curve.get_baked_points()
