class_name Page2D extends Node2D

@export var page_content_resource: PageContentResource
@onready var page_number_l = $PageNumberL
@onready var page_number_r = $PageNumberR
@onready var content_element_grid_container = $ContentElementGridContainer
@onready var mouse_pointer_shadow = $MousePointerShadow

var mouse_inside: bool = false
var mouse_position: Vector2
var is_active: bool = false

# Called when the node enters the scene tree for the first time.
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
		var grid_index = mouse_position_in_grid / Vector2(200, 200)
		page_content_resource.set_content_element(
			grid_index.y, 
			grid_index.x, 
			DragAndDropClipboard.selected_content_element_prefab
		)
		content_element_grid_container.set_content_elements(
			page_content_resource.content_elements.grid
		)
		
		

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
