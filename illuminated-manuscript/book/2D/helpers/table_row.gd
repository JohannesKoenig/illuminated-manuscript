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


var game_resource: GameResource

func _process(delta):
	if game_resource != null:
		icon_texture.texture = game_resource.icon
		name_label.text = game_resource.name
		count_label.text = str(game_resource.count)
		income_label.text = "+" + str(game_resource.income)
		usage_label.text = "-" + str(game_resource.usage)
		if game_resource.income == game_resource.usage:
			indicator_icon.texture = empty_icon
		elif game_resource.income > game_resource.usage:
			indicator_icon.texture = arrow_up_icon
		else:
			indicator_icon.texture = arrow_down_icon
