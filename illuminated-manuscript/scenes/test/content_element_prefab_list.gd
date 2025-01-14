class_name ContentElementPrefabList extends VBoxContainer

var path: String = "res://book/model/prefabs/resources/"
@onready var list_item_packed_scene: PackedScene = preload("res://scenes/test/content_element_prefab_list_item.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	iterate_prefabs()


func iterate_prefabs():
	var files = DirAccess.get_files_at(path)
	for file in files:
		var resource: ContentElementPrefab = load(path + file)
		var list_item: ContentElementPrefabListItem = list_item_packed_scene.instantiate()
		list_item.content_element_prefab = resource
		add_child(list_item)
