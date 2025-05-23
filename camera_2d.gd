extends Camera2D

@export var move_speed := 6.0
@export var zoom_speed := 20.0
@export var default_zoom := Vector2(1, 1)
@export var focus_zoom := Vector2(0.6, 0.6)
@export var manual_speed := 400

var dragging := false
var drag_origin := Vector2.ZERO
var target_position: Vector2
var target_zoom: Vector2
var manually_moved := false

func _ready():
	make_current()  # <--- RIGHT HERE
	target_position = global_position
	target_zoom = zoom
