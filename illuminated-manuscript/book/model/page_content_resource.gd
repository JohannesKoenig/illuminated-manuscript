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
