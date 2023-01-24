extends Spatial

onready var raycast = get_parent().get_node("UpperCollider/Camera/RayCast")
onready var tween_good = get_node("TweenGood")
onready var tween_bad = get_node("TweenBad")
onready var tween_rotate = get_node("TweenRotate")
onready var MOVE_DISTANCE = 4

func _input(event):
	if raycast.is_colliding():
		if event.is_action_pressed("rotate_x"):
			rotate_cube(Vector3.RIGHT)
		if event.is_action_pressed("rotate_y"):
			rotate_cube(Vector3.UP)
		if event.is_action_pressed("rotate_z"):
			rotate_cube(Vector3.BACK)
		if event.is_action_pressed("translate_right"):
			translate_cube(Vector3.RIGHT)
		if event.is_action_pressed("translate_left"):
			translate_cube(Vector3.LEFT)
		if event.is_action_pressed("translate_up"):
			translate_cube(Vector3.UP)
		if event.is_action_pressed("translate_down"):
			translate_cube(Vector3.DOWN)
			

func rotate_cube(axis:Vector3):
	if tween_bad.get_runtime() > 0 or tween_good.get_runtime() > 0:
		pass
	else:
		var normal = raycast.get_collision_normal()
		var cube = raycast.get_collider().get_parent().get_parent()
		var pos = cube.global_rotation
		var target = cube.global_rotation + normal * PI/2
		tween_rotate.interpolate_property(cube, "global_rotation", pos, target,
				0.5,	Tween.TRANS_SINE, Tween.EASE_IN_OUT)
		tween_rotate.start()
		print("rotated " + cube.name + "with ", normal)
		$AudioRotate.play()
		
		
func translate_cube(axis):
	var cube : Spatial = raycast.get_collider().get_parent().get_parent()
	if cube.get_node("detector").matches(axis):
		move(tween_good, cube, axis)
	else:
		move(tween_bad, cube, axis)

func move(tween, cube, axis):
	if !tween.get_runtime() > 0:
		var pos = cube.global_translation
		var target = cube.global_translation + axis * MOVE_DISTANCE
	#	var target = pos - cube.detector.last_detected.global_translation
		tween.interpolate_property(cube, "global_translation", pos, target,
				0.5,	Tween.TRANS_CIRC, Tween.EASE_IN)
		tween.start()
		$AudioMove.play()


func _on_TweenGood_tween_completed(_object, _key):
	$AudioGood.play()
	pass

func _on_TweenBad_tween_completed(object, _key):
	$AudioBad.play()
	explode(object)
	
func explode(obj):
	obj.queue_free()
