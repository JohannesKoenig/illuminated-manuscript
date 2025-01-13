class_name ContentElementTexture2D extends Control

@onready var texture_rect: TextureRect = $TextureRect
var _pixel_ratio = Vector2i(200,200)
var margin: float = 20

func set_content_element(content_element: ContentElementTexture):
	texture_rect.texture = content_element.texture


func set_content_element_size(size: Vector2i):
	var _pixel_size = size * _pixel_ratio
	size = _pixel_size
	custom_minimum_size = _pixel_size
	texture_rect.size = _pixel_size
