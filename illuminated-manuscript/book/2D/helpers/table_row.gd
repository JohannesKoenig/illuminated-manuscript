class_name TableRow extends HBoxContainer

@onready var icon_texture = $IconTexture
@onready var name_label = $NameLabel
@onready var count_label = $HBoxContainer/CountLabel
@onready var income_label = $HBoxContainer/IncomeLabel
@onready var usage_label = $HBoxContainer/UsageLabel

var game_resource: GameResource

func _process(delta):
	if game_resource != null:
		icon_texture.texture = game_resource.icon
		name_label.text = game_resource.name
		count_label.text = str(game_resource.count)
		income_label.text = "+" + str(game_resource.income)
		usage_label.text = "-" + str(game_resource.usage)
