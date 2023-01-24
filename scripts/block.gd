extends Spatial

enum {BREAK, FIT}
onready var audio_state
onready var tween = get_node("Tween")
onready var MOVE_DISTANCE = 4

func rotate_block(axis):
	if _is_not_moving(tween):
		var current = transform
		var target = transform.rotated(axis, PI/2)
		tween.interpolate_property(self, "transform", current, target,
				0.5,	Tween.TRANS_SINE, Tween.EASE_IN_OUT)
		tween.start()
		print("rotated ", self.name, " by ", axis)
		$RotationAudio.play()
		
func translate_block(axis):
	if $detector.matches(axis):
		move_and_fit(axis)
	else:
		move_and_break(axis)

func move_and_fit(axis):
	if _is_not_moving(tween):
		var current  = global_translation
		var target = global_translation + axis * MOVE_DISTANCE
		tween.interpolate_property(self, "global_translation", current, target,
				0.5,	Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
		tween.start()
		$TranslationAudio.play()
		audio_state = FIT
		
func move_and_break(axis):
	if _is_not_moving(tween):
		var current  = global_translation
		var target = global_translation + axis * MOVE_DISTANCE
		tween.interpolate_property(self, "global_translation", current, target,
				0.5,	Tween.TRANS_CIRC, Tween.EASE_IN)
		tween.start()
		$TranslationAudio.play()
		audio_state = FIT
		

func _on_Tween_tween_completed(object, key):
	if audio_state == BREAK:
		$BreakAudio.play()
		audio_state = null
	if audio_state == FIT:
		$FitAudio.play()
		audio_state = null

func _is_not_moving(tween):
	return !tween.get_runtime() > 0
