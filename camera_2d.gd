extends Camera2D

@export var speed := 400

var dragging := false
var drag_origin := Vector2.ZERO
var drag_start := Vector2.ZERO

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT:
			if event.pressed:
				dragging = true
				drag_start = event.position  # screen position
			else:
				dragging = false

	elif event is InputEventMouseMotion and dragging:
		var delta = drag_start - event.position
		position += delta
		drag_start = event.position

func _process(delta):
	var move = Vector2.ZERO

	if Input.is_action_pressed("ui_right"):
		move.x += 1
	if Input.is_action_pressed("ui_left"):
		move.x -= 1
	if Input.is_action_pressed("ui_down"):
		move.y += 1
	if Input.is_action_pressed("ui_up"):
		move.y -= 1

	position += move.normalized() * speed * delta
