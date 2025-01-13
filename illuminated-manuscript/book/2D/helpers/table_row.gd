@tool
extends HBoxContainer

@export var texture: Texture
@export var item_name: String
@export var item_count: int
@export var item_income: int
@export var item_usage: int

@onready var icon_texture = $IconTexture
@onready var name_label = $NameLabel
@onready var count_label = $HBoxContainer/CountLabel
@onready var income_label = $HBoxContainer/IncomeLabel
@onready var usage_label = $HBoxContainer/UsageLabel

func _ready():
	icon_texture.texture = texture
	name_label.text = item_name
	count_label.text = str(item_count)
	income_label.text = "+" + str(item_income)
	usage_label.text = "-" + str(item_usage)
