class_name GameState extends Resource

@export var year: int:
	set(new_value):
		update_resources()
		year = new_value

@export var resources: Dictionary


func update_resources():
	for resource_key in resources:
		var resource: GameResource = resources[resource_key]
		resource.count = resource.count + resource.income - resource.usage
