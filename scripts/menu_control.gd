extends Node

onready var grid = get_parent().get_node("voxel_grid")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta):
	grid.transform = grid.transform.rotated(Vector3.UP, 0.0005)
	grid.transform = grid.transform.rotated(Vector3.RIGHT, 0.001)

func _input(event):
	if event.is_action_pressed("BEGIN"):
		get_tree().change_scene("res://scenes/main_voxel.tscn")
	if event.is_action_pressed("LEAVE"):
		get_tree().quit()
		
func animation():
	var blocks = grid.get_children()
	for n in blocks.size():
#		blocks[n].rotate or translate
		pass
