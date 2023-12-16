extends Area2D

@export var speed = 1000

func _process(delta):
	var velocity = Vector2.ZERO

	$AnimatedSprite2D.play()

	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_right"):
		velocity.x += 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		
	position += velocity * delta

	position.x = clamp(position.x, 512, 950)
	position.y = clamp(position.y, 660, 660)
