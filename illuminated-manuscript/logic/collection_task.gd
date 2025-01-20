class_name CollectionTask extends Task

@export var requirementents: Dictionary

func can_be_completed(game_state: GameState) -> bool:
	for key in requirementents:
		var available = game_state.resources[key].count
		var needed = requirementents[key]
		if available < needed:
			return false
	return true


func complete(game_state: GameState):
	for key in requirementents:
		game_state.resources[key].count -= requirementents[key]
