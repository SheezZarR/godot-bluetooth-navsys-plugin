extends Node


var current_scene = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)

func switch_scene(scene_path: String) -> void:
	call_deferred("_deferred_switch_scene", scene_path)

func _deferred_switch_scene(scene_path: String) -> void:
	current_scene.free()
	var scene = ResourceLoader.load(scene_path)
	current_scene = scene.instantiate()
	get_tree().root.add_child(current_scene)
	get_tree().current_scene = current_scene
