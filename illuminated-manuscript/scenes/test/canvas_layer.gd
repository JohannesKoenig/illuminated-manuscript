extends CanvasLayer


@onready var gui_tooltip: GuiTooltip = $GuiTooltip
@onready var gui_resource_table_tooltip = $GuiResourceTableTooltip


# Called when the node enters the scene tree for the first time.
func _ready():
	TooltipContentElementSystem.content_element_prefab_changed.connect(_on_content_element_prefab_changed)
	TooltipContentElementSystem.show_tooltip_changed.connect(_on_show_tooltip_changed)
	TooltipContentElementSystem.game_resource_changed.connect(_on_game_resource_changed)
	TooltipContentElementSystem.show_tooltip_changed.connect(_on_show_tooltip_changed_resource_table)


func _on_content_element_prefab_changed(content_element_prefab: ContentElementPrefab):
	if content_element_prefab == null:
		gui_tooltip.visible = false
	gui_tooltip.set_content_element_prefab(content_element_prefab)
	var viewport = get_viewport()
	if viewport:
		gui_tooltip.position = viewport.get_mouse_position() - gui_tooltip.size

func _on_show_tooltip_changed(value: bool):
	if TooltipContentElementSystem.content_element_prefab == null:
		gui_tooltip.visible = false
		return
	if TooltipContentElementSystem.content_element_prefab.name == "content_element_resource_overview":
		gui_tooltip.visible = false
		return
	gui_tooltip.visible = value
	var viewport = get_viewport()
	if viewport:
		gui_tooltip.position = viewport.get_mouse_position() - Vector2(
			gui_tooltip.size.x,
			0
		)

func _on_game_resource_changed(game_resource: GameResource):
	if game_resource == null:
		gui_resource_table_tooltip.visible = false
	gui_resource_table_tooltip.set_game_resource(game_resource)
	var viewport = get_viewport()
	if viewport:
		gui_tooltip.position = viewport.get_mouse_position() - gui_tooltip.size

func _on_show_tooltip_changed_resource_table(value: bool):
	if TooltipContentElementSystem.game_resource == null:
		gui_resource_table_tooltip.visible = false
		return
	gui_resource_table_tooltip.visible = value
	var viewport = get_viewport()
	if viewport:
		gui_resource_table_tooltip.position = viewport.get_mouse_position() - Vector2(
			gui_resource_table_tooltip.size.x,
			0
		)
