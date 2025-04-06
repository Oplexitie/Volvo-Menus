extends NinePatchRect

@export var load_bar: ProgressBar

var win_limit : Vector2 # Prevents window from going off screen
var win_offset : Vector2
var is_drag : bool = false

func _ready() -> void:
	_on_resolution_change() 
	get_tree().root.size_changed.connect(_on_resolution_change) # Signal si la résolution change

func _physics_process(_delta: float) -> void:
	if is_drag == true:
		position.x = clamp(get_global_mouse_position().x - win_offset.x,0,win_limit.x-size.x)
		position.y = clamp(get_global_mouse_position().y - win_offset.y,0,win_limit.y-size.y)

func _on_tab_button_down() -> void:
	win_offset = get_global_mouse_position() - global_position
	is_drag = true

func _on_tab_button_up() -> void:
	is_drag = false

func _close_pressed() -> void:
	queue_free()

# When resolution changes, center it, and set window limits
func _on_resolution_change() -> void:
	win_limit = get_viewport().content_scale_size
	position = (win_limit - size)/2
