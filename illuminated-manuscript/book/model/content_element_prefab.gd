class_name ContentElementPrefab extends ContentElement

@export var name: String
@export var size: Vector2i = Vector2i.ONE
@export var texture: Texture2D = preload("res://icon.svg")
@export var income: Dictionary
@export var usage: Dictionary
@export var cost: Dictionary

func format_name()->String:
	var preprocessed = name.replace("content_element_", "")
	return preprocessed.replace("_", " ").capitalize() 
