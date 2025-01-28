class_name ContentElementResourceOverview extends ContentElementGroup2D

@onready var game_state: GameState = preload("res://logic/resources/game_state.tres")
@onready var label = $Label
@onready var table_row: PackedScene = preload("res://book/2D/helpers/table_row.tscn")
@onready var v_box_container = $VBoxContainer2


func _ready():
	for resource_key in game_state.resources:
		var table_row_instance: TableRow = table_row.instantiate()
		table_row_instance.game_resource = game_state.resources[resource_key]
		v_box_container.add_child(table_row_instance)
		

func _process(_delta):
	label.text = "Rohstoffvorrat im Jahr " + str(game_state.year)
