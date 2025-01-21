class_name ContentElementPrefabListItem extends Control

var content_element_prefab: ContentElementPrefab
@onready var button = $Button

# Called when the node enters the scene tree for the first time.
func _ready():
	button.text = _format_label_text(content_element_prefab.name)
	button.content_element_prefab = content_element_prefab

func _on_button_pressed():
	DragAndDropClipboard.selected_content_element_prefab = content_element_prefab

func _format_label_text(label_text: String) -> String:
	var formatted = label_text.replace("content_element_", "").replace("_", " ")
	formatted = formatted.capitalize()
	return formatted
