class_name Task extends Resource

@export var task_name: String
@export var task_description: String

# Needs to be overriden by different task types
func can_be_completed(game_state: GameState) -> bool:
	return false


# Needs to be overriden by different task types
func complete(game_state: GameState):
	pass
