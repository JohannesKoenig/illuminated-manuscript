class_name Page extends Node3D

@onready var left_side: MeshInstance3D = $PageRig/LeftPageRig/LeftSide
@onready var right_side: MeshInstance3D = $PageRig/RightPageRig/RightSide
@onready var left_page_rig: Node3D = $PageRig/LeftPageRig
@onready var right_page_rig: Node3D = $PageRig/RightPageRig

@export var base_mesh: Mesh
@export var left_page_scene: PackedScene
@export var right_page_scene: PackedScene

var left_page_scene_instance: Page2D
var right_page_scene_instance: Page2D

@onready var left_viewport: Viewport = $LeftViewport
@onready var right_viewport: Viewport = $RightViewport

var base_array_mesh: ArrayMesh

@export_range(0, 1) var progress: float = 0.0
var _processed_progress: float
var mdt: MeshDataTool
var mesh: ArrayMesh

func _ready():
	var left_side_material = StandardMaterial3D.new()
	var right_side_material = StandardMaterial3D.new()
	
	left_page_scene_instance = left_page_scene.instantiate()
	left_viewport.add_child(left_page_scene_instance)
	
	right_page_scene_instance = right_page_scene.instantiate()
	right_viewport.add_child(right_page_scene_instance)
	
	if left_viewport:
		left_side_material.albedo_texture = left_viewport.get_texture()
	if right_viewport:
		right_side_material.albedo_texture = right_viewport.get_texture()

	# initialize mesh
	left_side.mesh = calculate_mesh_bend(base_mesh, false)
	left_side.scale = Vector3(1,-1,1)
	
	right_side.mesh = calculate_mesh_bend(base_mesh, true)
	right_side.scale = Vector3.ONE
	
	left_side.set_surface_override_material(0, left_side_material)
	right_side.set_surface_override_material(0, right_side_material)

func _process(delta):
	if _processed_progress != progress:
		update_page_mesh(progress)
		_processed_progress = progress
	
func update_page_mesh(progress: float):
	
	# calculate stretch
	var stretch: Vector3 = Vector3.ONE
	if 0 <= progress and progress <= 0.5:
		left_side.mesh = calculate_mesh_bend(base_mesh, false)
		left_side.scale = Vector3(1,-1,1)
		
		right_side.mesh = calculate_mesh_bend(base_mesh, true)
		right_side.scale = Vector3.ONE
		stretch = lerp(Vector3(1,0,1), Vector3(0,1,1), progress * 2)
	else:
		left_side.mesh = calculate_mesh_inverse_bend(base_mesh, false)
		left_side.scale = Vector3(1,-1,1)
		
		right_side.mesh = calculate_mesh_inverse_bend(base_mesh, true)
		right_side.scale = Vector3.ONE
		stretch = lerp(Vector3(0,1,1), Vector3(-1,0,1), (progress -0.5)*2)

	right_page_rig.scale = stretch
	left_page_rig.scale = stretch
	
func calculate_mesh_bend(mesh: Mesh, up: bool):
	var array_mesh = ArrayMesh.new()
	array_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, mesh.get_mesh_arrays())

	mdt = MeshDataTool.new()
	mdt.create_from_surface(array_mesh, 0)
	for index in mdt.get_vertex_count():
		var vertex_position = mdt.get_vertex(index)
		var x = vertex_position.x
		var y = sqrt(1-pow((x/2+0.5), 2)) * 2
		if not up:
			y *= -1
		var z = vertex_position.z
		var new_pos = Vector3(x,y,z)
		mdt.set_vertex(index, new_pos)
	array_mesh.clear_surfaces()
	mdt.commit_to_surface(array_mesh)
	return array_mesh

func calculate_mesh_inverse_bend(mesh: Mesh, up: bool):
	var array_mesh = ArrayMesh.new()
	array_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, mesh.get_mesh_arrays())

	mdt = MeshDataTool.new()
	mdt.create_from_surface(array_mesh, 0)
	for index in mdt.get_vertex_count():
		var vertex_position = mdt.get_vertex(index)
		var x = vertex_position.x
		var y = sqrt(1-pow(1-(x/2+0.5), 2)) * 2
		if not up:
			y *= -1
		var z = vertex_position.z
		var new_pos = Vector3(-x,y,z)
		mdt.set_vertex(index, new_pos)
		mdt.set_vertex_normal(index, mdt.get_vertex_normal(index).inverse())
	array_mesh.clear_surfaces()
	mdt.commit_to_surface(array_mesh)
	return array_mesh
	
func set_left_page(page_content_resource: PageContentResource):
	left_page_scene_instance.queue_free()
	left_page_scene_instance = left_page_scene.instantiate() as Page2D
	left_page_scene_instance.page_content_resource = page_content_resource
	left_viewport.add_child(left_page_scene_instance)
	
func set_right_page(page_content_resource: PageContentResource):
	right_page_scene_instance.queue_free()
	right_page_scene_instance = right_page_scene.instantiate() as Page2D
	right_page_scene_instance.page_content_resource = page_content_resource
	right_viewport.add_child(right_page_scene_instance)
