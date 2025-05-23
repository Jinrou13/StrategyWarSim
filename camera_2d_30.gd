extends Camera2D

@export var move_speed := 6.0             # Speed of smooth focus movement
@export var manual_speed := 400.0         # Speed of manual WASD movement
@export var zoom_speed := 10.0            # Speed of zoom lerp
@export var default_zoom := Vector2(1, 1) # Normal zoom
@export var focus_zoom := Vector2(0.75, 0.75) # Zoom when focusing a country

var dragging := false
var drag_origin := Vector2.ZERO
var target_position := Vector2.ZERO
var target_zoom := Vector2.ONE
var manually_moved := false

func _ready():
	make_current()
	target_position = global_position
	target_zoom = zoom
	print("📸 Camera is ready")
	print("→ Path:", get_path())
	print("→ In scene tree:", is_inside_tree())
	print("→ Zoom:", zoom)

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
	print("Focusing on:", pos)
	manually_moved = false
	target_position = pos
	target_zoom = focus_zoom
