extends CanvasLayer

enum { WINDOWED, FULLSCREEN }

var resolutions: Resource = preload("uid://cdw5ynly8ceiy")

func _ready() -> void:
	_initialize_signals()
	_initialize_save()
	apply_display_settings()

func _initialize_signals() -> void:
	EventBus.add_signal("apply_resolution", apply_display_settings)
	EventBus.add_signal("apply_graphics", apply_graphics_settings)

func _initialize_save() -> void:
	if SaveManager.has_element("Settings") == false:
		SaveManager.set_element("Settings", {"res_option": 0})
		SaveManager.set_element("Settings", {"win_option": 0})
		SaveManager.set_element("Settings", {"scale_option": 0})

func apply_display_settings() -> void:
	var target_res: Vector2i = resolutions.size[SaveManager.get_element("Settings", "res_option")]
	
	match SaveManager.get_element("Settings", "win_option"):
		WINDOWED:
			if target_res >= DisplayServer.screen_get_size():
				DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
			else:
				DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
			DisplayServer.window_set_size(target_res)
		FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
	
	get_viewport().content_scale_size = target_res
	apply_graphics_settings()

func apply_graphics_settings() -> void:
	var graphics_scale: float = 1 + SaveManager.get_element("Settings", "scale_option") / 2
	
	$SubViewportContainer/SubViewport.size = ceil(resolutions.size[SaveManager.get_element("Settings", "res_option")] / graphics_scale)
	$SubViewportContainer.scale = Vector2(graphics_scale,graphics_scale)
