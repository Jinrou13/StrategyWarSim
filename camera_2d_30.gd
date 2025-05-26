extends Camera2D

@export var move_speed := 8.0
@export var zoom_speed := 8.0
@export var default_zoom := Vector2(1, 1)
@export var focus_zoom := Vector2(4, 4) # ← higher number = zoomed in
@export var manual_speed := 400

var dragging := false
var drag_origin := Vector2.ZERO
var target_position := Vector2.ZERO
var target_zoom := Vector2.ONE
var manually_moved := false

func _ready():
	make_current()
	target_position = global_position
	target_zoom = zoom
	print("📸 Camera ready at:", global_position)

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT:
			dragging = event.pressed
			drag_origin = event.position
	elif event is InputEventMouseMotion and dragging:
		var delta = drag_origin - event.position
		global_position += delta
		drag_origin = event.position
		manually_moved = true
		target_zoom = default_zoom

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
		manually_moved = true
		global_position += move.normalized() * manual_speed * delta
		target_position = global_position
		target_zoom = default_zoom
	else:
		global_position = global_position.lerp(target_position, move_speed * delta)

	zoom = zoom.lerp(target_zoom, zoom_speed * delta)

func focus_on(pos: Vector2):
	print("Focusing camera on:", pos)
	manually_moved = false
	target_position = pos
	target_zoom = focus_zoom
