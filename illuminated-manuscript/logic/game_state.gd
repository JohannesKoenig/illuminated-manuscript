class_name GameState extends Resource

@export var year: int:
	set(new_value):
		update_resources()
		year = new_value

@export var resources: Dictionary
@export var countryside_pages: Array[PageContentResource]

func initialize():
	for countryside_page in countryside_pages:
		countryside_page.content_updated.connect(update_income)
	update_income()

func update_resources():
	for resource_key in resources:
		var resource: GameResource = resources[resource_key]
		resource.count = resource.count + resource.income - resource.usage

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
