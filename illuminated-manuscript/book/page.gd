@tool
class_name Page extends Node3D

@onready var dragging_interaction_area_3d = $DraggingInteractionArea3D
@onready var mesh_instance_3d: MeshInstance3D = $PageRig/MeshInstance3D
@onready var page_rig: Node3D = $PageRig

@export var base_mesh: Mesh
@export var base_mesh_material: StandardMaterial3D
var base_array_mesh: ArrayMesh

@export_range(0, 1) var progress: float = 0.0
var _processed_progress: float
var mdt: MeshDataTool
var mesh: ArrayMesh

# Called when the node enters the scene tree for the first time.
func _ready():
	mesh_instance_3d.set_surface_override_material(0, base_mesh_material)
	# initialize mesh
	base_array_mesh = ArrayMesh.new()
	base_array_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, base_mesh.get_mesh_arrays())

	mesh_instance_3d.mesh = base_array_mesh
	mesh_instance_3d.scale = Vector3.ONE
	mesh = mesh_instance_3d.mesh
	mdt = MeshDataTool.new()
	mdt.create_from_surface(mesh, 0)
	
	for index in mdt.get_vertex_count():
		var vertex_position = mdt.get_vertex(index)
		var x = vertex_position.x
		var y = sqrt(1-pow((x/2+0.5), 2)) * 1.8
		var z = vertex_position.z
		var new_pos = Vector3(x,y,z)
		mdt.set_vertex(index, new_pos)
	mesh.clear_surfaces()
	mdt.commit_to_surface(mesh)

func _process(delta):
	if _processed_progress != progress:
		update_page_mesh(progress)
		_processed_progress = progress
	
func update_page_mesh(progress: float):
	# calculate stretch
	var stretch: Vector3 = Vector3.ONE
	if 0 <= progress and progress <= 0.5:
		stretch = lerp(Vector3(1,0,1), Vector3(0,1,1), progress * 2)
	else:
		stretch = lerp(Vector3(0,1,1), Vector3(-1,0,1), (progress -0.5)*2)

	page_rig.scale = stretch
	
