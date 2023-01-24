extends Node

onready var menu_state = true
onready var camera = $MenuCamera
onready var tween = get_node("MenuCamera/Tween")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _input(event):
	if menu_state == true:
		if event.is_action_pressed("BEGIN"):
			begin()
			menu_state = false
			$HUD.visible = false
	if event.is_action_pressed("click"):
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta):
	if menu_state == true:
		camera.transform = camera.transform.rotated(Vector3.UP, 0.000025)
		camera.transform = camera.transform.rotated(Vector3.BACK, 0.000025)
		camera.transform = camera.transform.rotated(Vector3.RIGHT, 0.0005)

func begin():
	var target = get_parent().get_node("3dCC").get_node("UpperCollider").get_node("Camera")
	tween.interpolate_property(camera, "global_transform", camera.global_transform, target.global_transform,
			1,	Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()

func _on_Tween_tween_completed(object, key):
	camera.current = false
