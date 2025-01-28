@tool
class_name PageContentResource extends Resource

var border #: Border
var marker #: Marker
@export var page_number: int
@export var content_elements: ContentElementGrid = ContentElementGrid.new()
signal content_updated

func is_left() -> bool:
	return page_number % 2 == 1

func set_content_element(x: int, y: int, content_element: ContentElement):
	content_elements.set_content_element(x, y, content_element)
	content_updated.emit()

func can_build(x: int, y:int, content_element: ContentElementPrefab) -> bool:
	for i in range(content_element.size.x):
		for j in range(content_element.size.y):
			if !content_elements.is_valid_index(x+i, y+j):
				return false
	return true
	
