extends NinePatchRect

var win_limit : Vector2 # Prevents window from going off screen
var win_offset : Vector2
var is_drag : bool = false

# When window becomes visible, center it, and set window limits
func _on_visibility_changed():
	if is_visible_in_tree():
		win_limit = get_viewport().content_scale_size
		position = (win_limit - size)/2

func _input(event : InputEvent) -> void:
	if event.is_action_released("ui_click"):
		is_drag = false
	
	if is_drag == true:
		if event is InputEventMouseMotion:
			position.x = clamp(event.position.x - win_offset.x,0,win_limit.x-size.x)
			position.y = clamp(event.position.y - win_offset.y,0,win_limit.y-size.y)

func _area2d_input(_viewport, event, _shape_idx):
	if event.is_action_pressed("ui_click"):
		is_drag = true
		win_offset = event.position - global_position

func _close_pressed():
	queue_free()
