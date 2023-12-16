extends Node2D

signal character_selected
signal reset

var obj_velocity = Vector2(0.0, 800.0)
var ups = [
	"res://score_down_objects/bear.tscn",
	"res://score_down_objects/mammoth.tscn",
	"res://score_down_objects/penguin.tscn",
	"res://score_down_objects/yeti.tscn"
]
var downs = [
	"res://score_up_objects/bananas.tscn",
	"res://score_up_objects/fish.tscn",
	"res://score_up_objects/gift.tscn",
	"res://score_up_objects/mandarin.tscn"
]
var spawn_locations = [
	Vector2(512.0, -100.0),
	Vector2(656.0, -100.0),
	Vector2(800.0, -100.0),
	Vector2(944.0, -100.0)
]
var up_spawn
var down_spawn
var up_hold
var down_hold
var location_hold

func _ready():
	$Music.play()
	$Menu.prompt_blinker()

func _process(delta):
	if Input.is_action_pressed("escape"):
		reset.emit()
	if Input.is_action_pressed("quit"):
		get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
		get_tree().quit()
	if Input.is_action_just_released("change_character"):
		if $Player/CoolGirl.is_visible():
			$Player/CoolGirl.hide()
			$Player/CoolGuy.show()
		else:
			$Player/CoolGuy.hide()
			$Player/CoolGirl.show()
	$Menu/Score.text = str(Global.score).pad_zeros(6)

func begin():
	$Menu/Title1.hide()
	$Menu/Title2.hide()
	Global.score = 0
	#$Menu/Score.text = str(Global.score).pad_zeros(6)
	$Menu/Score.show()
	$Player/CoolGirl.show()
	$Player.show()
	$StartDelay.start()
	await $StartDelay.timeout
	$UpTimer.start()

func restart():
	$UpTimer.stop()
	$DownTimer.stop()
	get_tree().call_group("damage", "queue_free")
	get_tree().call_group("food", "queue_free")
	$Menu/Score.hide()
	$Player.hide()
	if $Player/CoolGirl.is_visible():
		$Player/CoolGirl.hide()
	else:
		$Player/CoolGuy.hide()
	$Menu/Title1.show()
	$Menu/Title2.show()
	$Menu.prompt_blinker()

func _on_up_timer_timeout():
	$DownTimer.start()
	up_spawn = ups[randi() % ups.size()]
	if up_spawn == up_hold:
		up_spawn = ups[2]
	up_hold = up_spawn
	var up = load(up_spawn).instantiate()
	up.position = spawn_locations[randi() % spawn_locations.size()]
	if up.position == location_hold:
		if up.position != spawn_locations[1]:
			up.position = spawn_locations[1]
		else:
			up.position = spawn_locations[0]
	location_hold = up.position
	up.linear_velocity = obj_velocity
	add_child(up)

func _on_down_timer_timeout():
	$UpTimer.start()
	down_spawn = downs[randi() % downs.size()]
	if down_spawn == down_hold:
		down_spawn = downs[0]
	down_hold = down_spawn
	var down = load(down_spawn).instantiate()
	down.position = spawn_locations[randi() % spawn_locations.size()]
	if down.position == location_hold:
		if down.position != spawn_locations[3]:
			down.position = spawn_locations[3]
		else:
			down.position = spawn_locations[2]
	location_hold = down.position
	down.linear_velocity = obj_velocity
	down.add_to_group("damage")
	add_child(down)


func _on_cool_girl_body_entered(body):
	if $Player/CoolGirl.is_visible():
		body.hide()
		if body.is_in_group("damage"):
			$ScoreUp.play()
			Global.score += 10
		else:
			$ScoreDown.play()
			if Global.score - 10 > 0:
				Global.score -= 10
			else:
				Global.score = 0
		body.queue_free()

func _on_cool_guy_body_entered(body):
	if $Player/CoolGuy.is_visible():
		body.hide()
		if body.is_in_group("damage"):
			$ScoreUp.play()
			Global.score += 10
		else:
			$ScoreDown.play()
			if Global.score - 10 > 0:
				Global.score -= 10
			else:
				Global.score = 0
		body.queue_free()
