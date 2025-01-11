class_name Page2D extends Node2D

@export var page_content_resource: PageContentResource
@onready var page_number_l = $PageNumberL
@onready var page_number_r = $PageNumberR
@onready var content_element_grid_container = $ContentElementGridContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	set_page_content_resource(page_content_resource)


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
