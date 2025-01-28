class_name GuiResourceTableTooltip extends Control

@onready var game_state: GameState = preload("res://logic/resources/game_state.tres")
var game_resource: GameResource
@onready var label = $VBoxContainer/Label
@onready var v_box_container = $VBoxContainer/VBoxContainer
@onready var modifier_tooltip_element: PackedScene = preload("res://scenes/test/modifiers_tooltip_element.tscn")

func set_game_resource(game_resource: GameResource):
	if game_resource == null:
		return
	self.game_resource = game_resource
	label.text = game_resource.name
	for child in v_box_container.get_children():
		child.queue_free()
	for modifier: Modifier in game_state.modifier:
		if modifier.target_resource == game_resource.name:
			var modifier_tooltip_element_instance: ModifiersTooltipElement = modifier_tooltip_element.instantiate()
			modifier_tooltip_element_instance.modifier = modifier
			v_box_container.add_child(modifier_tooltip_element_instance)
