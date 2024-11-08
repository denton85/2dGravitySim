extends Camera2D

var target_star: Node2D
var switched = false

@onready var star_mass = $"../CanvasLayer/Control/StarMass"
@onready var star_speed = $"../CanvasLayer/Control/StarSpeed"

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.cam = self
	Global.sim_start.connect(target_biggest)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.active == false:
		pass
	
	if Global.active == true && !switched && Global.biggest_star != null:
		global_position = Global.biggest_star.global_position
	else:
		if target_star != null:
			global_position = target_star.global_position
	
	if Global.active == true && switched == true && target_star != null:
		star_speed.text = "Speed: " + str(snapped(target_star.current_speed, 0.01))
		star_mass.text = "Mass: " + str(target_star.mass)
		
	elif Global.active == true && !switched && Global.biggest_star != null:
		star_speed.text = "Speed: " + str(snapped(Global.biggest_star.current_speed, 0.01))
		star_mass.text = "Mass: " + str(Global.biggest_star.mass)

func target_biggest():
	pass
	if Global.biggest_star != null:
		target_star = Global.biggest_star
	else:
		for i in Global.star_group:
			if i != null:
				target_star = i
				return
