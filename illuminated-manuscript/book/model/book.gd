class_name Book extends Resource

@export var current_page: int = 1
@export var pages: Array[PageContentResource]
@export var game_state: GameState = preload("res://logic/resources/game_state.tres")

var total_number_of_pages: int

func has_page(page_number: int) -> bool:
	total_number_of_pages = len(pages) + len(game_state.countryside_pages)
	
	if page_number - 1 < total_number_of_pages:
		return true
	return false

func get_page_content_resource(page_number: int) -> PageContentResource:
	assert(has_page(page_number), "Page out of bounds.")
	if page_number - 1 < len(pages):
		return pages[page_number -1]
	if page_number - 1 < len(pages) + len(game_state.countryside_pages):
		return game_state.countryside_pages[page_number - len(pages) - 1]
	return
