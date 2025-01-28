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
	var index = x * self._x + y
	if index > len(self._content):
		return
	self._content[x * self._x + y] = value
	array_content_updated.emit()

func get_value(x: int, y: int):
	var index = x * self._x + y
	if index > len(self._content):
		return
	return self._content[y * self._x + x]

func delete_value(x: int, y: int):
	var index = x * self._x + y
	if index > len(self._content):
		return
	put_value(x, y, null)
	array_content_updated.emit()

func clear():
	self._content.fill(null)
	array_content_updated.emit()

func get_width() -> int:
	return _x
	
func get_height() -> int:
	return _y

func has_value(x: int, y: int)-> bool:
	var index = x * self._x + y
	if index > len(self._content):
		return false
	return get_value(x, y) != null
