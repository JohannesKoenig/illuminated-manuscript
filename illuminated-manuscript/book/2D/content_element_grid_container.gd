class_name ContentElementGridContainer extends Control

var _content_elements: Array2D
var content_element_text_2d_packed_scene: PackedScene = preload("res://book/2D/content_element_text_2d.tscn")
var content_element_texture_2d_packed_scene: PackedScene = preload("res://book/2D/content_element_texture_2d.tscn")
var content_element_empty_2d_packed_scene: PackedScene = preload("res://book/2D/content_element_empty_2d.tscn")
var content_element_blocked_2d_packed_scene: PackedScene = preload("res://book/2D/content_element_blocked_2d.tscn")

func set_content_elements(content_elements: Array2D):
	var blocked_x_indices = {}
	var blocked_y_indices = {}

	self._content_elements = content_elements
	for i in range(content_elements.get_width()):
		for j in range(content_elements.get_height()):
			if blocked_x_indices.has(i) and blocked_y_indices.has(j):
				continue
			var content_element = content_elements.get_value(i, j)
			if content_element is ContentElementText:
				var element_2d = content_element_text_2d_packed_scene.instantiate() as ContentElementText2D
				add_child(element_2d)
				element_2d.set_content_element_size(content_element.size)
				element_2d.position = Vector2(200 * j, 200 * i)
				element_2d.set_content_element(content_element)
				if content_element.size != Vector2i.ONE:
					for _i in range(content_element.size.x):
						for _j in range(content_element.size.y):
							blocked_x_indices[i + _i] = true
							blocked_y_indices[j + _j] = true
			if content_element is ContentElementTexture:
				var texture = content_element.texture
				var element_2d = content_element_texture_2d_packed_scene.instantiate() as ContentElementTexture2D
				add_child(element_2d)
				element_2d.set_content_element_size(content_element.size)
				element_2d.position = Vector2(200 * i, 200 * j)
				element_2d.set_content_element(content_element)
				if content_element.size != Vector2i.ONE:
					for _i in range(content_element.size.x):
						for _j in range(content_element.size.y):
							blocked_x_indices[i + _i] = true
							blocked_y_indices[j + _j] = true
			
func _add_blocked_element(x: int , y: int):
	var element_2d = content_element_blocked_2d_packed_scene.instantiate()
	add_child(element_2d)
	element_2d.position = Vector2(200 * y, 200 * x)
