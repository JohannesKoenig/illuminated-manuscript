class_name GiftTask extends Task

@export var gifts: Dictionary

func can_be_completed(game_state: GameState) -> bool:
	return true


func complete(game_state: GameState):
	for key in gifts:
		game_state.resources[key].count += gifts[key]
