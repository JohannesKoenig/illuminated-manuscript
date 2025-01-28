class_name MultiplicationModifier extends Modifier

@export var multiplication_factor: float = 1

func apply_modifier(game_resource: GameResource) -> GameResource:
	if game_resource.name == self.target_resource:
		var game_resource_copy: GameResource = game_resource.duplicate()
		if target_value == "income":
			game_resource_copy.income *= multiplication_factor
		elif target_value == "count":
			game_resource_copy.count *= multiplication_factor
		elif target_value == "usage":
			game_resource_copy.usage *= multiplication_factor
		return game_resource_copy
	return game_resource
