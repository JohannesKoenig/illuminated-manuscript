extends Node

@onready var game_state: GameState = preload("res://logic/resources/game_state.tres")

func _ready():
	game_state.initialize()
