extends CSGBox3D

@export var speed: int = 1

func _physics_process(delta) -> void:
	rotation.x += delta * speed
