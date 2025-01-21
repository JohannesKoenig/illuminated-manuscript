class_name LetterStack extends Node3D

@onready var letter_scene: PackedScene = preload("res://book/letter.tscn")


func set_tasks(tasks: Array[Task]):
	_remove_children()
	for index in range(len(tasks)):
		var task = tasks[index]
		var letter_instance: Letter = letter_scene.instantiate()
		letter_instance.position.y = 0.1 * index
		letter_instance.rotate_y(randf_range(-0.15,0.15))
		add_child(letter_instance)
		letter_instance.set_page(task)
		
	
func _remove_children():
	for child in get_children().duplicate():
		child.queue_free()
		remove_child(child)
