class_name GuiTooltip extends Control


var content_element_prefab: ContentElementPrefab
var gui_resource_element: PackedScene = preload("res://ui/gui_resource_element.tscn")
@onready var costs_container = $VBoxContainer/HBoxContainer/CostsContainer
@onready var income_container = $VBoxContainer/HBoxContainer2/IncomeContainer
@onready var usage_container = $VBoxContainer/HBoxContainer3/UsageContainer

@onready var label = $VBoxContainer/Label

# Called when the node enters the scene tree for the first time.
func _ready():
	set_content_element_prefab(content_element_prefab)
		

func _format_label_text(label_text: String) -> String:
	var formatted = label_text.replace("content_element_", "").replace("_", " ")
	formatted = formatted.capitalize()
	return formatted

func set_content_element_prefab(element: ContentElementPrefab):
	content_element_prefab = element
	if content_element_prefab == null:
		return
	label.text = _format_label_text(content_element_prefab.name)

	generate_gui_resource_elements(content_element_prefab.cost, costs_container)
	generate_gui_resource_elements(content_element_prefab.income, income_container)
	generate_gui_resource_elements(content_element_prefab.usage, usage_container)


func generate_gui_resource_elements(source: Dictionary, target: Control):
	for child in target.get_children():
		child.queue_free()
	for key in source:
		var value = source[key]
		var gui_resource_element_instance: GuiResourceElement = gui_resource_element.instantiate()
		gui_resource_element_instance.resource_name = key
		gui_resource_element_instance.resource_count = value
		target.add_child(gui_resource_element_instance)
