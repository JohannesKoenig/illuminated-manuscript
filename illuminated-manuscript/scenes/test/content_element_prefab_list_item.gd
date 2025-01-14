class_name ContentElementPrefabListItem extends Control

var content_element_prefab: ContentElementPrefab
@onready var button = $Button

# Called when the node enters the scene tree for the first time.
func _ready():
	button.text = content_element_prefab.name



func _on_button_pressed():
	DragAndDropClipboard.selected_content_element_prefab = content_element_prefab
