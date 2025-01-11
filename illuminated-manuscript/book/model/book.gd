class_name Book extends Resource

@export var current_page: int = 1
@export var pages: Array[PageContentResource]

func has_page(page_number: int) -> bool:
	if page_number - 1 < len(pages):
		return true
	return false

func get_page_content_resource(page_number: int) -> PageContentResource:
	assert(has_page(page_number), "Page out of bounds.")
	return pages[page_number -1]
