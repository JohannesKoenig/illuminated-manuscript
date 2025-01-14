@tool
class_name ContentElementGrid extends Resource

@export var grid: Array2D = Array2D.create(4, 7)

func set_content_element(x: int, y: int, content_element: ContentElement):
	grid.put_value(x, y, content_element)
