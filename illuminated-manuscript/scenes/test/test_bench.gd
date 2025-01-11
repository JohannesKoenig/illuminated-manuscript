extends Node3D

@export var book: Book
@onready var previous_page: Page = $PreviousPage
@onready var current_page: Page = $CurrentPage
@onready var next_page: Page = $NextPage


var duration: float = 5
var _start_time: float

# Called when the node enters the scene tree for the first time.
func _ready():
	_start_time = Time.get_unix_time_from_system()
	load_page(book.current_page)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var _current_time = Time.get_unix_time_from_system()
	var progress = _current_time - _start_time
	var normalized_progress = progress / duration
	current_page.progress = clamp(1- normalized_progress, 0.01, 0.99)
	if progress > duration:
		_start_time = _current_time
		book.current_page += 2
		load_page(book.current_page)

func load_page(page_number: int):
	assert(page_number > 0, "Page number has to be greater than 0.")
	if page_number % 2 == 0:
		load_page(page_number - 1)
	_set_right_page_content(previous_page, page_number)
	_set_left_page_content(current_page, page_number + 1)
	_set_right_page_content(current_page, page_number + 2)
	_set_left_page_content(next_page, page_number + 3)
	
	
		
func _set_right_page_content(page: Page, page_number: int):
	if book.has_page(page_number):
		page.set_right_page(book.get_page_content_resource(page_number))

func _set_left_page_content(page: Page, page_number: int):
	if book.has_page(page_number):
		page.set_left_page(book.get_page_content_resource(page_number))
	
