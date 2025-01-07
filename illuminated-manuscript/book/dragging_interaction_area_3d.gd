extends Area3D

var _mouse_inside: bool = false
var _is_dragging: bool = false
var target_offset: Vector3:
	set(value):
		if value != target_offset:
			target_offset = value
			on_target_offset_changed.emit(target_offset)

signal on_target_offset_changed(target_offset: Vector3)
var start_position: Vector3


# Called when the node enters the scene tree for the first time.
func _ready():
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if _mouse_inside:
		if Input.is_action_just_pressed("click"):
			_on_mouse_start_press()
	if _is_dragging:
		if Input.is_action_pressed("click"):
			_on_mouse_down()
		if Input.is_action_just_released("click"):
			_on_mouse_up()

func _on_mouse_entered():
	_mouse_inside = true

func _on_mouse_exited():
	_mouse_inside = false

func get_mouse_position_3D(viewport: Viewport):
	var camera = viewport.get_camera_3d()
	return camera.project_ray_normal(viewport.get_mouse_position())

func _on_mouse_start_press():
	start_position = get_mouse_position_3D(get_viewport())
	_is_dragging = true

func _on_mouse_down():
	var current_position = get_mouse_position_3D(get_viewport())
	target_offset = current_position - start_position 

func _on_mouse_up():
	target_offset = Vector3.ZERO
	_is_dragging = false
	
