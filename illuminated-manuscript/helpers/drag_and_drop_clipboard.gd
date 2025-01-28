extends Node

var selected_content_element_prefab: ContentElementPrefab:
	set(value):
		if selected_content_element_prefab != value:
			selected_content_element_prefab = value
			content_changed.emit(value)
signal content_changed(content: ContentElementPrefab)

func _process(delta):
	if Input.is_action_just_pressed("Cancel_Placement"):
		selected_content_element_prefab = null
