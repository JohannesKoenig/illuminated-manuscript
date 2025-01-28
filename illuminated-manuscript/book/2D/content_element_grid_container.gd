class_name ContentElementGridContainer extends Control

var _content_elements: Array2D
var _content_element_group_2ds: Array2D
var content_element_text_2d_packed_scene: PackedScene = preload("res://book/2D/content_element_text_2d.tscn")
var content_element_texture_2d_packed_scene: PackedScene = preload("res://book/2D/content_element_texture_2d.tscn")
var content_element_empty_2d_packed_scene: PackedScene = preload("res://book/2D/content_element_empty_2d.tscn")
var content_element_blocked_2d_packed_scene: PackedScene = preload("res://book/2D/content_element_blocked_2d.tscn")
var blocked_indices  = {}
var margin: float = 0


func set_content_elements(content_elements: Array2D):
	if _content_element_group_2ds == null:
		_content_element_group_2ds = Array2D.create(content_elements.get_width(), content_elements.get_height())

	
	for child in get_children():
		child.queue_free()
	_content_element_group_2ds.clear()

	self._content_elements = content_elements
	for i in range(content_elements.get_width()):
		for j in range(content_elements.get_height()):
			#if blocked_indices.has(Vector2(i,j)):
			#	continue
			var content_element = content_elements.get_value(i, j)
			if content_element is ContentElementText:
				var element_2d = content_element_text_2d_packed_scene.instantiate() as ContentElementText2D
				add_child(element_2d)
				_content_element_group_2ds.put_value(i,j,element_2d)
				element_2d.set_content_element_size(content_element.size)
				element_2d.set_font_size(content_element.font_size)
		
				element_2d.position = Vector2((200 + margin) * i, (200 + margin) * j)
				element_2d.set_content_element(content_element)
				
				for _i in range(content_element.size.x):
					for _j in range(content_element.size.y):
						blocked_indices[Vector2(i+_i,j+_j)] = true
			elif content_element is ContentElementTexture:
				var texture = content_element.texture
				var element_2d = content_element_texture_2d_packed_scene.instantiate() as ContentElementTexture2D
				add_child(element_2d)
				_content_element_group_2ds.put_value(i,j,element_2d)
				element_2d.set_content_element_size(content_element.size)
				element_2d.position = Vector2((200+ margin) * i, (200+margin) * j)
				element_2d.set_content_element(content_element)
		
				for _i in range(content_element.size.x):
					for _j in range(content_element.size.y):
						blocked_indices[Vector2(i+_i,j+_j)] = true
			elif content_element is ContentElementPrefab:
				var prefab_name = content_element.name
				if prefab_name == "content_element_resource_overview":
					var prefab_packed_scene: PackedScene = load("res://book/2D/prefab_content_elements/" + prefab_name + ".tscn")
					var prefab_instance: ContentElementGroup2D = prefab_packed_scene.instantiate()
					prefab_instance.content_element_prefab_resource = content_element
					add_child(prefab_instance)
					_content_element_group_2ds.put_value(i,j,prefab_instance)
					prefab_instance.position = Vector2((200+ margin) * i, (200+margin) * j)
					
					for _i in range(content_element.size.x):
						for _j in range(content_element.size.y):
							blocked_indices[Vector2(i+_i,j+_j)] = true
				else:
					#var prefab_packed_scene: PackedScene = load("res://book/2D/prefab_content_elements/" + prefab_name + ".tscn")
					var group2d_packed_scene: PackedScene = load("res://book/2D/content_element_group_2d.tscn")
					#var prefab_instance: ContentElementGroup2D = prefab_packed_scene.instantiate()
					var prefab_instance: ContentElementGroup2D = group2d_packed_scene.instantiate()
					prefab_instance.content_element_prefab_resource = content_element
					add_child(prefab_instance)
					_content_element_group_2ds.put_value(i,j,prefab_instance)
					prefab_instance.position = Vector2((200+ margin) * i, (200+margin) * j)

					for _i in range(content_element.size.x):
						for _j in range(content_element.size.y):
							blocked_indices[Vector2(i+_i,j+_j)] = true
			

func _get_blocked_element(x: int , y: int) -> ContentElementBlocked2D:
	var element_2d = content_element_blocked_2d_packed_scene.instantiate()
	element_2d.position = Vector2(200 * x, 200 * y)
	return element_2d
