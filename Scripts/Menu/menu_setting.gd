extends TabContainer

signal win_fix

func _ready():
	$Display/Label_Resolution/OptionButton.selected = SaveSystem.save_display[0]
	$Display/Label_WinMode/OptionButton.selected = SaveSystem.save_display[1]
	$Graphics/Label_ResScale/HSlider.value = SaveSystem.save_graphics[0]

func _apply_button():
	match current_tab:
		0:
			_display_applied()
		1:
			_graphics_applied()
		2:
			pass

# DISPLAY TAB
func _display_applied():
	SaveSystem.save_display[0] = $Display/Label_Resolution/OptionButton.selected
	SaveSystem.save_display[1] = $Display/Label_WinMode/OptionButton.selected
	SaveSystem.save_settings()
	SaveSystem.apply_display_settings()

	emit_signal("win_fix")

# GRAPHICS TAB
func _graphics_applied():
	SaveSystem.save_graphics[0] = $Graphics/Label_ResScale/HSlider.value
	SaveSystem.save_settings()
	SaveSystem.apply_graphics_settings()
