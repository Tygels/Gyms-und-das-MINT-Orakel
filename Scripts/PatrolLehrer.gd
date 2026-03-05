extends CharacterBody2D

@export var speed: float = 60.0
@export var move_time_min: float = 0.8
@export var move_time_max: float = 2.0
@export var idle_time_min: float = 0.5
@export var idle_time_max: float = 1.5

var move_timer: float = 0.0
var current_direction: Vector2 = Vector2.ZERO
var is_moving: bool = false


func _ready():	
	randomize()
	_choose_new_state()


func _physics_process(delta):

	move_timer -= delta
	
	if move_timer <= 0:
		_choose_new_state()

	if is_moving:
		velocity = current_direction * speed
	else:
		velocity = Vector2.ZERO

	move_and_slide()

	# 🔥 WALL DETECTION
	if is_moving and is_on_wall():
		_choose_new_direction()


func _choose_new_state():
	is_moving = !is_moving
	
	if is_moving:
		_choose_new_direction()
		move_timer = randf_range(move_time_min, move_time_max)
	else:
		move_timer = randf_range(idle_time_min, idle_time_max)


func _choose_new_direction():
	var directions = [
		Vector2.LEFT,
		Vector2.RIGHT,
		Vector2.UP,
		Vector2.DOWN,
		Vector2(1, 1),
		Vector2(-1, 1),
		Vector2(1, -1),
		Vector2(-1, -1)
	]
	
	current_direction = directions[randi() % directions.size()].normalized()
