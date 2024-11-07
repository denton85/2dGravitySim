extends StaticBody2D

@export var mass: float = 1000.0
# Called when the node enters the scene tree for the first time.
func _init():
	Global.add_to_stars.connect(add_star)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func add_star():
	Global.star_group.append(self)
