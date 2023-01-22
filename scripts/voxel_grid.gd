extends Spatial

export(int, 3, 5) var SIZE = 5
onready var cube = preload("res://scenes/cube_divided.tscn")
onready var array = []
export(int) var grid_space = 2
export(int) var grid_fill = 3

func _ready():
	randomize()
	make_array()

func make_array():
	array = []
	for x in SIZE:
		var row = []
		for y in SIZE:
			var column = []
			for z in SIZE:
				var cell = cube.instance()
				if (randi() % grid_fill == 1):
					self.add_child(cell)
					var position = Vector3(grid_space * x + 1.5,
								   grid_space * y + 1.5,
								   grid_space * z + 1.5)
					cell.transform = cell.transform.translated(position)
					random_rotation(cell)
				column.append(cell)
			row.append(column)
		array.append(row)


func random_rotation(obj):
	obj.rotate_object_local(Vector3(1, 0, 0), PI/2 * (randi() % 4))
	obj.rotate_object_local(Vector3(0, 1, 0), PI/2 * (randi() % 4))
	obj.rotate_object_local(Vector3(0, 0, 1), PI/2 * (randi() % 4))
		
		
func find_next_cell() -> Spatial:
	var cell = null
	while (cell == null):
		var x = randi() % 4
		var y = randi() % 4
		var z = randi() % 4
		if array[x][y][z].is_visible_in_tree():
			cell = array[x][y][z]
	return cell
