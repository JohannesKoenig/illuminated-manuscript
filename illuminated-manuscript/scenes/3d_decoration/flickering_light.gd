class_name FlickeringOmniLight3D extends OmniLight3D

@export var flicker_intensity: float = 1
@export var flicker_frequency: float = 0.5
var _flicker_duration: float

var _start_energy: float
var _max_target_energy: float 
var _min_target_energy: float 

var tween: Tween

func _ready():
	_flicker_duration = (1 / flicker_frequency)/3
	_start_energy = light_energy
	_max_target_energy = light_energy * flicker_intensity
	_min_target_energy = light_energy / flicker_intensity
	tween_light()

func tween_light():
	if tween != null:
		tween.kill()
	tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "light_energy", _max_target_energy, _flicker_duration * randf_range(0.8,1.2))
	tween.tween_property(self, "light_energy", _min_target_energy, _flicker_duration * randf_range(0.8,1.2))
	tween.tween_property(self, "light_energy", _start_energy, _flicker_duration * randf_range(0.8,1.2))
	tween.play()
	tween.tween_callback(tween_light)
