extends Node

const SAVE_FILE_PATH = "res://settings.sav"

var save_data: Dictionary

func _ready() -> void:
	load_file()

func has_save() -> bool:
	return FileAccess.file_exists(SAVE_FILE_PATH)

func has_element(element: String) -> bool:
	return save_data.has(element) 

func set_element(element: String, data: Dictionary) -> void:
	if save_data.has(element):
		save_data[element].merge(data, true)
	else:
		save_data[element] = data

func get_element(element: String, data: String) -> Variant:
	if save_data.has(element) && save_data[element].has(data):
		return save_data[element][data]
	else:
		return null

func save_file() -> void:
	var file: FileAccess = FileAccess.open(SAVE_FILE_PATH, FileAccess.WRITE)
	
	file.store_var(save_data)
	file.close()

func load_file() -> void:
	if has_save():
		var file: FileAccess = FileAccess.open(SAVE_FILE_PATH, FileAccess.READ)
		var data: Dictionary = file.get_var()
		file.close()
		
		if (data is Dictionary):
			save_data = data
		else:
			printerr("Data is corrupt")
			save_file()
	else:
		printerr("No settings file available")
		save_file()
