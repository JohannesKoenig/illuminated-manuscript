class_name GameState extends Resource

@export var year: int:
	set(new_value):
		update_resources()
		year_changed.emit()
		year = new_value

@export var resources: Dictionary
@export var countryside_pages: Array[PageContentResource]
@export var tasks: Array[Task]
@export var modifier: Array

signal year_changed

func initialize():
	for countryside_page in countryside_pages:
		countryside_page.content_updated.connect(update_income)
		countryside_page.content_updated.connect(update_usage)
	update_income()
	update_usage()

func update_resources():
	for resource_key in resources:
		var resource: GameResource = resources[resource_key]
		var resource_duplicate = resource
		for modifier_resource: Modifier in modifier:
			resource_duplicate = modifier_resource.apply_modifier(resource_duplicate)
		resource.count = resource_duplicate.count + resource_duplicate.income - resource_duplicate.usage

func update_income():
	for resource_key in resources:
		resources[resource_key].income = 0
	for countryside_page: PageContentResource in countryside_pages:
		var grid = countryside_page.content_elements.grid
		for i in range(grid.get_width()):
			for j in range(grid.get_height()):
				var content_element = grid.get_value(i,j)
				if content_element is ContentElementPrefab:
					for resource in content_element.income:
						if resources.has(resource):
							resources[resource].income += content_element.income[resource]

func update_usage():
	for resource_key in resources:
		resources[resource_key].usage = 0
	for countryside_page: PageContentResource in countryside_pages:
		var grid = countryside_page.content_elements.grid
		for i in range(grid.get_width()):
			for j in range(grid.get_height()):
				var content_element = grid.get_value(i,j)
				if content_element is ContentElementPrefab:
					for resource in content_element.usage:
						if resources.has(resource):
							resources[resource].usage += content_element.usage[resource]

func can_build(costs: Dictionary):
	for key in costs:
		var cost = costs[key]
		if cost > resources[key].count:
			return false
	return true

func pay_for(costs: Dictionary):
	for key in costs:
		var cost = costs[key]
		resources[key].count -= cost
