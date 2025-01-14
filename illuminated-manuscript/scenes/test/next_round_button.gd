class_name NextRoundButton extends Button

var game_state_resource: GameState = preload("res://logic/resources/game_state.tres")

# Called when the node enters the scene tree for the first time.
func _ready():
	pressed.connect(_on_pressed)


func _on_pressed():
	game_state_resource.year += 1
