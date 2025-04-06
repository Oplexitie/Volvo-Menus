extends Node2D

var viewport: SubViewport
var ui_layer: CanvasLayer

@onready var loading_screen: PackedScene = preload("uid://se8ww4rck1oq") 
@onready var maps: Resource = preload("uid://bjas3mmobdpas")

func load_scene(next_scene: String) -> void:
	_erase_contents(ui_layer) # Deletes the previous scene inside the viewport
	_erase_contents(viewport) # Deletes the previous scene inside the viewport or UI from previous scene
	
	# Add loading scene to the Menu Layer
	var loading_scene_instance: NinePatchRect = loading_screen.instantiate()
	ui_layer.call_deferred("add_child",loading_scene_instance)
	
	ResourceLoader.load_threaded_request(maps.locations[next_scene], "", true)
	
	var progress: Array = []
	while true:
		match ResourceLoader.load_threaded_get_status(maps.locations[next_scene], progress):
			0:
				print("ERROR, invalid scene !")
				return
			1:
				loading_scene_instance.load_bar.value = progress[0] * 100
			2:
				print("ERROR, loading failed for some reason !")
				return
			3:
				var scene: Node = ResourceLoader.load_threaded_get(maps.locations[next_scene]).instantiate()
				
				# Remove loading screen
				if loading_scene_instance:
					loading_scene_instance.queue_free()
				
				viewport.call_deferred("add_child", scene)
				
				await scene.ready # Wait for game scene to be fully loaded
				
				if scene.ui_pack:
					var ui_pack: Control = scene.ui_pack.instantiate()
					ui_layer.call_deferred("add_child", ui_pack)
				
				return

func _erase_contents(parent: Node) -> void:
	for i in parent.get_children():
		i.queue_free()
