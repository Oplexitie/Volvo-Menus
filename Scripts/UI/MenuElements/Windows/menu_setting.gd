extends TabContainer

@export_subgroup("Display")
@export var res_options: OptionButton
@export var win_options: OptionButton
@export_subgroup("Graphics")
@export var slider: Slider

func _ready() -> void:
	res_options.selected = SaveManager.get_element("Settings", "res_option")
	win_options.selected = SaveManager.get_element("Settings", "win_option")
	slider.value = SaveManager.get_element("Settings", "scale_option")

func _apply_button() -> void:
	match current_tab:
		0:
			_display_applied()
		1:
			_graphics_applied()
		2:
			pass

# DISPLAY TAB
func _display_applied() -> void:
	SaveManager.set_element("Settings", {"res_option": res_options.selected})
	SaveManager.set_element("Settings", {"win_option": win_options.selected})
	SaveManager.save_file()
	EventBus.emit_signal("apply_resolution")

# GRAPHICS TAB
func _graphics_applied() -> void:
	SaveManager.set_element("Settings", {"scale_option": slider.value})
	SaveManager.save_file()
	EventBus.emit_signal("apply_graphics")
