extends Spatial

onready var camera_raycast = get_parent().get_node("3dCC/UpperCollider/Camera/RayCast")
onready var detector = get_parent().get_node("detector")

func _input(event):
	if camera_raycast.is_colliding():
		var target = camera_raycast.get_collider().get_parent().get_parent()
		detector.set_target(target)
		
		if event.is_action_pressed("rotate_x"):
			target.rotate_block(Vector3.RIGHT)
		if event.is_action_pressed("rotate_y"):
			target.rotate_block(Vector3.UP)
		if event.is_action_pressed("rotate_z"):
			target.rotate_block(Vector3.BACK)
			
		if event.is_action_pressed("translate_right"):
			target.translate_block(Vector3.RIGHT)
		if event.is_action_pressed("translate_left"):
			target.translate_block(Vector3.LEFT)
		if event.is_action_pressed("translate_up"):
			target.translate_block(Vector3.UP)
		if event.is_action_pressed("translate_down"):
			target.translate_block(Vector3.DOWN)
