extends Node

@onready var loading_scene : PackedScene = preload("res://Scenes/Menu/window_loadbar.tscn")

var cache : Array = []

func _ready():
	# adds sceme to cache
	#cache.push_back(load("res://Scenes/3dtest.tscn"))
	pass

func load_scene(viewport : Node, next_scene : String):
	# add loading scene to the root
	var loading_scene_instance = loading_scene.instantiate()
	$"/root/Node2D".call_deferred("add_child",loading_scene_instance)
	
	# deletes the prvious scene inside the viewport
	for n in viewport.get_children():
		n.queue_free()
	
	# find the targeted scene
	ResourceLoader.load_threaded_request(next_scene, "", true)
	
	var progress : Array = []
	while true:
		match ResourceLoader.load_threaded_get_status(next_scene, progress):
			0:
				print("ERROR, invalid scene !")
				return
			1:
				loading_scene_instance.get_node("ProgressBar").value = progress[0] * 100
			2:
				print("ERROR, loading failed for some reason !")
				return
			3:
				# creating scene instance from loaded data
				var scene = ResourceLoader.load_threaded_get(next_scene).instantiate()
				# adding scene to the root
				viewport.call_deferred("add_child",scene)
				# removing loading scene
				loading_scene_instance.queue_free()
				return
