extends Node

var last_mouse_position: Vector2
var mouse_last_moved: float
var mouse_delay: float = 1
var show_tooltip: bool = false:
	set(value):
		if value != show_tooltip:
			show_tooltip = value
			show_tooltip_changed.emit(value)
signal show_tooltip_changed(value: bool)

func _process(delta):
	var now = Time.get_unix_time_from_system()
	var mouse_position = get_viewport().get_mouse_position()
	if last_mouse_position != mouse_position:
		mouse_last_moved = now
		last_mouse_position = mouse_position
	if now - mouse_last_moved > mouse_delay:
		show_tooltip = true
	else:
		show_tooltip = false
	 

var content_element_prefab: ContentElementPrefab:
	set(value):
		if content_element_prefab != value:
			content_element_prefab = value
			content_element_prefab_changed.emit(value)
signal content_element_prefab_changed(content_element_prefab: ContentElementPrefab)
