extends CharacterBody2D

@export var mass: float = 1000.0
@onready var label = $MassLabel
@onready var eat = $Eat

var starting_dir = Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0)) * randf_range(5.0, 15.0)

func _init():
	Global.add_to_stars.connect(add_star)
	velocity = starting_dir

func _ready():
	label.text = str(mass)

func _physics_process(delta):
	var dir = Vector2.ZERO
	var velos : Array[Vector2]
	label.text = str(mass)
	
	
	for i in Global.star_group:
		if i == self:
			continue
		else:
			dir = i.global_position - self.global_position
			var v = (dir.normalized() * i.mass) / pow(global_position.distance_to(i.global_position), 2)
			
			velos.append(v)
	
	var final_dir = Vector2.ZERO
	for i in velos:
		final_dir = i + final_dir
	
	velocity = velocity + (final_dir)
	
	move_and_slide()


func add_star():
	Global.star_group.append(self)


func _on_eat_body_entered(body):
	if body == self:
		return
	if body.mass > self.mass:
		body.mass += self.mass
		die()
	elif body.mass == self.mass:
		body.mass += self.mass
		die()
	else:
		pass

func die():
	Global.star_group.erase(self)
	queue_free()
	
