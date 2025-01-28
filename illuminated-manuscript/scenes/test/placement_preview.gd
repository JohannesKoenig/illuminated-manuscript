class_name PlacementPreview extends Control

@onready var background = $Background
@onready var image = $Image

var _content_element: ContentElementPrefab

func _ready():
	DragAndDropClipboard.content_changed.connect(set_content_element_prefab)

func _process(delta):
	position = get_viewport().get_mouse_position()

func set_content_element_prefab(element: ContentElementPrefab):
	self._content_element = element
	if element == null:
		visible = false
		return
	visible = true
	var pixel_size = Vector2(element.size) * Vector2(200, 200)
	size = pixel_size / 2
	background.size = pixel_size / 2
	image.size = pixel_size / 2
	image.position = Vector2(0, (pixel_size.y - element.texture.get_height()) / 2)
	image.texture = element.texture
	image.scale = Vector2(0.5,0.5)
	
