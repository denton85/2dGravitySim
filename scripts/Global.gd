extends Node

signal add_to_stars
signal toggle_ui
signal sim_start
signal sim_reset

var active: bool = false
var edit_mode: bool = false

var cam = Camera2D

var star_group: Array = []
var biggest_star: Node2D

var sim_state: Array = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func clear_stars():
	#star_group.clear()
	star_group = []
	biggest_star = null

func clear_sim_state():
	sim_state = []
	#sim_state.clear()
