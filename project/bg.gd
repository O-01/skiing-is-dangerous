extends ParallaxBackground

@export var camera_velocity = Vector2(0, 100)

func _process(delta):
	var new_offset = get_scroll_offset() + camera_velocity * delta
	set_scroll_offset(new_offset)
