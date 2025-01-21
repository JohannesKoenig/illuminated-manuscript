class_name GuiTooltip extends Control


var content_element_prefab: ContentElementPrefab
var gui_resource_element: PackedScene = preload("res://ui/gui_resource_element.tscn")

@onready var h_box_container = $VBoxContainer/HBoxContainer
@onready var label = $VBoxContainer/Label

# Called when the node enters the scene tree for the first time.
func _ready():
	if content_element_prefab == null:
		return
	label.text = _format_label_text(content_element_prefab.name)
	var costs = content_element_prefab.cost
	for key in costs:
		var value = costs[key]
		var gui_resource_element_instance: GuiResourceElement = gui_resource_element.instantiate()
		gui_resource_element_instance.resource_name = key
		gui_resource_element_instance.resource_count = value
		h_box_container.add_child(gui_resource_element_instance)
	#print(size)
	#custom_minimum_size = size
		

func _format_label_text(label_text: String) -> String:
	var formatted = label_text.replace("content_element_", "").replace("_", " ")
	formatted = formatted.capitalize()
	return formatted
