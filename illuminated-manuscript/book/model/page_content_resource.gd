class_name PageContentResource extends Resource

var border #: Border
var marker #: Marker
@export var page_number: int
@export var content_elements: ContentElementGrid

func is_left() -> bool:
	return page_number % 2 == 1
