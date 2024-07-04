extends Node

var display_list : Array = [
	Vector2(1280,720),
	Vector2(1920,1080),
	Vector2(2560,1440),
	Vector2(3840,2160),
	Vector2(2560,1080),
	Vector2(3440,1440)
]

# Settings Save
var save_display : Array = [0,0]
var save_graphics : Array = [0,0]
var save_audio : Array = [0,0]

func _ready():
	load_settings()
	apply_display_settings()

func save_settings():
	var file = FileAccess.open("settings.dat", FileAccess.WRITE)
	
	var savecontain : Dictionary = {
		"save_display": save_display,
		"save_graphics": save_graphics,
		"save_audio": save_audio
	}
	
	file.store_var(savecontain)
	file.close()

func load_settings():
	if(FileAccess.file_exists("settings.dat")):
		var file = FileAccess.open("settings.dat", FileAccess.READ)
		var data = file.get_var()
		file.close()
		
		if (typeof(data) == TYPE_DICTIONARY):
			save_display = data["save_display"]
			save_graphics = data["save_graphics"]
			save_audio = data["save_audio"]
		else:
			printerr("Data is corrupt")
			save_settings()
	else:
		printerr("No settings file available")
		save_settings()

func apply_display_settings():
	match save_display[1] :
		0:
			get_window().borderless = false
			get_window().mode = Window.MODE_WINDOWED
			get_window().size = display_list[save_display[0]]
		1:
			get_window().borderless = true
			get_window().mode = Window.MODE_MAXIMIZED
			get_window().borderless = true
	
	get_viewport().content_scale_size = display_list[save_display[0]]
	apply_graphics_settings()

func apply_graphics_settings():
	var graphics_scale : float = 1 + save_graphics[0] / 2
	
	$"../Node2D/Control/SubViewportContainer/SubViewport".size = ceil(display_list[save_display[0]] / graphics_scale)
	$"../Node2D/Control/SubViewportContainer".scale = Vector2(graphics_scale,graphics_scale)
