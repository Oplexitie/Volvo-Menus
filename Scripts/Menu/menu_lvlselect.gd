extends Node2D

@onready var lvl_option : OptionButton = $OptionButton

func _lvl_selected():
	match lvl_option.selected:
		0:
			ThreadLoad.load_scene($"/root/Node2D/Control/SubViewportContainer/SubViewport", "res://Scenes/3dtest.tscn")
		1:
			ThreadLoad.load_scene($"/root/Node2D/Control/SubViewportContainer/SubViewport", "res://Scenes/3dtest2.tscn")
	$"../../LVL_Select_Window".queue_free()
	$"/root/Node2D/UI/Menu_Buttons".visible = false
	Global.in_title = false
