extends ParallaxBackground

#@export var scroll_speed = 100.0
@export var camera_velocity = Vector2(0, 100)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#scroll_offset.y += scroll_speed * delta
	var new_offset = get_scroll_offset() + camera_velocity * delta
	set_scroll_offset(new_offset)
