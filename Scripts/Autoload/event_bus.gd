extends Node2D

func add_signal(s_name: StringName, s_callable: Callable) -> void:
	if !has_user_signal(s_name):
		add_user_signal(s_name)
	connect(s_name,s_callable)

func remove_signal(s_name: StringName, s_callable: Callable) -> void:
	if has_user_signal(s_name):
		if is_connected(s_name, s_callable):
			disconnect(s_name,s_callable)
