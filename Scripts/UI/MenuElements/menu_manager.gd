extends Control

var win_scene: NinePatchRect

@onready var win_lvl_select: PackedScene = preload("uid://bggnhfa4jbo5")
@onready var win_settings: PackedScene = preload("uid://dxhedkw2g6efa")

func _play_pressed() -> void:
	if win_scene:
		win_scene.queue_free()
	win_scene = win_lvl_select.instantiate()
	add_child(win_scene)

func _settings_pressed() -> void:
	if win_scene:
		win_scene.queue_free()
	win_scene = win_settings.instantiate()
	add_child(win_scene)

func _quit_pressed() -> void:
	get_tree().quit()
