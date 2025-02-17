class_name ContentElementText2D extends Control

@onready var label: Label = $Label
@export var font_size: int = 32

var _pixel_ratio = Vector2i(200,200)

func set_content_element(content_element: ContentElementText):
	label.text = str(content_element.text)

func set_content_element_size(size: Vector2i):
	var _pixel_size = size * _pixel_ratio
	size = _pixel_size
	custom_minimum_size = _pixel_size
	label.size = _pixel_size

func set_font_size(size: int):
	font_size = size
	label.add_theme_font_size_override("font_size", size)
