class_name Letter extends Node3D

@onready var paper: MeshInstance3D = $Paper
@onready var collision_shape_3d = $StaticBody3D/CollisionShape3D
@onready var static_body_3d = $StaticBody3D

signal mouse_entered
signal mouse_exited
var mouse_inside: bool = false

@export var base_mesh: Mesh

@onready var letter_scene: PackedScene = preload("res://book/2D/letter_2d.tscn")
var letter_scene_instance: Letter2D

@onready var sub_viewport: SubViewport = $SubViewport


func _ready():
	var page_material = StandardMaterial3D.new()
	
	letter_scene_instance = letter_scene.instantiate()
	letter_scene_instance.task_completed.connect(queue_free)
	sub_viewport.add_child(letter_scene_instance)
	page_material.albedo_texture = sub_viewport.get_texture()

	# initialize mesh
	paper.mesh = base_mesh
	var collision_shape =  base_mesh.create_convex_shape(false)
	collision_shape_3d.shape = collision_shape
	
	
	paper.set_surface_override_material(0, page_material)

func _process(delta):
	pass
	
	#if mouse_inside:
		#var result = raycast_from_mouse()
		#if result != null:
			#if result.has("position"):
				#var mouse_position_3D = result["position"]
				#var unscaled = (mouse_position_3D - paper.global_position)
				#var unscaled_2d = Vector2(unscaled.x, unscaled.z)
				#var relative_position = unscaled_2d / base_mesh.size
				#var absolute_position = relative_position * Vector2(sub_viewport.size)
				#letter_scene_instance.set_mouse_position(absolute_position)
	
func _unhandled_input(event: InputEvent):
	if not mouse_inside:
		return
	var event_copy = event.duplicate()
	var result = raycast_from_mouse()
	if result != null:
		if result.has("position"):
			var mouse_position_3D = result["position"]
			var unscaled = (mouse_position_3D - paper.global_position)
			var unscaled_2d = Vector2(unscaled.x, unscaled.z)
			var relative_position = unscaled_2d / base_mesh.size
			var absolute_position = relative_position * Vector2(sub_viewport.size)
			var camera_offset = sub_viewport.size / 2.0
			event_copy.global_position = absolute_position + camera_offset
			event_copy.position = absolute_position + camera_offset
	sub_viewport.push_input(event_copy)

	
func set_page(task: Task):
	if letter_scene_instance:
		letter_scene_instance.queue_free()
	letter_scene_instance = letter_scene.instantiate() as Letter2D
	letter_scene_instance.task_completed.connect(queue_free)
	letter_scene_instance.task_resource = task
	sub_viewport.add_child(letter_scene_instance)


func _on_static_body_3d_mouse_entered():
	mouse_entered.emit()
	sub_viewport.notification(NOTIFICATION_VP_MOUSE_ENTER)
	mouse_inside = true


func _on_static_body_3d_mouse_exited():
	mouse_exited.emit()
	sub_viewport.notification(NOTIFICATION_VP_MOUSE_EXIT)
	mouse_inside = false

func raycast_from_mouse():
	var ray_length = 100
	var m_pos = get_viewport().get_mouse_position()
	var cam = get_viewport().get_camera_3d()
	var ray_start = cam.project_ray_origin(m_pos)
	var ray_end = ray_start + cam.project_ray_normal(m_pos) * ray_length
	var world3d : World3D = get_world_3d()
	var space_state = world3d.direct_space_state
	
	if space_state == null:
		return 
	
	var query = PhysicsRayQueryParameters3D.create(ray_start, ray_end)
	
	return space_state.intersect_ray(query)
