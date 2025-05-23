extends Camera2D

@export var move_speed := 400.0
@export var zoom_speed := 4.0
@export var default_zoom := Vector2(1, 1)
@export var focus_zoom := Vector2(0.6, 0.6)

var target_position: Vector2
var target_zoom: Vector2

func _ready():
	make_current()
	target_position = global_position
	target_zoom = focus_zoom
	print("CAMERA READY - WorldMap")


func _process(delta):
	var move := Vector2.ZERO

	if Input.is_action_pressed("ui_right"):
		move.x += 1
	if Input.is_action_pressed("ui_left"):
		move.x -= 1
	if Input.is_action_pressed("ui_down"):
		move.y += 1
	if Input.is_action_pressed("ui_up"):
		move.y -= 1

	if move != Vector2.ZERO:
		global_position += move.normalized() * move_speed * delta
		target_position = global_position
		target_zoom = default_zoom

	global_position = global_position.lerp(target_position, 4.0 * delta)
	zoom = zoom.lerp(target_zoom, zoom_speed * delta)
