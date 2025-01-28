class_name ContentElementGroup2D extends Control

@export var content_element_prefab_resource: ContentElementPrefab
@onready var heading = $VBoxContainer/Heading
@onready var image = $Image
@onready var background = $Background
@onready var gui_tooltip: PackedScene = preload("res://scenes/test/gui_tooltip.tscn")
@onready var gpu_particles_2d = $Control/GPUParticles2D


func _ready():
	if heading != null:
		heading.text = content_element_prefab_resource.format_name()
	if image != null:
		var texture_from_resource: Texture = content_element_prefab_resource.texture
		image.position = Vector2(0, 200*content_element_prefab_resource.size.y - texture_from_resource.get_height())
		image.texture = content_element_prefab_resource.texture
	size = Vector2(
		200*content_element_prefab_resource.size.x,
		200*content_element_prefab_resource.size.y,
	)
	background.size = Vector2(
		200*content_element_prefab_resource.size.x,
		200*content_element_prefab_resource.size.y,
	)
	



func _on_mouse_entered():
	TooltipContentElementSystem.content_element_prefab = content_element_prefab_resource


func _on_mouse_exited():
	TooltipContentElementSystem.content_element_prefab = null

func on_placement():
	gpu_particles_2d.restart()
