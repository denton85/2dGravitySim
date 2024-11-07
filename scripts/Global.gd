extends Node

signal add_to_stars
signal toggle_ui

var active: bool = false
var edit_mode: bool = false

var star_group: Array = []
var biggest_star: Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func clear_stars():
	star_group.clear()
	biggest_star = null
