class_name Player extends Node2D

const MAX_SPEED = 300
const MIN_SPEED = 150
const ACCELERATION_MOD = 200
const STEERING_MOD = 200

const POINT_DISTANCE = 10
const SHAKE_DECAY_RATE = 5
const SHAKE_INTENSITY = 10

var speed: float
var last_speed: float
var direction_degrees: float
var last_point: Vector2

var shake_intensity: float = 0.0

@onready var head: Head = %Head
@onready var tail: Line2D = %Tail
@onready var camera: Camera2D = %Camera

@export var max_length: int = 200
@export var current_length: int = 5

func _ready():
	add_point(head.position)
	head.has_collected.connect(increase_length)

func increase_length():
	shake_intensity = SHAKE_INTENSITY
	if current_length < max_length:
		current_length += 1

func add_point(_position: Vector2):
	if last_point:
		if last_point.distance_to(_position) > POINT_DISTANCE:
			last_point = _position
			tail.add_point(_position)
			update_length()
	else:
		last_point = _position

func update_length():
	if tail.get_point_count() > current_length:
		tail.remove_point(0)

func _physics_process(delta):
	var acceleration = Input.get_axis("ui_down","ui_up")
	var steering = Input.get_axis("ui_left","ui_right")
	
	speed += acceleration * delta * ACCELERATION_MOD
	if speed > MAX_SPEED:
		speed = MAX_SPEED
	if speed < MIN_SPEED:
		speed = MIN_SPEED
	update_camera_zoom(speed)
	
	if shake_intensity > 0:
		shake_intensity = lerp(shake_intensity, 0.0, delta * SHAKE_DECAY_RATE)
		shake_camera(shake_intensity)
	
	direction_degrees += steering * delta * STEERING_MOD
	head.rotation_degrees = direction_degrees
	var direction: Vector2 = vector_from_degree(direction_degrees)
	var velocity = direction * speed * delta
	head.move_and_collide(velocity)
	add_point(head.position)

func update_camera_zoom(_speed: float):
	if last_speed == _speed:
		return
	last_speed = _speed
	var zoom = MAX_SPEED / _speed
	camera.zoom = Vector2(zoom,zoom)

func shake_camera(intensity: float):
	var shake_offset = Vector2(
		randf_range(-intensity, intensity),
		randf_range(-intensity, intensity))
	camera.offset = shake_offset

func vector_from_degree(angle_deg):
	var angle_rad = deg_to_rad(angle_deg)
	var x = cos(angle_rad)
	var y = sin(angle_rad)
	return Vector2(x, y)

