class_name ButtonWithTooltip extends Button

var content_element_prefab: ContentElementPrefab
@onready var gui_tooltip: PackedScene = preload("res://scenes/test/gui_tooltip.tscn")

func _make_custom_tooltip(for_text):
	if content_element_prefab:
		var gui_tooltip_instance: GuiTooltip = gui_tooltip.instantiate()
		gui_tooltip_instance.content_element_prefab = content_element_prefab
		gui_tooltip_instance.visible = true
		return gui_tooltip_instance
