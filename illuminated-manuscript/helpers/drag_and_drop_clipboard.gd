extends Node

var selected_content_element_prefab: ContentElementPrefab

func _process(delta):
	if Input.is_action_just_pressed("Cancel_Placement"):
		selected_content_element_prefab = null
