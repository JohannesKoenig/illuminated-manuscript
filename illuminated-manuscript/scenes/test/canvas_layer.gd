extends CanvasLayer


@onready var gui_tooltip: GuiTooltip = $GuiTooltip

# Called when the node enters the scene tree for the first time.
func _ready():
	TooltipContentElementSystem.content_element_prefab_changed.connect(_on_content_element_prefab_changed)
	TooltipContentElementSystem.show_tooltip_changed.connect(_on_show_tooltip_changed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_content_element_prefab_changed(content_element_prefab: ContentElementPrefab):
	gui_tooltip.set_content_element_prefab(content_element_prefab)
	var viewport = get_viewport()
	if viewport:
		gui_tooltip.position = viewport.get_mouse_position() - gui_tooltip.size

func _on_show_tooltip_changed(value: bool):
	if TooltipContentElementSystem.content_element_prefab == null:
		gui_tooltip.visible = false
		return
	gui_tooltip.visible = value
	var viewport = get_viewport()
	if viewport:
		gui_tooltip.position = viewport.get_mouse_position() - Vector2(
			gui_tooltip.size.x,
			0
		)
