class_name GuiResourceElement extends HBoxContainer

var resource_name: String
var resource_count: int

@onready var label = $Label
@onready var texture_rect = $TextureRect

# Called when the node enters the scene tree for the first time.
func _ready():
	label.text = str(resource_count)
	var formatted_resource_name = resource_name.to_lower().replace(" ", "_")
	texture_rect.texture = load("res://assets/" + formatted_resource_name + "_icon.png")
