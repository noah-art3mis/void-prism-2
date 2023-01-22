extends RayCast

onready var exceptions
onready var MOVE_DISTANCE = 4
onready var self_detector = $self_detector


func _ready():
	exceptions = get_exceptions()
	add_exceptions(exceptions)

func add_exceptions(array):
	for i in array.size():
		add_exception(array[i])		

func get_exceptions():
	var array = []
	var children = get_parent().get_children() 
	for i in children.size():
		var mesh = children[i]
		var body = mesh.get_child(0)
		array.append(body)
	return array
	
func matches(axis:Vector3) -> bool:
	cast_to = axis * MOVE_DISTANCE
	self_detector.cast_to = axis
	#Debug.draw_line(global_translation, cast_to)

	force_raycast_update()
	self_detector.force_raycast_update()
	var me = self_detector.get_collider()
	var other = get_collider()
	
	if other == null:
		print("3: no target; moving")	
		print("")
		return true
	else:
		var material_me = me.get_parent().get_active_material(0)
		var material_other = other.get_parent().get_active_material(0)
	
		if material_me == material_other:
			print("1: color match")
			print("")
			return true
		else:
			print("2: no match")
			print("")
			return false
		
		
onready var t = 0
func _process(_delta):
	t = t + 1
	if t % 10 == 0:
		#print(is_colliding())
		pass

