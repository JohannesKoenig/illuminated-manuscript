class_name ContentElementPrefabList extends VBoxContainer

var path: String = "res://book/model/prefabs/resources/"
@onready var list_item_packed_scene: PackedScene = preload("res://scenes/test/content_element_prefab_list_item.tscn")
# Called when the node enters the scene tree for the first time.
var prefab_paths: Array = [
	"res://book/model/prefabs/resources/content_element_basic_house.tres",
	"res://book/model/prefabs/resources/content_element_clay_mine.tres",
	"res://book/model/prefabs/resources/content_element_farmer.tres",
	"res://book/model/prefabs/resources/content_element_forager.tres",
	"res://book/model/prefabs/resources/content_element_forge.tres",
	"res://book/model/prefabs/resources/content_element_hunter.tres",
	"res://book/model/prefabs/resources/content_element_log_splitter.tres",
	"res://book/model/prefabs/resources/content_element_mine.tres",
	"res://book/model/prefabs/resources/content_element_pottery.tres",
	"res://book/model/prefabs/resources/content_element_quary.tres",
	"res://book/model/prefabs/resources/content_element_tailor.tres",
	"res://book/model/prefabs/resources/content_element_wood_cutter.tres",
]

func _ready():
	iterate_prefabs()


func iterate_prefabs():
	for file in prefab_paths:
		var resource: ContentElementPrefab = load(file)
		var list_item: ContentElementPrefabListItem = list_item_packed_scene.instantiate()
		list_item.content_element_prefab = resource
		add_child(list_item)
