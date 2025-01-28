class_name TableRow extends HBoxContainer

@onready var icon_texture = $IconTexture
@onready var name_label = $NameLabel
@onready var count_label = $HBoxContainer/CountLabel
@onready var income_label = $HBoxContainer/IncomeLabel
@onready var usage_label = $HBoxContainer/UsageLabel

@onready var arrow_up_icon = preload("res://assets/arrow_up_icon.png")
@onready var arrow_down_icon = preload("res://assets/arrow_down_icon.png")
@onready var empty_icon = preload("res://assets/empty_icon.png")
@onready var indicator_icon = $HBoxContainer/IndicatorIcon
@onready var game_state: GameState = preload("res://logic/resources/game_state.tres")
@onready var modifier_label = $HBoxContainer/ModifierLabel

var game_resource: GameResource

func _process(delta):
	if game_resource != null:
		var game_resource_duplicate = game_resource
		for modifier: Modifier in game_state.modifier:
			game_resource_duplicate = modifier.apply_modifier(game_resource_duplicate)
		if game_resource_duplicate.income > game_resource.income:
			modifier_label.text = "++"
		elif game_resource_duplicate.income == game_resource.income:
			modifier_label.text = "  "
		else:
			modifier_label.text = "--"
			
		icon_texture.texture = game_resource.icon
		name_label.text = game_resource.name
		count_label.text = str(game_resource_duplicate.count)
		income_label.text = "+" + str(game_resource_duplicate.income)
		usage_label.text = "-" + str(game_resource_duplicate.usage)
		if game_resource_duplicate.income == game_resource_duplicate.usage:
			indicator_icon.texture = empty_icon
		elif game_resource_duplicate.income > game_resource_duplicate.usage:
			indicator_icon.texture = arrow_up_icon
		else:
			indicator_icon.texture = arrow_down_icon


func _on_mouse_entered():
	TooltipContentElementSystem.game_resource = game_resource


func _on_mouse_exited():
	TooltipContentElementSystem.game_resource = null
