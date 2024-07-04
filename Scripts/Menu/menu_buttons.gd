extends Control

var win_scene : NinePatchRect

@export var path_office_dark : NodePath

@onready var cam_stuff : Node = get_node(path_office_dark)

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if !Global.in_title:
			visible = !visible
			if is_instance_valid(win_scene): win_scene.visible = visible

func _play_pressed():
	if !is_instance_valid(win_scene):
		win_scene = load("res://Scenes/Menu/window_lvlseletect.tscn").instantiate()
		$"/root/Node2D".add_child(win_scene)

func _settings_pressed():
	if !is_instance_valid(win_scene):
		win_scene = load("res://Scenes/Menu/window_settings.tscn").instantiate()
		$"/root/Node2D".add_child(win_scene)

func _quit_pressed():
	get_tree().quit()