extends CenterContainer

@export var lvl_option: OptionButton

func _lvl_selected() -> void:
	match lvl_option.selected:
		0:
			ThreadLoad.load_scene("3dtest")
		1:
			ThreadLoad.load_scene("3dtest2")
