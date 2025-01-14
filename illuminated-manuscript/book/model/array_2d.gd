class_name Array2D extends Resource

@export var _content: Array
@export var _x: int
@export var _y: int
signal array_content_updated

static func create(x: int, y: int) -> Array2D:
	var array_2d = Array2D.new()
	array_2d.initialize(x, y)
	return array_2d

func initialize(x: int, y: int):
	assert(_content.is_empty(), "Array2D has to be empty.")
	self._x = x
	self._y = y
	self._content.resize(x * y)
	self._content.fill(null)

func put_value(x: int, y: int, value):
	self._content[x * self._x + y] = value
	array_content_updated.emit()

func get_value(x: int, y: int):
	return self._content[y * self._x + x]

func delete_value(x: int, y: int):
	put_value(x, y, null)
	array_content_updated.emit()

func clear():
	self._content.fill(null)
	array_content_updated.emit()

func get_width() -> int:
	return _x
	
func get_height() -> int:
	return _y
