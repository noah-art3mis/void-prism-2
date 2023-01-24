extends RayCast

onready var exceptions
onready var MOVE_DISTANCE = 4
onready var self_detector = $self_detector

func set_target(target):
	transform = transform.translated(target.translation)
	set_exceptions(target)
	cast_to = Vector3.ZERO
	
func set_exceptions(target:Spatial):
	clear_exceptions()
	exceptions = get_exceptions(target)
	for i in exceptions.size():
		add_exception(exceptions[i])

func get_exceptions(target): #can maybe remove the new array and just overwrite old one
	var array = []
	var children = target.get_children()
	for i in children.size():
		var mesh = children[i]
		var body = mesh.get_child(0)
		array.append(body)
	return array

	
func matches(axis:Vector3) -> bool:
	cast_to = axis * MOVE_DISTANCE
	force_raycast_update()
	var other = get_collider()
	
	self_detector.cast_to = axis ## if this is local it will rotate twice and cause issues
	self_detector.force_raycast_update()
	var me = self_detector.get_collider()
	
	Debug.draw_line(transform.origin, cast_to)
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

