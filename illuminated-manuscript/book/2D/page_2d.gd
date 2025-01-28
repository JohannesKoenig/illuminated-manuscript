class_name Page2D extends Node2D

@export var page_content_resource: PageContentResource
@onready var page_number_l = $PageNumberL
@onready var page_number_r = $PageNumberR
@onready var content_element_grid_container: ContentElementGridContainer = $ContentElementGridContainer
@onready var mouse_pointer_shadow = $MousePointerShadow
@onready var game_state: GameState = preload("res://logic/resources/game_state.tres")
@onready var audio_stream_player = $AudioStreamPlayer

var mouse_inside: bool = false
var mouse_position: Vector2
var is_active: bool = false


func _ready():
	set_page_content_resource(page_content_resource)
	mouse_pointer_shadow.visible = false

func _process(delta):
	if (
		Input.is_action_just_pressed("Placement")
		and mouse_inside
		and is_active
		and DragAndDropClipboard.selected_content_element_prefab != null
	):
		var mouse_position_in_grid = mouse_position - content_element_grid_container.position
		var grid_index = floor(	mouse_position_in_grid / Vector2(200, 200))
		if (game_state.can_build(DragAndDropClipboard.selected_content_element_prefab.cost)
			and !content_element_grid_container.blocked_indices.has(Vector2(grid_index.x, grid_index.y))):
			game_state.pay_for(DragAndDropClipboard.selected_content_element_prefab.cost)
			page_content_resource.set_content_element(
				grid_index.y, 
				grid_index.x, 
				DragAndDropClipboard.selected_content_element_prefab
			)
			content_element_grid_container.set_content_elements(
				page_content_resource.content_elements.grid
			)
			audio_stream_player.play()
			var new_element = content_element_grid_container._content_element_group_2ds.get_value(grid_index.y, grid_index.x)
			new_element.on_placement()
		

func set_page_content_resource(page_content_resource: PageContentResource):
	if page_content_resource == null:
		return
	if page_content_resource.is_left():
		page_number_l.text = str(page_content_resource.page_number)
	else:
		page_number_r.text = str(page_content_resource.page_number)
	content_element_grid_container.set_content_elements(
		page_content_resource.content_elements.grid
	)

func mouse_enter():
	mouse_pointer_shadow.visible = true
	mouse_inside = true

func mouse_exit():
	mouse_pointer_shadow.visible = false
	mouse_inside = false

func set_mouse_position(mouse_pos: Vector2):
	mouse_pointer_shadow.position = mouse_pos
	mouse_position = mouse_pos
