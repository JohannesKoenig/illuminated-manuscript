extends Node3D

@export var book: Book
@onready var game_state: GameState = preload("res://logic/resources/game_state.tres")
@onready var previous_page: Page = $PreviousPage
@onready var current_page_l: Page = $CurrentPageL
@onready var current_page_r: Page = $CurrentPageR
@onready var next_page: Page = $NextPage
@onready var sun = $DirectionalLight3D


@onready var right_drag_start_area_3d = $RightDragStartArea3D
@onready var left_drag_start_area_3d = $LeftDragStartArea3D

@onready var letter = $Letter


var looking_up: bool = false
var looking_book: bool = true

var _mouse_in_right_drag_area: bool = false
var _mouse_in_left_drag_area: bool = false

var _left_dragging: bool = false
var _right_dragging: bool = false
var _was_dragging_l: bool = false
var _was_dragging_r: bool = false

var duration: float = 5
var _start_time: float
var camera_base_rotation: Vector3
var _camera_base_rotation_down: Vector3
var _camera_base_rotation_up: Vector3
var camera_base_position: Vector3
var _camera_base_position_book: Vector3
var _camera_base_position_letters: Vector3

# Called when the node enters the scene tree for the first time.
func _ready():
	_start_time = Time.get_unix_time_from_system()
	load_page(book.current_page)
	camera_base_rotation = get_viewport().get_camera_3d().rotation
	_camera_base_rotation_down = camera_base_rotation
	_camera_base_rotation_up = camera_base_rotation + Vector3(1.5,0,0)
	camera_base_position = get_viewport().get_camera_3d().position
	_camera_base_position_book = camera_base_position
	_camera_base_position_letters = camera_base_position + Vector3(9, 0, 0)
	game_state.year_changed.connect(load_tasks)
	load_tasks()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	sun.rotate_z(0.01 * delta)
	if looking_up:
		camera_base_rotation = _camera_base_rotation_up
	else:
		camera_base_rotation = _camera_base_rotation_down
	if looking_book:
		camera_base_position = _camera_base_position_book
	else:
		camera_base_position = _camera_base_position_letters
	current_page_l.right_page_scene_instance.is_active = true
	current_page_r.left_page_scene_instance.is_active = true
	var mouse_position = get_viewport().get_mouse_position()
	var left_drag_center = get_viewport().get_camera_3d().unproject_position(left_drag_start_area_3d.position)
	var right_drag_center = get_viewport().get_camera_3d().unproject_position(right_drag_start_area_3d.position)
	get_viewport().get_camera_3d().position = lerp(get_viewport().get_camera_3d().position, camera_base_position, delta * 2)
	var dist_from_left = max(0,mouse_position.x - left_drag_center.x)
	var dist_from_right = max(0,right_drag_center.x - mouse_position.x)
	var max_dist = right_drag_center.x - left_drag_center.x
	var progress_from_left = clamp(dist_from_left / max_dist, 0.01, 0.99)
	var progress_from_right = clamp(dist_from_right / max_dist, 0.01, 0.99)
	if Input.is_action_just_pressed("Dragging"):
		if _mouse_in_left_drag_area:
			_left_dragging = true
			_was_dragging_l = true
		if _mouse_in_right_drag_area:
			_right_dragging = true
			_was_dragging_r = true
	if Input.is_action_just_released("Dragging"):
		_left_dragging = false
		_right_dragging = false
	
	if _left_dragging:
		current_page_l.progress = progress_from_left
	else:
		if _was_dragging_l and progress_from_left > 0.55:
			book.current_page = max(1, book.current_page - 2)
			load_page(book.current_page)
		_was_dragging_l = false
		current_page_l.progress = 0.01
	
	if _right_dragging:
		current_page_r.progress = progress_from_left
	else:
		if _was_dragging_r and progress_from_left < 0.45:
			book.current_page = min(book.total_number_of_pages, book.current_page + 2)
			load_page(book.current_page)
		_was_dragging_r = false
		current_page_r.progress = 0.99
	
	var middled = mouse_position / Vector2(get_window().content_scale_size) - Vector2(0.5, 0.5)
	var distance_from_middle = middled.length()
	var camera = get_viewport().get_camera_3d()
	var target_rotation = camera_base_rotation
	if distance_from_middle > 0.4:
		target_rotation = camera_base_rotation + Vector3( -0.1 * distance_from_middle * middled.y, 0, -0.1 * distance_from_middle * middled.x)
	camera.rotation = lerp(camera.rotation, target_rotation, delta * 3)

func load_page(page_number: int):
	assert(page_number > 0, "Page number has to be greater than 0.")
	if page_number % 2 == 0:
		load_page(page_number - 1)
	
	if page_number > 2:
		_set_right_page_content(previous_page, page_number - 2)
		_set_left_page_content(current_page_l, page_number - 1)
	_set_right_page_content(current_page_l, page_number)
	_set_left_page_content(current_page_r, page_number + 1)
	_set_right_page_content(current_page_r, page_number + 2)
	_set_left_page_content(next_page, page_number + 3)
	
	
		
func _set_right_page_content(page: Page, page_number: int):
	if book.has_page(page_number):
		page.set_right_page(book.get_page_content_resource(page_number))

func _set_left_page_content(page: Page, page_number: int):
	if book.has_page(page_number):
		page.set_left_page(book.get_page_content_resource(page_number))
	

func on_right_page_drag_started():
	pass


func _on_right_drag_start_area_3d_mouse_entered():
	_mouse_in_right_drag_area = true


func _on_right_drag_start_area_3d_mouse_exited():
	_mouse_in_right_drag_area = false


func _on_left_drag_start_area_3d_mouse_entered():
	_mouse_in_left_drag_area = true


func _on_left_drag_start_area_3d_mouse_exited():
	_mouse_in_left_drag_area = false


func _on_up_pressed():
	looking_up = true


func _on_down_pressed():
	looking_up = false


func _on_left_pressed():
	looking_book = true


func _on_right_pressed():
	looking_book = false

func load_tasks():
	for task in game_state.tasks	:
		letter.set_page(task)
	
