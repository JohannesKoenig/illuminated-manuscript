class_name Letter2D extends Control

@export var task_resource: Task
@onready var mouse_pointer_shadow = $MousePointerShadow
@onready var heading = $Heading
@onready var description = $Description
@onready var accept = $Accept
@onready var game_state: GameState = preload("res://logic/resources/game_state.tres")


var mouse_inside: bool = false
var mouse_position: Vector2
var is_active: bool = false

signal task_completed

# Called when the node enters the scene tree for the first time.
func _ready():
	set_task_content_resource(task_resource)
	mouse_pointer_shadow.visible = false


func set_task_content_resource(task: Task):
	if task == null:
		return
	heading.text = task.task_name
	description.text = task.task_description

func mouse_enter():
	mouse_pointer_shadow.visible = true
	mouse_inside = true

func mouse_exit():
	mouse_pointer_shadow.visible = false
	mouse_inside = false

#func set_mouse_position(mouse_pos: Vector2):
	##mouse_pointer_shadow.position = mouse_pos
	#mouse_position = mouse_pos
	#var accept_offset = accept.position - mouse_position
	#if (
		#mouse_position.x > accept.position.x 
		#and mouse_position.x < accept.position.x + accept.size.x
		#and mouse_position.y > accept.position.y 
		#and mouse_position.y < accept.position.y + accept.size.y
	#):
		#pass
		##if Input.is_action_just_pressed("Click"):
			##accept.button_down.emit()
			##accept.pressed.emit()
		##if Input.is_action_just_released("Click"):
			##accept.button_up.emit()

func _unhandled_input(event: InputEvent):
	if mouse_inside:
		mouse_pointer_shadow.position = event.position


func _on_accept_pressed():
	if task_resource.can_be_completed(game_state):
		task_resource.complete(game_state)
		task_completed.emit()

func _on_decline_pressed():
	print("decline")
